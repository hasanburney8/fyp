import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../widgets/components/showSnackbar.dart';



class FirebaseAuthMethods{
  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);

  //Email Sign up

  // Future<void> signUpWithEmail({
  //   required String email,
  //   required String password,
  //   required BuildContext context,
  // })async{
  //   try{
  //     await _auth.createUserWithEmailAndPassword(
  //         email: email,
  //         password: password
  //     );
  //     await sendEmailVerification(context);
  //   }on FirebaseAuthException catch(e){
  //     if(e.code == 'weak-password'){
  //       showSnackBar(context,e.message!);
  //     };
  //     showSnackBar(context, e.message!);
  //   }
  // }

  Future<bool> signUpWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await sendEmailVerification(context);
      showSnackBar(context, 'Sign up successful. Please check your email for verification.');
      return true;

    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message ?? 'An error occurred');
      return false;
    }
  }


  //Email verification
  Future<void>sendEmailVerification(BuildContext context)async{
    try{
      _auth.currentUser!.sendEmailVerification();
      showSnackBar(context, 'Email verification sent!');
    }on FirebaseAuthException catch(e){
      showSnackBar(context, e.message!);
    }
  }


  //Email Login
  // Future<void>loginWithEmail({
  //   required String email,
  //   required String password,
  //   required BuildContext context,
  // })async{
  //   try{
  //     await _auth.signInWithEmailAndPassword(
  //         email: email,
  //         password: password
  //     );
  //     if(!_auth.currentUser!.emailVerified){
  //       await sendEmailVerification(context);
  //     }
  //   }on FirebaseAuthException catch(e){
  //     showSnackBar(context, e.message!);
  //   }
  // }


  Future<bool> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (!_auth.currentUser!.emailVerified) {
        await sendEmailVerification(context);
        showSnackBar(context, 'Please verify your email before proceeding.');
        return false;
      }

      return true; // Login successful
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
      return false; // Login failed
    }
  }





}





















// // import 'dart:convert';
// // import 'dart:async';
// // import 'package:fyp/model/login_response_model.dart'; // or use signup_response_model.dart if separate
// // import 'package:http/http.dart' as http;
// //
// //
// // class AuthService {
// //   final String baseUrl = 'https://data-digitization.vercel.app';
// //
// //
// //   Future<LoginResponseModel?> login(String username, String password) async {
// //     try {
// //       final url = Uri.parse('$baseUrl/auth/login');
// //
// //       // Send the username and password as URL-encoded form data
// //       final response = await http.post(
// //         url,
// //         headers: {
// //           'Content-Type': 'application/x-www-form-urlencoded',  // Correct content type for form data
// //           'User-Agent': 'Mozilla/5.0 (Mobile; FlutterApp)', //Some free servers like Vercel block unknown User-Agents or mobile requests.Try adding a custom User-Agent header in your request:
// //         },
// //         body: {
// //           'username': username,
// //           'password': password,
// //         },
// //       );gi
// //
// //       print('Response status: ${response.statusCode}');
// //       print('Response body: ${response.body}');
// //
// //       if (response.statusCode == 200) {
// //         // If the request is successful, parse the response
// //         return LoginResponseModel.fromJson(jsonDecode(response.body));
// //       } else {
// //         // If the login fails, throw an exception with the error message
// //         throw Exception('Login failed: ${response.body}');
// //       }
// //     } catch (e) {
// //       print('Error: $e');
// //       return null;
// //     }
// //   }
// //
// //   // Adjusted signup method
// //   Future<LoginResponseModel> signup(String username, String password) async {
// //     final url = Uri.parse('$baseUrl/auth/register');
// //
// //     // Send the username and password as JSON data
// //     final response = await http.post(
// //       url,
// //       headers: {'Content-Type': 'application/json'},
// //       body: jsonEncode({'username': username, 'password': password}),
// //     );
// //
// //     if (response.statusCode == 200) {
// //       final data = json.decode(response.body);
// //       return LoginResponseModel.fromJson(data);
// //     } else {
// //       throw Exception('Signup failed: ${response.body}');
// //     }
// //   }
// // }
// //
// // // Future<LoginResponseModel> login(String username, String password) async {
// // //   final url = Uri.parse('$baseUrl/auth/login');
// // //   final response = await http.post(
// // //     url,
// // //     headers: {'Content-Type': 'application/json'},
// // //     body: jsonEncode({'username': username, 'password': password}),
// // //   );
// // //
// // //   if (response.statusCode == 200) {
// // //     final data = json.decode(response.body);
// // //     return LoginResponseModel.fromJson(data);
// // //   } else {
// // //     throw Exception('Login failed: ${response.body}');
// // //   }
// // // }
//
//
//
// import 'dart:convert';
// import 'dart:async';
// import 'package:fyp/model/login_response_model.dart'; // Make sure this model has fields like access_token, token_type
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// class AuthService {
//   final String baseUrl = 'https://data-digitization.vercel.app';
//
//   // LOGIN
//   Future<LoginResponseModel?> login(String username, String password) async {
//     try {
//       final url = Uri.parse('$baseUrl/auth/login');
//
//       final response = await http.post(
//         url,
//         headers: {
//           'Content-Type': 'application/x-www-form-urlencoded',
//           'User-Agent': 'Mozilla/5.0 (Mobile; FlutterApp)',
//         },
//         body: {
//           'username': username,
//           'password': password,
//         },
//       );
//
//       print('Login Response status: ${response.statusCode}');
//       print('Login Response body: ${response.body}');
//
//       if (response.statusCode == 200) {
//         final responseData = jsonDecode(response.body);
//
//         // ✅ Save the token in SharedPreferences
//         final token = responseData['access_token'];
//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setString('token', token);
//
//         return LoginResponseModel.fromJson(responseData);
//       } else {
//         throw Exception('Login failed: ${response.body}');
//       }
//     } catch (e) {
//       print('Login error: $e');
//       return null;
//     }
//   }
//
//   // SIGNUP
//   Future<LoginResponseModel?> signup(String username, String password) async {
//     try {
//       final url = Uri.parse('$baseUrl/auth/register');
//
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({'username': username, 'password': password}),
//       );
//
//       print('Signup Response status: ${response.statusCode}');
//       print('Signup Response body: ${response.body}');
//
//       if (response.statusCode == 200) {
//         final responseData = json.decode(response.body);
//
//         // ✅ Save token on successful signup as well
//         final token = responseData['access_token'];
//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setString('token', token);
//
//         return LoginResponseModel.fromJson(responseData);
//       } else {
//         throw Exception('Signup failed: ${response.body}');
//       }
//     } catch (e) {
//       print('Signup error: $e');
//       return null;
//     }
//   }
//
//   // LOGOUT
//   Future<void> logout() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('token');
//     print('✅ Logged out and token removed');
//   }
//
//   // GET SAVED TOKEN (optional helper)
//   Future<String?> getToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString('token');
//   }
// }
