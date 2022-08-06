// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_app/firebase_services/auth.dart';
import 'package:instagram_app/screens/register.dart';
import 'package:instagram_app/shared/colors.dart';
import 'package:instagram_app/shared/contants.dart';
import 'package:instagram_app/shared/snackbar.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isVisable = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  signIn() async {
    setState(() {
      isLoading = true;
    });

    await AuthMethods().signIn(
        emailll: emailController.text,
        passworddd: passwordController.text,
        context: context);

    setState(() {
      isLoading = false;
    });

    if (!mounted) return;
    showSnackBar(context, "successfully sign-in ☺");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    // final googleSignInProvider = Provider.of<GoogleSignInProvider>(context);
    return Scaffold(
        backgroundColor: mobileBackgroundColor,
        appBar: AppBar(
          // backgroundColor: appbarGreen,
          title: Text("Sign in"),
        ),
        body: Center(
            child: Padding(
          padding: widthScreen > 600
              ? EdgeInsets.symmetric(horizontal: widthScreen * .3)
              : const EdgeInsets.all(33.0),
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(
                height: 64,
              ),
              TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  decoration: decorationTextfield.copyWith(
                      hintText: "Enter Your Email : ",
                      suffixIcon: Icon(Icons.email))),
              const SizedBox(
                height: 33,
              ),
              TextField(
                  controller: passwordController,
                  keyboardType: TextInputType.text,
                  obscureText: isVisable ? false : true,
                  decoration: decorationTextfield.copyWith(
                      hintText: "Enter Your Password : ",
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isVisable = !isVisable;
                            });
                          },
                          icon: isVisable
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off)))),
              const SizedBox(
                height: 33,
              ),
              ElevatedButton(
                onPressed: () async {
                  signIn();
                },
                style: ButtonStyle(
                  // backgroundColor: MaterialStateProperty.all(BTNgreen),
                  padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
                ),
                child: isLoading
                    ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text(
                        "Sign in",
                        style: TextStyle(fontSize: 19),
                      ),
              ),
              const SizedBox(
                height: 9,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Do not have an account?",
                      style: TextStyle(fontSize: 18)),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Register()),
                        );
                      },
                      child: Text('sign up',
                          style: TextStyle(
                              fontSize: 18,
                              decoration: TextDecoration.underline))),
                ],
              ),
            ]),
          ),
        )));
  }
}
