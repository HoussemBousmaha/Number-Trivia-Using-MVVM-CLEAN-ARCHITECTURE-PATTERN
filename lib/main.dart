import 'package:flutter/material.dart';

import 'core/app/app.dart';
import 'core/dependency_intjection/dependency_injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();

  runApp(const NumberTriviaApp());
}
