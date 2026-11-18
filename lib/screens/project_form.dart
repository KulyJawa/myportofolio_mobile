import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _projectName = '';
  String _description = '';
  String _category = 'Web Development';
  String _technologies = '';
  String _projectLink = '';

  final List<String> _categories = [
    'Web Development',
    'Mobile Development',
    'Machine Learning',
    'Data Science',
    'Other',
  ];

  InputDecoration _inputDecoration(String label, String hint) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
    );
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Menjalankan onSaved pada setiap field.
    _formKey.currentState!.save();

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Proyek berhasil ditambahkan!'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nama Proyek: $_projectName'),
                const SizedBox(height: 8),
                Text('Deskripsi: $_description'),
                const SizedBox(height: 8),
                Text('Kategori: $_category'),
                const SizedBox(height: 8),
                Text(
                  'Teknologi: '
                  '${_technologies.isEmpty ? "-" : _technologies}',
                ),
                const SizedBox(height: 8),
                Text('Tautan: ${_projectLink.isEmpty ? "-" : _projectLink}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                // Mengosongkan input dan mengembalikan kategori awal.
                _formKey.currentState!.reset();

                _projectName = '';
                _description = '';
                _category = 'Web Development';
                _technologies = '';
                _projectLink = '';
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Project Form'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nama proyek wajib diisi.
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  decoration: _inputDecoration(
                    'Nama Proyek',
                    'Masukkan nama proyek',
                  ),
                  onSaved: (value) {
                    _projectName = value?.trim() ?? '';
                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nama proyek tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
              ),

              // Deskripsi wajib diisi.
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  maxLines: 5,
                  decoration: _inputDecoration(
                    'Deskripsi Proyek',
                    'Jelaskan proyek yang kamu buat',
                  ),
                  onSaved: (value) {
                    _description = value?.trim() ?? '';
                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Deskripsi proyek tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
              ),

              // Kategori memiliki nilai awal.
              Padding(
                padding: const EdgeInsets.all(8),
                child: DropdownButtonFormField<String>(
                  initialValue: 'Web Development',
                  isExpanded: true,
                  decoration: _inputDecoration(
                    'Kategori Proyek',
                    'Pilih kategori proyek',
                  ),
                  items: _categories.map((category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    _category = value ?? 'Web Development';
                  },
                  onSaved: (value) {
                    _category = value ?? 'Web Development';
                  },
                ),
              ),

              // Teknologi bersifat opsional.
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  decoration: _inputDecoration(
                    'Teknologi yang Digunakan',
                    'Contoh: Flutter, Django, Figma',
                  ),
                  onSaved: (value) {
                    _technologies = value?.trim() ?? '';
                  },
                ),
              ),

              // Tautan proyek bersifat opsional.
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  keyboardType: TextInputType.url,
                  decoration: _inputDecoration(
                    'Tautan Proyek',
                    'URL proyek (opsional)',
                  ),
                  onSaved: (value) {
                    _projectLink = value?.trim() ?? '';
                  },
                ),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: _submitForm,
                    child: const Text('Save'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
