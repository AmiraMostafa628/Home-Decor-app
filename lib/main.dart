import 'package:decor/core/services/app_initializer/app_initializer.dart';
import 'package:flutter/material.dart';
import 'package:decor/feature/layout/app_layout.dart';

Future<void> main()async {
  await initializeApp();
  runApp(const AppLayout());
}
