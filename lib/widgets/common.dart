import 'package:flutter/material.dart';

var name = "";
showReusableSnackBar(BuildContext context, String title) {
  SnackBar snackBar = SnackBar(
    backgroundColor: Colors.cyan,
    duration: const Duration(seconds: 5),
    content: Text(
      title.toString(),
      style: const TextStyle(
        fontSize: 36,
        color: Colors.white,
      ),
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

class ErrorDialog extends StatelessWidget {
  final String? message;
  ErrorDialog({this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Text(message!),
      actions: [
        ElevatedButton(
          child: Text("OK"),
          style: ElevatedButton.styleFrom(
            shadowColor: Colors.red,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

class BoxTextField extends StatefulWidget {
  final TextEditingController controller;
  final validator;
  final bool obsecure;

  final TextInputType keyboardType;
  final icon;
  final String label;

  BoxTextField({
    required this.controller,
    this.validator,
    required this.keyboardType,
    required this.obsecure,
    required this.label,
    this.icon,
  });

  @override
  State<BoxTextField> createState() => _BoxTextFieldState();
}

class _BoxTextFieldState extends State<BoxTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: TextFormField(
          style: TextStyle(color: Colors.grey.shade400),
          autofocus: false,
          obscureText: widget.obsecure,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            prefixIcon: widget.icon,
            prefixIconColor: Colors.grey,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.grey.shade400)),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  style: BorderStyle.solid, color: Colors.grey.shade400),
            ),
            labelText: widget.label,
            labelStyle: TextStyle(color: Colors.grey.shade400),
          ),
          controller: widget.controller,
          validator: widget.validator),
    );
  }
}
