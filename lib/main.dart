import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'checkLogin.dart';
import 'thema.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Sadece portrait kullanılacak.
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Go Turkish Food',
      theme: myTheme,
      home: CheckLogin(),
    );
  }
}
