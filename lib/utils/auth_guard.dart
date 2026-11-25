import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../providers/auth_state.dart';
import '../screens/login.dart';

Future<bool> ensureLoggedIn(BuildContext context) async {
  final auth = context.read<AuthState>();

  if (auth.isLoggedIn) {
    return true;
  }

  final success = await Navigator.of(context)
      .push<bool>(MaterialPageRoute(builder: (_) => const LoginPage()));

  return success == true && auth.isLoggedIn;
}
