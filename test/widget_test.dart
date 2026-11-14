
import 'package:flutter_test/flutter_test.dart';
import 'package:designmaster_flutter_ui/main.dart';

void main() {
  testWidgets('DesignMaster app launches successfully',
      (WidgetTester tester) async {
    await tester.pumpWidget(const DesignMasterApp());

    expect(find.byType(DesignMasterApp), findsOneWidget);
    expect(find.byType(MainNavigationScreen), findsOneWidget);
  });
}
