
//                                                       TODO INPUT SCREEN
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import '../widgets/colors.dart';
//
// class InputScreen extends StatefulWidget {
//   const InputScreen({super.key});
//
//   @override
//   State<InputScreen> createState() => _InputScreenState();
// }
//
// class _InputScreenState extends State<InputScreen> {
//
//   bool _isLoading = false;
//
//   // Header Controllers Map
//   final Map<String, TextEditingController> _headerControllers = {};
//
// // Summary Controllers Map
//   final Map<String, TextEditingController> _summaryControllers = {};
//
//
// // Header Controllers
//   final vendorNameController = TextEditingController();
//   final invoiceNumberController = TextEditingController();
//   final invoiceDateController = TextEditingController();
//
// // Summary Controllers
//   final subTotalController = TextEditingController();
//   final gstController = TextEditingController();
//   final otherTaxesController = TextEditingController();
//   final taxController = TextEditingController();
//   final totalQuantityController = TextEditingController();
//   final totalPriceController = TextEditingController();
//   final discountController = TextEditingController();
//
//   List<Map<String, TextEditingController>> _productControllers = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _addNewProduct();
//
//     _headerControllers.addAll({
//       "Vendor Name": vendorNameController,
//       "Invoice Number": invoiceNumberController,
//       "Invoice Date": invoiceDateController,
//     });
//
//     _summaryControllers.addAll({
//       "Sub Total": subTotalController,
//       "GST": gstController,
//       "Other Taxes": otherTaxesController,
//       "Tax": taxController,
//       "Total Quantity": totalQuantityController,
//       "Total Price": totalPriceController,
//       "Discount": discountController,
//     });
//   }
//
//
//   void _addNewProduct() {
//     setState(() {
//       _productControllers.add({
//         "Product Name": TextEditingController(),
//         "Product Type": TextEditingController(),
//         "Product Category": TextEditingController(),
//         "Unit Price": TextEditingController(),
//         "Quantity": TextEditingController(),
//         "Total Product Price": TextEditingController(),
//       });
//     });
//   }
//
//   void _removeProduct(int index) {
//     setState(() {
//       _productControllers.removeAt(index);
//     });
//   }
//
//   void _submitData() async {
//     // Validate
//     if (vendorNameController.text.isEmpty ||
//         invoiceNumberController.text.isEmpty ||
//         invoiceDateController.text.isEmpty ||
//         subTotalController.text.isEmpty ||
//         totalPriceController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Please fill in all required fields")),
//       );
//       return;
//     }
//
//     setState(() {
//       _isLoading = true;
//     });
//
//     final uri = Uri.parse('https://data-digitization.vercel.app/receipts/manual');
//
//     final body = {
//       "vendor_name": vendorNameController.text.trim(),
//       "invoice_number": invoiceNumberController.text.trim(),
//       "invoice_date": invoiceDateController.text.trim(),
//       "products": _productControllers.map((product) {
//         return {
//           "product_name": product[0]?.text.trim(), // Accessing by index instead of key
//           "product_type": product[1]?.text.trim(),
//           "product_category": product[2]?.text.trim(),
//           "unit_price": double.tryParse(product[3].text) ?? 0.0,
//           "quantity": int.tryParse(product[4].text) ?? 0,
//           "total_product_price": double.tryParse(product[5].text) ?? 0.0,
//         };
//       }).toList(),
//       "invoice_summary": {
//         "sub_total": double.tryParse(subTotalController.text) ?? 0.0,
//         "gst": double.tryParse(gstController.text) ?? 0.0,
//         "other_taxes": double.tryParse(otherTaxesController.text) ?? 0.0,
//         "tax": double.tryParse(taxController.text) ?? 0.0,
//         "total_quantity": int.tryParse(totalQuantityController.text) ?? 0,
//         "total_price": double.tryParse(totalPriceController.text) ?? 0.0,
//         "discount": double.tryParse(discountController.text) ?? 0.0,
//       }
//     };
//
//
//     try {
//       print("Sending data: ${jsonEncode(body)}"); // 👈 Logs what you're sending
//       final response = await http.post(
//         uri,
//         headers: {
//           "Content-Type": "application/json",
//           "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ0ZXN0YXNoYXJpYiIsImV4cCI6MTc0NTM0ODMyOX0.a4kZNn1agyDmphYa89n84_Nzju5XJtyGV_nv8zW0E_c"
//         },
//         body: jsonEncode(body),
//       );
//       print("Response status: ${response.statusCode}");
//       print("Response body: ${response.body}");
//
//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Submitted successfully!")),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Submission failed: ${response.statusCode}")),
//         );
//       }
//     } catch (e) {
//       print("Error: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("An error occurred: $e")),
//       );
//     }
//
//     setState(() {
//       _isLoading = false;
//     });
//   }
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     final h = MediaQuery.of(context).size.height;
//     final w = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: AppColors.background,
//         title: Text(
//           "FinScribe",
//           style: TextStyle(
//             color: AppColors.text,
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//
//             BuildSection(
//               title: "Invoice Header",
//               children: [
//                 BuildInputRow(["Vendor Name", "Invoice Number"], _headerControllers),
//                 BuildInputRow(["Invoice Date"], _headerControllers),
//               ],
//             ),
//
//             BuildSection(
//               title: "Product Details",
//               children: [
//                 ..._productControllers.asMap().entries.map((entry) {
//                   final index = entry.key;
//                   final product = entry.value;
//
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Product ${index + 1}",
//                             style: TextStyle(
//                               fontWeight: FontWeight.w600,
//                               fontSize: 16,
//                               color: AppColors.text,
//                             ),
//                           ),
//                           if (_productControllers.length > 1)
//                             IconButton(
//                               icon: Icon(Icons.delete, color: Colors.red),
//                               onPressed: () => _removeProduct(index),
//                             ),
//                         ],
//                       ),
//                       BuildDynamicInputRow(["Product Name", "Product Type"], product),
//                       BuildDynamicInputRow(["Product Category", "Unit Price"], product),
//                       BuildDynamicInputRow(["Quantity", "Total Product Price"], product),
//                       const Divider(thickness: 1),
//                     ],
//                   );
//                 }),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: TextButton.icon(
//                     onPressed: _addNewProduct,
//                     icon: Icon(Icons.add, color: AppColors.text),
//                     label: Text("Add Product", style: TextStyle(color: AppColors.text)),
//                   ),
//                 ),
//               ],
//             ),
//
//
//
//
//             BuildSection(
//               title: "Invoice Details",
//               children: [
//                 BuildInputRow(["Sub Total", "GST"], _summaryControllers),
//                 BuildInputRow(["Other Taxes", "Tax"], _summaryControllers),
//                 BuildInputRow(["Total Quantity", "Total Price"], _summaryControllers),
//                 BuildInputRow(["Discount"], _summaryControllers),
//               ],
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _isLoading ? null : _submitData,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.text,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
//               ),
//               child: _isLoading
//                   ? SizedBox(
//                 width: 20,
//                 height: 20,
//                 child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
//               )
//                   : Text("Submit", style: TextStyle(color: Colors.white)),
//             ),
//
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget BuildSection({required String title, required List<Widget> children}) {
//     return Card(
//       elevation: 3,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       margin: const EdgeInsets.symmetric(vertical: 12),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: TextStyle(
//                 color: AppColors.text,
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             const SizedBox(height: 12),
//             ...children,
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget BuildInputRow(List<String> labels, Map<String, TextEditingController> controllerMap) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16),
//       child: Row(
//         children: labels.map((label) {
//           return Expanded(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 6),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "$label:",
//                     style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.text,
//                     ),
//                   ),
//                   const SizedBox(height: 6),
//                   TextFormField(
//                     controller: controllerMap[label],
//                     decoration: InputDecoration(
//                       isDense: true,
//                       contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       filled: true,
//                       fillColor: Colors.grey[100],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
//
//
//   Widget BuildInputField(String label) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "$label:",
//           style: TextStyle(
//             fontWeight: FontWeight.w600,
//             color: AppColors.text,
//           ),
//         ),
//         const SizedBox(height: 6),
//         TextFormField(
//           decoration: InputDecoration(
//             isDense: true,
//             contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//             filled: true,
//             fillColor: Colors.grey[100],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget BuildDynamicInputRow(List<String> labels, Map<String, TextEditingController> controllerMap) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16),
//       child: Row(
//         children: labels.map((label) {
//           return Expanded(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 6),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "$label:",
//                     style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.text,
//                     ),
//                   ),
//                   const SizedBox(height: 6),
//                   TextFormField(
//                     controller: controllerMap[label],
//                     decoration: InputDecoration(
//                       isDense: true,
//                       contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       filled: true,
//                       fillColor: Colors.grey[100],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
//
// }
















