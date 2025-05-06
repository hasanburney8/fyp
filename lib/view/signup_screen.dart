import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/view/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fyp/model/login_response_model.dart';
import 'package:fyp/view_model/services/firebase_auth_methods.dart';
import '../widgets/colors.dart';
import 'login_screen.dart'; // for navigation

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // void signUpUser() async {
  //   FirebaseAuthMethods(FirebaseAuth.instance).signUpWithEmail(
  //     email: emailController.text,
  //     password: passwordController.text,
  //     context: context,
  //   );
  // }


  void signUpUser() async {
    bool success = await FirebaseAuthMethods(FirebaseAuth.instance).signUpWithEmail(
      email: emailController.text,
      password: passwordController.text,
      context: context,
    );

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  void navigateToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(
          "FinScribe",
          style: TextStyle(
            color: AppColors.text,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/logo.jpeg',width: 100,height: 100,),
          Text(
            "SignUp",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.text,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                SizedBox(height: 20),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: TextStyle(color: AppColors.hintText),
                    filled: true,
                    fillColor: AppColors.inputFill,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: Icon(Icons.person, color: AppColors.text),
                  ),
                ),
                SizedBox(height: 15),
                // TextField(
                //   controller: usernameController,
                //   decoration: InputDecoration(
                //     hintText: "Username",
                //     hintStyle: TextStyle(color: AppColors.hintText),
                //     filled: true,
                //     fillColor: AppColors.inputFill,
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(12),
                //     ),
                //     prefixIcon: Icon(Icons.person, color: AppColors.text),
                //   ),
                // ),
                SizedBox(height: 15),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(color: AppColors.hintText),
                    filled: true,
                    fillColor: AppColors.inputFill,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: Icon(Icons.lock, color: AppColors.text),
                  ),
                ),
                SizedBox(height: 40),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.text,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  onPressed: signUpUser,
                  child: Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 18, color: AppColors.background),
                  ),
                ),

                SizedBox(height: 20),

                // 👇 Navigation to login screen
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(color: AppColors.darkGray),
                    ),
                    TextButton(
                      onPressed: navigateToLogin,
                      child: Text(
                        "Login",
                        style: TextStyle(color: AppColors.text),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
