import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:objai/presentation/screens/home_screen.dart';
import 'package:objai/main.dart';

void main() {
  testWidgets('SnapFactsApp renders the initial screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: SnapFactsApp(),
      ),
    );

    expect(find.text('SnapFacts'), findsOneWidget);
    expect(find.byType(HomeScreen), findsOneWidget);
  });
}