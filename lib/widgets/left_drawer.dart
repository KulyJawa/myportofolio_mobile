import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/screens/project_list.dart';
import 'package:provider/provider.dart';
import 'package:myportofolio_mobile/providers/auth_state.dart';
import 'package:myportofolio_mobile/screens/login.dart';
import 'package:myportofolio_mobile/utils/auth_guard.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthState>();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.indigo),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Portfolio',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Explore personal projects and experiences!',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            onTap: () {
              final navigator = Navigator.of(context);
              navigator.pop();
              navigator.pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => MyHomePage()),
                (route) => false,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.folder_open),
            title: const Text('Lihat Proyek'),
            onTap: () {
              final navigator = Navigator.of(context);
              navigator.pop();
              navigator.push(
                MaterialPageRoute(builder: (_) => const ProjectListPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: const Text('Add Project'),
            onTap: () async {
              final navigator = Navigator.of(context);
              navigator.pop();

              final loggedIn = await ensureLoggedIn(navigator.context);

              if (!navigator.mounted || !loggedIn) return;

              navigator.push(
                MaterialPageRoute(builder: (_) => const ProjectFormPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.work_outline),
            title: const Text('Add Experience'),
            onTap: () {
              final navigator = Navigator.of(context);
              navigator.pop();
              navigator.push(
                MaterialPageRoute(
                  builder: (context) => const ExperienceFormPage(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(auth.isLoggedIn ? Icons.logout : Icons.login),
            title: Text(auth.isLoggedIn ? 'Logout' : 'Login'),
            onTap: () async {
              final navigator = Navigator.of(context);
              final messenger = ScaffoldMessenger.of(context);

              navigator.pop();

              if (auth.isLoggedIn) {
                try {
                  await auth.logout();

                  if (!messenger.mounted) return;

                  messenger.showSnackBar(
                    const SnackBar(content: Text('Berhasil logout.')),
                  );
                } catch (_) {
                  if (!messenger.mounted) return;

                  messenger.showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Login lokal sudah dihapus, tetapi logout '
                        'ke server gagal. Silakan login dan coba lagi.',
                      ),
                    ),
                  );
                }
              } else {
                final success = await navigator.push<bool>(
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                );

                if (success == true && messenger.mounted) {
                  messenger.showSnackBar(
                    const SnackBar(content: Text('Berhasil login.')),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
