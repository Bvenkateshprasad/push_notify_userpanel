import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../home/homemain.dart';
import '../widgets/common.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var email = "";
  var password = "";

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //function for user login
  userLogin() async {
    showDialog(
        context: context,
        builder: (c) {
          return const CircularProgressIndicator();
        });
    User? currentUser;
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    )
        .then((auth) {
      currentUser = auth.user;
    }).catchError((error) {
      Navigator.pop(context);
      if (error.code == "user-not-found") {
        showReusableSnackBar(context, "No User Found for this Email");
      } else if (error.code == "wrong-password") {
        showReusableSnackBar(context, "Wrong Password");
      } else {
        showDialog(
            context: context,
            builder: (c) {
              return ErrorDialog(
                message: error.message.toString(),
              );
            });
      }
    });
    if (currentUser != null) {
      readDataAndSetDataLocally(currentUser!);
      // Navigator.pop(context);
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(builder: (context) => HomePageMain()
      //         // VerifyEmail(),
      //         ));
    }
  }

  Future readDataAndSetDataLocally(User currentUser) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (c) => HomePage()));
      } else {
        FirebaseAuth.instance.signOut();
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => const LoginScreen()));

        showDialog(
            context: context,
            builder: (c) {
              return ErrorDialog(
                message: "No record found.",
              );
            });
      }
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Form(
          key: _formKey,
          child: Column(children: [
            BoxTextField(
              controller: emailController,
              label: "Email",
              keyboardType: TextInputType.emailAddress,
              obsecure: false,
              icon: const Icon(Icons.email_outlined),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter Email";
                } else if (!value.contains("@")) {
                  return "Please Enter Valid Email";
                }
                return null;
              },
            ),
            BoxTextField(
              controller: passwordController,
              label: "Password",
              keyboardType: TextInputType.emailAddress,
              obsecure: true,
              icon: const Icon(Icons.password_outlined),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter Password";
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    email = emailController.text;
                    password = passwordController.text;
                  });
                  userLogin();
                }
              },
              child: const Text("   Login"),
            ),
            const SizedBox(
              height: 8,
            ),
          ])),
    ));
  }
}
