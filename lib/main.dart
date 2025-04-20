import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talent_trail/app.dart';
import 'package:talent_trail/providers/auth_provider.dart';
import 'package:talent_trail/providers/job_provider.dart';
import 'package:talent_trail/providers/application_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => JobProvider()),
        ChangeNotifierProvider(create: (_) => ApplicationProvider()),
      ],
      child: const TalentTrailApp(),
    ),
  );
}