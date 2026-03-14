import 'package:flutter_test/flutter_test.dart';

import 'package:anxiaoxin_flutter_codex/app/app.dart';

void main() {
  testWidgets('renders bootstrap home shell', (WidgetTester tester) async {
    await tester.pumpWidget(const AnXiaoXinApp());
    await tester.pumpAndSettle();

    expect(find.text('安小信 Flutter 基座'), findsOneWidget);
    expect(find.text('共享应用壳层'), findsOneWidget);
    expect(find.text('多端宿主准备'), findsOneWidget);
  });
}
