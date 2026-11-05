import 'package:flutter_test/flutter_test.dart';
import 'package:auto_passport/main.dart';

void main() {
  testWidgets('AutoPassportApp boots up successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const AutoPassportApp());
    await tester.pump();

    expect(find.byType(AutoPassportApp), findsOneWidget);
  });
}