//                                                             TODO LOGIN SCREEN
// import 'package:flutter/material.dart';
// import 'package:fyp/model/login_response_model.dart';
// import 'package:fyp/view/signup_screen.dart';
// import 'package:fyp/view_model/services/firebase_auth_methods.dart';
//
// import '../widgets/colors.dart';
// import 'home_screen.dart';
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final AuthService authService = AuthService();
//
//   bool isLoading = false;
//
//
//
//   void handleLogin() async {
//     final username = usernameController.text.trim();
//     final password = passwordController.text.trim();
//
//     print("USERNAME: $username");
//     print("PASSWORD: $password");
//
//     if (username.isEmpty || password.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Fill all the fields')),
//       );
//       return;
//     }
//
//     setState(() {
//       isLoading = true;
//     });
//
//     final LoginResponseModel? response = await authService.login(username, password);
//
//     setState(() {
//       isLoading = false;
//     });
//
//     if (response != null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Login Successful')),
//       );
//
//       // Navigate to HomeScreen
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => HomeScreen()),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Login Failed')),
//       );
//     }
//
//   }
//
//   void navigateToSignup() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => const SignupScreen()),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       appBar: AppBar(
//         backgroundColor: AppColors.background,
//         title: Text(
//           "FinScribe",
//           style: TextStyle(
//             color: AppColors.text,
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Image.asset('assets/images/logo.jpeg',width: 100,height: 100,),
//           Text(
//             "Login To Your Account",
//             style: TextStyle(
//               fontSize: 28,
//               fontWeight: FontWeight.bold,
//               color: AppColors.text,
//             ),
//           ),
//           Center(
//             child: Padding(
//               padding: const EdgeInsets.all(24.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(height: 20),
//
//                   TextField(
//                     controller: usernameController,
//                     decoration: InputDecoration(
//                       hintText: "Email",
//                       hintStyle: TextStyle(color: AppColors.hintText),
//                       filled: true,
//                       fillColor: AppColors.inputFill,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       prefixIcon: Icon(Icons.person, color: AppColors.text),
//                     ),
//                   ),
//                   SizedBox(height: 15),
//
//                   // Password TextField
//                   TextField(
//                     controller: passwordController,
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       hintText: "Password",
//                       hintStyle: TextStyle(color: AppColors.hintText),
//                       filled: true,
//                       fillColor: AppColors.inputFill,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       prefixIcon: Icon(Icons.lock, color: AppColors.text),
//                     ),
//                   ),
//                   SizedBox(height: 100),
//
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.text, // Button color set to teal green
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                     ),
//                     onPressed: () {
//                       handleLogin();
//                     },
//                     child: Text(
//                       "Login",
//                       style: TextStyle(fontSize: 18, color: AppColors.background),
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Don't have an account?",
//                         style: TextStyle(color: AppColors.darkGray),
//                       ),
//                       TextButton(
//                         onPressed: navigateToSignup,
//                         child: Text(
//                           "SignUp",
//                           style: TextStyle(color: AppColors.text),
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }






