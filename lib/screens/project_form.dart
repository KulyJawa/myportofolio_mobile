import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../models/project.dart';
import '../providers/auth_state.dart';
import '../services/api_client.dart';
import '../utils/auth_guard.dart';
import '../widgets/left_drawer.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _projectName = '';
  String _description = '';
  String _technologies = '';
  String _projectLink = '';
  String _imageUrl = '';

  bool _isSubmitting = false;
  String? _errorMessage;

  InputDecoration _decoration(String label, String hint) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      border: const OutlineInputBorder(),
    );
  }

  String? _requiredText(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Kolom ini wajib diisi.';
    }
    return null;
  }

  String? _validateUrl(String? value, {bool optional = false}) {
    final text = value?.trim() ?? '';

    if (text.isEmpty) {
      return optional ? null : 'URL proyek wajib diisi.';
    }

    final uri = Uri.tryParse(text);

    if (uri == null ||
        !uri.hasAuthority ||
        uri.host.isEmpty ||
        (uri.scheme != 'http' && uri.scheme != 'https')) {
      return 'Masukkan URL lengkap dengan http:// atau https://.';
    }

    return null;
  }

  Future<void> _submitForm() async {
    if (_isSubmitting || !_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    final auth = context.read<AuthState>();
    final api = context.read<ApiClient>();

    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });

    try {
      final loggedIn = await ensureLoggedIn(context);

      if (!mounted || !loggedIn) return;

      final token = auth.token;

      if (token == null) {
        setState(() {
          _errorMessage = 'Silakan login terlebih dahulu.';
        });
        return;
      }

      final project = Project(
        title: _projectName,
        description: _description,
        techStack: _technologies,
        projectUrl: _projectLink,
        projectImageUrl: _imageUrl,
      );

      final savedProject = await api.createProject(project, token: token);

      if (!mounted) return;

      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) {
          return AlertDialog(
            title: const Text('Proyek berhasil disimpan!'),
            content: SingleChildScrollView(
              child: Text(
                'Nama: ${savedProject.title}\n\n'
                'Deskripsi: ${savedProject.description}\n\n'
                'Teknologi: ${savedProject.techStack}\n\n'
                'URL: ${savedProject.projectUrl}',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );

      if (!mounted) return;

      _formKey.currentState!.reset();
      _projectName = '';
      _description = '';
      _technologies = '';
      _projectLink = '';
      _imageUrl = '';
    } on ApiException catch (error) {
      if (error.statusCode == 401) {
        try {
          await auth.logout();
        } catch (_) {
          // AuthState tetap menghapus token lokal.
        }
      }

      if (!mounted) return;

      setState(() {
        if (error.statusCode == 401) {
          _errorMessage =
              'Login sudah tidak valid. Tekan Simpan untuk login kembali.';
        } else if (error.statusCode == 403) {
          _errorMessage =
              'Akun ini tidak memiliki izin. Gunakan akun superuser Django.';
        } else {
          _errorMessage = error.message;
        }
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _errorMessage =
            'Belum dapat memastikan penyimpanan. Periksa koneksi dan '
            'daftar proyek sebelum mencoba lagi.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Proyek'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      drawer: _isSubmitting ? null : const LeftDrawer(),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  enabled: !_isSubmitting,
                  maxLength: 255,
                  decoration: _decoration(
                    'Nama Proyek',
                    'Contoh: Aplikasi Portofolio',
                  ),
                  validator: _requiredText,
                  onSaved: (value) {
                    _projectName = value!.trim();
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  enabled: !_isSubmitting,
                  maxLines: 5,
                  decoration: _decoration(
                    'Deskripsi',
                    'Jelaskan proyek yang kamu buat',
                  ),
                  validator: _requiredText,
                  onSaved: (value) {
                    _description = value!.trim();
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  enabled: !_isSubmitting,
                  maxLength: 255,
                  decoration: _decoration(
                    'Teknologi',
                    'Contoh: Flutter, Dart, Django',
                  ),
                  validator: _requiredText,
                  onSaved: (value) {
                    _technologies = value!.trim();
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  enabled: !_isSubmitting,
                  maxLength: 500,
                  keyboardType: TextInputType.url,
                  decoration: _decoration(
                    'URL Proyek',
                    'https://github.com/username/repository',
                  ),
                  validator: (value) => _validateUrl(value),
                  onSaved: (value) {
                    _projectLink = value!.trim();
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  enabled: !_isSubmitting,
                  maxLength: 500,
                  keyboardType: TextInputType.url,
                  decoration: _decoration(
                    'URL Gambar (opsional)',
                    'https://example.com/gambar.png',
                  ),
                  validator: (value) {
                    return _validateUrl(value, optional: true);
                  },
                  onSaved: (value) {
                    _imageUrl = value?.trim() ?? '';
                  },
                ),
                if (_errorMessage != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    _errorMessage!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitForm,
                  child: Text(_isSubmitting ? 'Menyimpan...' : 'Simpan'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
