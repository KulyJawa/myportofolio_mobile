import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _endDateController = TextEditingController();

  String _title = '';
  String _description = '';
  String _category = 'full-time';
  String _thumbnail = '';
  DateTime? _endedAt;

  final Map<String, String> _categories = const {
    'internship': 'Internship',
    'research': 'Research',
    'volunteer': 'Volunteer',
    'part-time': 'Part-Time',
    'full-time': 'Full-Time',
    'freelance': 'Freelance',
  };

  @override
  void dispose() {
    _endDateController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }

  InputDecoration _decoration(String label, String hint) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      border: const OutlineInputBorder(),
      alignLabelWithHint: true,
    );
  }

  String? _validateThumbnail(String? value) {
    final text = value?.trim() ?? '';

    // Thumbnail boleh kosong sesuai model Django.
    if (text.isEmpty) {
      return null;
    }

    if (text.length > 200) {
      return 'URL thumbnail maksimal 200 karakter.';
    }

    final uri = Uri.tryParse(text);
    const schemes = {'http', 'https', 'ftp', 'ftps'};

    if (uri == null ||
        !schemes.contains(uri.scheme.toLowerCase()) ||
        uri.host.isEmpty ||
        RegExp(r'\s').hasMatch(text)) {
      return 'Masukkan URL lengkap, misalnya https://example.com/foto.jpg';
    }

    return null;
  }

  Future<void> _pickEndDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _endedAt ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100, 12, 31),
      helpText: 'Pilih tanggal selesai',
    );

    if (!mounted || selectedDate == null) {
      return;
    }

    setState(() {
      _endedAt = selectedDate;
      _endDateController.text = _formatDate(selectedDate);
    });
  }

  void _submitForm() {
    final form = _formKey.currentState;

    // Dialog hanya ditampilkan jika semua validator lolos.
    if (form == null || !form.validate()) {
      return;
    }

    form.save();
    FocusScope.of(context).unfocus();

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Ringkasan Experience'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Judul: $_title'),
                const SizedBox(height: 12),
                Text('Deskripsi: $_description'),
                const SizedBox(height: 12),
                Text('Kategori: ${_categories[_category]}'),
                const SizedBox(height: 12),
                Text(
                  'Thumbnail: '
                  '${_thumbnail.isEmpty ? "Tidak diisi" : _thumbnail}',
                ),
                const SizedBox(height: 12),
                Text(
                  'Tanggal selesai: '
                  '${_endedAt == null ? "Masih berlangsung" : _formatDate(_endedAt!)}',
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Experience'),
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
      ),
      drawer: const LeftDrawer(),
      body: SafeArea(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Ceritakan pengalamanmu',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Isi judul, deskripsi, dan kategori. '
                  'Thumbnail serta tanggal selesai bersifat opsional.',
                ),
                const SizedBox(height: 24),
                TextFormField(
                  decoration: _decoration(
                    'Judul Experience',
                    'Contoh: Flutter Developer Intern',
                  ),
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.next,
                  maxLength: 255,
                  validator: (value) {
                    final text = value?.trim() ?? '';
                    if (text.isEmpty) {
                      return 'Judul tidak boleh kosong atau hanya spasi.';
                    }
                    if (text.length > 255) {
                      return 'Judul maksimal 255 karakter.';
                    }
                    return null;
                  },
                  onSaved: (value) => _title = value!.trim(),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: _decoration(
                    'Deskripsi',
                    'Jelaskan kegiatan dan tanggung jawabmu',
                  ),
                  keyboardType: TextInputType.multiline,
                  minLines: 4,
                  maxLines: 6,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Deskripsi tidak boleh kosong atau hanya spasi.';
                    }
                    return null;
                  },
                  onSaved: (value) => _description = value!.trim(),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  initialValue: _category,
                  isExpanded: true,
                  decoration: _decoration(
                    'Kategori',
                    'Pilih kategori pengalaman',
                  ),
                  items: _categories.entries.map((entry) {
                    return DropdownMenuItem<String>(
                      value: entry.key,
                      child: Text(entry.value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _category = value);
                    }
                  },
                  validator: (value) {
                    if (!_categories.containsKey(value)) {
                      return 'Pilih kategori yang tersedia.';
                    }
                    return null;
                  },
                  onSaved: (value) => _category = value!,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: _decoration(
                    'URL Thumbnail (opsional)',
                    'https://example.com/foto.jpg',
                  ),
                  keyboardType: TextInputType.url,
                  textInputAction: TextInputAction.done,
                  autocorrect: false,
                  maxLength: 200,
                  validator: _validateThumbnail,
                  onSaved: (value) => _thumbnail = value?.trim() ?? '',
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _endDateController,
                  readOnly: true,
                  onTap: _pickEndDate,
                  decoration: InputDecoration(
                    labelText: 'Tanggal selesai (opsional)',
                    hintText: 'Ketuk untuk memilih tanggal',
                    helperText: 'Kosongkan jika masih berlangsung.',
                    helperMaxLines: 2,
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.calendar_month),
                    suffixIcon: _endedAt == null
                        ? null
                        : IconButton(
                            tooltip: 'Kosongkan tanggal',
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                _endedAt = null;
                                _endDateController.clear();
                              });
                            },
                          ),
                  ),
                ),
                const SizedBox(height: 28),
                ElevatedButton.icon(
                  onPressed: _submitForm,
                  icon: const Icon(Icons.save_outlined),
                  label: const Text('Simpan'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary,
                    foregroundColor: colors.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
