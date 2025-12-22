import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tasky/core/utils/appDialog_widget.dart';
import 'package:tasky/core/utils/validator.dart';
import 'package:tasky/core/widgets/material_button_widget.dart';
import 'package:tasky/core/widgets/text_form_field_helper.dart';
import 'package:tasky/feature/auth/ui/view/register_screen.dart';
import 'package:tasky/feature/auth/ui/widget/stateMember_widget.dart';
import 'package:tasky/feature/home/ui/view/home_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});
  static const String routeName = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();

  var email = TextEditingController();

  var password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 80),
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff404147),
                  ),
                ),
                SizedBox(height: 50),
                Text(
                  "Email",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff404147),
                  ),
                ),
                SizedBox(height: 5),
                TextFormFieldHelper(
                  hint: "Enter Your Email",
                  controller: email,
                  borderRadius: BorderRadius.circular(10),
                  validator: Validator.validateEmail,
                ),
                SizedBox(height: 20),
                Text(
                  "Password",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff404147),
                  ),
                ),
                SizedBox(height: 5),
                TextFormFieldHelper(
                  hint: "Enter Your Password",
                  borderRadius: BorderRadius.circular(10),
                  controller: password,
                  validator: Validator.validatePassword,
                  isPassword: true,
                ),
                SizedBox(height: 50),
                MaterialButtonWidget(
                  title: "Login",
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      AppDialog.showLoadingDialog(context);

                      login(email.text, password.text)
                          .then((_) {
                            Navigator.of(context).pop();
                            Navigator.of(
                              context,
                            ).popAndPushNamed(HomeScreen.routeName);
                            email.clear();
                            password.clear();
                          })
                          .catchError((error) {
                            Navigator.of(context).pop();
                            AppDialog.showErrorDialog(
                              context,
                              error.toString(),
                            );
                          });
                    }
                  },
                ),
                SizedBox(height: 30),
                StateMemberWidget(
                  title: "Don't have an account? ",
                  subTitle: "Register",
                  onTap: () {
                    Navigator.of(context).pushNamed(RegisterScreen.routeName);
                  },
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

Future<void> login(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    String errorMessage = '';

    if (e.code == 'user-not-found') {
      errorMessage = 'No user found for that email.';
    } else if (e.code == 'wrong-password') {
      errorMessage = 'Wrong password provided for that user.';
    } else {
      errorMessage = 'An unexpected error occurred. Please try again.';
    }

    throw Exception(errorMessage);
  } catch (e) {
    throw Exception('An unexpected error occurred. Please try again.');
  }
}
}