import 'package:flutter/material.dart';
import 'package:whowin/ui/number_picker_655_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vietlott Checker',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const NumberPicker655Screen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
