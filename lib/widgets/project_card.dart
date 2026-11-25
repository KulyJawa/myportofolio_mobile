import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../providers/auth_state.dart';
import '../screens/menu.dart';
import '../screens/project_form.dart';
import '../screens/experience_form.dart';
import '../utils/auth_guard.dart';

class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  Future<void> _handleTap(BuildContext context) async {
    if (item.name == 'Tambah Proyek') {
      final loggedIn = await ensureLoggedIn(context);

      if (!context.mounted || !loggedIn) return;

      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ProjectFormPage()),
      );
      return;
    }

    if (item.name == 'Tambah Experience') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ExperienceFormPage()),
      );
      return;
    }

    if (item.name == 'Logout') {
      final auth = context.read<AuthState>();
      final messenger = ScaffoldMessenger.of(context);

      if (!auth.isLoggedIn) {
        messenger.showSnackBar(
          const SnackBar(content: Text('Kamu belum login.')),
        );
        return;
      }

      String message;

      try {
        await auth.logout();
        message = 'Berhasil logout.';
      } catch (_) {
        message = 'Login lokal sudah dihapus, tetapi logout ke server gagal.';
      }

      if (!messenger.mounted) return;

      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(message)));
      return;
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text('Kamu telah menekan tombol ${item.name}!')),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _handleTap(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, color: Colors.white, size: 30),
                const SizedBox(height: 6),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
