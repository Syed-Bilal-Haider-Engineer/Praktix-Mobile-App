import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';
import 'data/services/local_storage_service.dart';
import 'presentation/providers/providers.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set system UI overlay style for status bar
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  // Initialize local storage (like reading from localStorage on app boot)
  final storage = await LocalStorageService.create();

  runApp(
    ProviderScope(
      overrides: [
        // Inject the initialized storage instance into Riverpod
        localStorageProvider.overrideWithValue(storage),
      ],
      child: const PraktixApp(),
    ),
  );
}
