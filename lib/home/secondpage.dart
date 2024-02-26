import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  String name;
  String phone;
  SecondPage({required this.name, required this.phone, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second"),
      ),
      body: Center(
        child: Text("$name  pppp  $phone"),
      ),
    );
  }
}
