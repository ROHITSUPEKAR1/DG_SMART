import 'package:flutter_test/flutter_test.dart';
import 'package:school_manager/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const DGSmartApp());
    expect(find.byType(DGSmartApp), findsOneWidget);
  });
}
