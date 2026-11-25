// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/screens/login.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';

void main() {
  testWidgets('Tambah proyek meminta login jika belum masuk', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    final tambahProyek = find.text('Tambah Proyek');
    expect(tambahProyek, findsOneWidget);

    await tester.ensureVisible(tambahProyek);
    await tester.tap(tambahProyek);
    await tester.pumpAndSettle();

    expect(find.byType(LoginPage), findsOneWidget);
    expect(find.byType(ProjectFormPage), findsNothing);
  });
}
