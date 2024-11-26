import 'package:elms/providers/module_provider.dart';
import 'package:elms/providers/subject_provider.dart';
import 'package:elms/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // Provider for checking subject list url
        ChangeNotifierProvider(
          create: (context) => SubjectsProvider(),
        ),
        // Provider for checking  module and video list url
        ChangeNotifierProvider(
          create: (context) => ModulesProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
