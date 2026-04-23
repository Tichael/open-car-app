import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:open_car_app/main.dart';

void main() {
  testWidgets('Dashboard smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: OpenCarApp()));
    await tester.pump();

    expect(find.text('Open Car'), findsOneWidget);
  });
}
