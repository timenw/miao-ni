import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MiaoNiApp());
}

class MiaoNiApp extends StatelessWidget {
  const MiaoNiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '猫匿',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(child: Text('猫匿 - 即将上线', style: TextStyle(fontSize: 24))),
      ),
    );
  }
}