//                                                  TODO SIGNUP SCREEN
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:fyp/model/login_response_model.dart';
// import 'package:fyp/view_model/services/firebase_auth_methods.dart';
// import '../widgets/colors.dart';
// import 'login_screen.dart'; // for navigation
//
// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});
//
//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }
//
// class _SignupScreenState extends State<SignupScreen> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//
//   bool isLoading = false;
//
//   void handleSignup() async {
//     final email = emailController.text;
//     final username = usernameController.text;
//     final password = passwordController.text;
//
//     if (email.isEmpty || username.isEmpty || password.isEmpty ) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please fill all fields')),
//       );
//       return;
//     }
//
//     setState(() {
//       isLoading = true;
//     });
//
//     // try {
//     //   final LoginResponseModel response = await authService.signup(username, password);
//     //
//     //   // ✅ Save token using SharedPreferences
//     //   final prefs = await SharedPreferences.getInstance();
//     //   await prefs.setString('access_token', response.accessToken ?? '');
//     //   await prefs.setString('token_type', response.tokenType ?? '');
//     //
//     //   ScaffoldMessenger.of(context).showSnackBar(
//     //     SnackBar(content: Text('Signup Successful')),
//     //   );
//     //
//     //   // You can also navigate to home screen here if needed
//     //
//     // } catch (e) {
//     //   ScaffoldMessenger.of(context).showSnackBar(
//     //     SnackBar(content: Text('Signup Failed: ${e.toString()}')),
//     //   );
//     // } finally {
//     //   setState(() {
//     //     isLoading = false;
//     //   });
//     // }
//   }
//
//   void navigateToLogin() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => const LoginScreen()),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       appBar: AppBar(
//         backgroundColor: AppColors.background,
//         title: Text(
//           "FinScribe",
//           style: TextStyle(
//             color: AppColors.text,
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Image.asset('assets/images/logo.jpeg',width: 100,height: 100,),
//           Text(
//             "SignUp",
//             style: TextStyle(
//               fontSize: 28,
//               fontWeight: FontWeight.bold,
//               color: AppColors.text,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(24.0),
//             child: Column(
//               children: [
//                 SizedBox(height: 20),
//                 TextField(
//                   controller: emailController,
//                   decoration: InputDecoration(
//                     hintText: "Email",
//                     hintStyle: TextStyle(color: AppColors.hintText),
//                     filled: true,
//                     fillColor: AppColors.inputFill,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     prefixIcon: Icon(Icons.person, color: AppColors.text),
//                   ),
//                 ),
//                 SizedBox(height: 15),
//                 TextField(
//                   controller: usernameController,
//                   decoration: InputDecoration(
//                     hintText: "Username",
//                     hintStyle: TextStyle(color: AppColors.hintText),
//                     filled: true,
//                     fillColor: AppColors.inputFill,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     prefixIcon: Icon(Icons.person, color: AppColors.text),
//                   ),
//                 ),
//                 SizedBox(height: 15),
//                 TextField(
//                   controller: passwordController,
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     hintText: "Password",
//                     hintStyle: TextStyle(color: AppColors.hintText),
//                     filled: true,
//                     fillColor: AppColors.inputFill,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     prefixIcon: Icon(Icons.lock, color: AppColors.text),
//                   ),
//                 ),
//                 SizedBox(height: 40),
//
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.text,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                   ),
//                   onPressed: handleSignup,
//                   child: Text(
//                     "Sign Up",
//                     style: TextStyle(fontSize: 18, color: AppColors.background),
//                   ),
//                 ),
//
//                 SizedBox(height: 20),
//
//                 // 👇 Navigation to login screen
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Already have an account?",
//                       style: TextStyle(color: AppColors.darkGray),
//                     ),
//                     TextButton(
//                       onPressed: navigateToLogin,
//                       child: Text(
//                         "Login",
//                         style: TextStyle(color: AppColors.text),
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
