import 'package:flutter_test/flutter_test.dart';
import 'package:sututeh_app/main.dart' as app;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Prueba inicial simulada', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    expect(find.text('Bienvenido'), findsOneWidget);
  });
}
