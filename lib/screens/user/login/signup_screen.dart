import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jct/screens/user/login/signin_screen.dart';
import 'package:jct/theme/app_theme/app_theme.dart';
import '../settings/verify_email.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String errorMessage = '';
  bool isPasswordType = true;
  bool isConfirmPasswordType = true;
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appTheme = context.theme.appColors;
    final screen = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: appTheme.background,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screen.width * 0.075,
          ),
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: screen.height * 0.16), // To add some top space
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: appTheme.onBackground),
                  ),
                ),
                SizedBox(height: screen.height * 0.05),
                // Email text form field
                TextFormField(
                  autofocus: true,
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                  validator: validateEmail,
                  controller: email,
                  decoration: InputDecoration(
                    hintText: 'Enter E-Mail',
                    hintStyle: TextStyle(color: appTheme.surface),
                    labelText: 'E-Mail',
                    labelStyle: TextStyle(color: appTheme.surface),
                    fillColor: appTheme.primary,
                    filled: true,
                    errorStyle: TextStyle(fontSize: 18.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: appTheme.onSurface),
                      borderRadius: BorderRadius.all(
                        Radius.circular(16.0),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: appTheme.surface),
                      borderRadius: BorderRadius.all(
                        Radius.circular(16.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screen.height * 0.025),
                // Password text form field
                TextFormField(
                  validator: validatePassword,
                  controller: password,
                  obscureText: isPasswordType,
                  autofocus: true,
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                  decoration: InputDecoration(
                    suffixIcon: togglePassword(true),
                    suffixIconColor: appTheme.secondary,
                    hintText: 'Enter Password',
                    hintStyle: TextStyle(color: appTheme.surface),
                    fillColor: appTheme.primary,
                    filled: true,
                    labelText: 'Password',
                    labelStyle: TextStyle(color: appTheme.surface),
                    errorStyle: const TextStyle(fontSize: 18.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: appTheme.onSurface),
                      borderRadius: BorderRadius.all(
                        Radius.circular(16.0),
                      ),
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(
                        Radius.circular(16.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screen.height * 0.025),
                // Confirm Password text form field
                TextFormField(
                  validator: validateConfirmPassword,
                  controller: confirmPassword,
                  obscureText: isConfirmPasswordType,
                  autofocus: true,
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                  decoration: InputDecoration(
                    suffixIcon: togglePassword(false),
                    suffixIconColor: appTheme.secondary,
                    hintText: 'Enter Confirm Password',
                    hintStyle: TextStyle(color: appTheme.surface),
                    labelText: 'Confirm Password',
                    fillColor: appTheme.primary,
                    filled: true,
                    labelStyle: TextStyle(color: appTheme.surface),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: appTheme.onSurface),
                      borderRadius: BorderRadius.all(
                        Radius.circular(16.0),
                      ),
                    ),
                    errorStyle: const TextStyle(fontSize: 18.0),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: appTheme.surface),
                      borderRadius: BorderRadius.all(
                        Radius.circular(16.0),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: screen.height * 0.025),
                // Error Message
                if (errorMessage.isNotEmpty)
                  Text(
                    errorMessage,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                SizedBox(height: screen.height * 0.025),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: context.theme.appColors.onBackground,
                        foregroundColor: context.theme.appColors.background),
                    onPressed: () async {
                      if (_key.currentState!.validate()) {
                        try {
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: email.text, password: password.text)
                              .then((value) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const EmailVerification()));
                          });
                          errorMessage = '';
                        } on FirebaseAuthException catch (error) {
                          setState(() {
                            errorMessage = error.message!;
                          });
                        }
                      }
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          color: appTheme.background,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignInScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Already a User",
                    style: TextStyle(color: appTheme.onBackground),
                  ),
                ),
                SizedBox(height: screen.height * 0.05), // Add some bottom space
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget togglePassword(bool isPassword) {
    return IconButton(
      // color: Colors.red,
      onPressed: () {
        setState(() {
          isPassword
              ? (isPasswordType = !isPasswordType)
              : (isConfirmPasswordType = !isConfirmPasswordType);
        });
      },
      icon: isPassword
          ? (isPasswordType
              ? const Icon(Icons.visibility)
              : const Icon(Icons.visibility_off))
          : (isConfirmPasswordType
              ? const Icon(Icons.visibility)
              : const Icon(Icons.visibility_off)),
    );
  }

  String? validateEmail(String? formEmail) {
    if (formEmail == null || formEmail.isEmpty) {
      return 'E-Mail Address is required';
    }
    String pattern = r'\w+@\w+\.\w+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(formEmail)) {
      return 'Invalid E-Mail Address Format';
    }
    return null;
  }

  String? validatePassword(String? formPassword) {
    if (formPassword == null || formPassword.isEmpty) {
      return 'Password is required';
    }
    String pattern1 = r'^(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[0-9]).{6,}$';
    RegExp regex = RegExp(pattern1);
    if (!regex.hasMatch(formPassword)) {
      return 'Password must include:\n- at least 6 characters\n- lower case character\n- upper case character\n- numeric value';
    }
    return null;
  }

  String? validateConfirmPassword(String? formPassword) {
    if (formPassword == null || formPassword.isEmpty) {
      return 'Password is required';
    } else if (password.text != confirmPassword.text) {
      return 'Passwords do not match';
    }
    String pattern1 = r'^(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[0-9]).{6,}$';
    RegExp regex = RegExp(pattern1);
    if (!regex.hasMatch(formPassword)) {
      return 'Invalid Password Format';
    }
    return null;
  }
}
