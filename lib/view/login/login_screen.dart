import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utility/app_colors.dart';
import '../../utility/app_images.dart';
import '../../utility/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //final controller = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUnfocus,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.1),
                Center(
                  child: Container(
                    height: 150,
                    width: 150,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Image.asset(
                        AppImages.splashlogo,
                        height: screenHeight * 0.30,
                        width: screenHeight * 0.30,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.06),
                Center(
                  child: Text(
                    'Login Your Account',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                const SizedBox(height: 24),
                Text(
                  "Username",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    color: AppColors.defaultblack,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    hintText: 'Enter username',

                    //  prefixIcon: Icon(Icons.person),
                  ),
                  keyboardType: TextInputType.name,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r'^\s')),
                    // FilteringTextInputFormatter.digitsOnly,
                    // LengthLimitingTextInputFormatter(
                    //   10,
                    // ), // Restrict input to 10 digits
                  ],
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Please enter your mobile number';
                  //   }
                  //   if (value.length != 10) {
                  //     return 'Mobile number must be exactly 10 digits';
                  //   }
                  //   if (!RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(value)) {
                  //     return 'Please enter a valid mobile number';
                  //   }
                  //   return null;
                  // },
                ),

                const SizedBox(height: 16),
                Text(
                  "Password",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    color: AppColors.defaultblack,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: "Enter password",
                    // labelText: 'Enter Password',
                    // prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r'^\s')),
                  ],
                  obscureText: _obscurePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    // if (value.length < 6) {
                    //   return 'Password must be at least 6 characters';
                    // }
                    return null;
                  },
                ),
                SizedBox(height: 5),
                Text(
                  'Must be at least 8 characters.',
                  style: GoogleFonts.inter(
                    fontSize: 12, // Increased for readability
                    color: AppColors.textDark,
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.forgotpassword);
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 13, // Increased for readability
                        color: AppColors.textDark,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),

                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // controller.login(
                      //   context: context,
                      //   mobile: _phoneController.text.toString(),
                      //   password: _passwordController.text.toString(),
                      // );
                      // _phoneController.clear();
                      // _passwordController.clear();
                      Get.toNamed(AppRoutes.home);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Continue',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
