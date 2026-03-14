import 'package:flutter_test/flutter_test.dart';

import 'package:anxiaoxin_flutter_codex/app/app.dart';

void main() {
  testWidgets('renders login page shell', (WidgetTester tester) async {
    await tester.pumpWidget(const AnXiaoXinApp());
    await tester.pumpAndSettle();

    expect(find.text('登录'), findsOneWidget);
    expect(find.text('验证码登录  >>'), findsOneWidget);
    expect(find.text('找回密码'), findsOneWidget);
  });
}
