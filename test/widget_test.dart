import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:praktix/app.dart';
import 'package:praktix/data/services/local_storage_service.dart';
import 'package:praktix/presentation/providers/providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('App launches and shows splash screen', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final storage = await LocalStorageService.create();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [localStorageProvider.overrideWithValue(storage)],
        child: const PraktixApp(),
      ),
    );

    // Initial frame shows splash
    expect(find.text('Praktix'), findsOneWidget);

    // Advance past splash timer to avoid pending timer assertion
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();
  });
}
