import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icg_navy/utility/app_utility.dart';
import '../../controller/login/login_controller.dart';
import '../../utility/app_colors.dart';
import '../../utility/app_images.dart';
import '../../utility/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  static const Map<String, String> _emailToRole = {
    'appointment@gmail.com': '0',
    'medicalofficer@gmail.com': '1',
    'authofficer@gmail.com': '2',
  };

  Future<void> handleLogin() async {
    final email = _usernameController.text;
    if (_emailToRole.containsKey(email)) {
      await AppUtility.setUserInfo(
        "name",
        "mobile",
        _emailToRole[email]!,
        "userid",
        true,
      );
      Get.snackbar(
        'Success',
        'Login Successfully!',
        backgroundColor: AppColors.success,
        colorText: Colors.white,
      );
      Get.offNamed(AppRoutes.home);
    }
    _usernameController.clear();
    _passwordController.clear();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Background image at the bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              AppImages.shipGrey, // Ensure this is the correct image path
              fit: BoxFit
                  .fitHeight, // Cover the width while maintaining aspect ratio
              //height: screenHeight * 0.3, // Adjust height to ensure visibility
            ),
          ),
          // Scrollable login form
          SingleChildScrollView(
            child: SizedBox(
              height:
                  screenHeight, // Ensure the scrollable area takes full height
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: screenHeight * 0.1),
                      Center(
                        child: Container(
                          height: 150,
                          width: 150,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Image.asset(
                              AppImages.splashlogo,
                              height:
                                  screenHeight *
                                  0.15, // Reduced size for better fit
                              width: screenHeight * 0.15,
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
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          hintText: 'Enter username',
                        ),
                        keyboardType: TextInputType.name,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r'^\s')),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Text(
                      //   "Password",
                      //   style: GoogleFonts.inter(
                      //     fontWeight: FontWeight.w500,
                      //     color: AppColors.defaultblack,
                      //     fontSize: 15,
                      //   ),
                      // ),
                      // const SizedBox(height: 10),
                      // TextFormField(
                      //   controller: _passwordController,
                      //   decoration: InputDecoration(
                      //     hintText: "Enter password",
                      //     suffixIcon: IconButton(
                      //       icon: Icon(
                      //         _obscurePassword
                      //             ? Icons.visibility
                      //             : Icons.visibility_off,
                      //       ),
                      //       onPressed: () {
                      //         setState(() {
                      //           _obscurePassword = !_obscurePassword;
                      //         });
                      //       },
                      //     ),
                      //   ),
                      //   inputFormatters: [
                      //     FilteringTextInputFormatter.deny(RegExp(r'^\s')),
                      //   ],
                      //   obscureText: _obscurePassword,
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Please enter your password';
                      //     }
                      //     if (value.length < 8) {
                      //       return 'Password must be at least 8 characters';
                      //     }
                      //     return null;
                      //   },
                      // ),
                      // const SizedBox(height: 5),
                      // Text(
                      //   'Must be at least 8 characters.',
                      //   style: GoogleFonts.inter(
                      //     fontSize: 12,
                      //     color: AppColors.textDark,
                      //   ),
                      // ),
                      // Align(
                      //   alignment: Alignment.topRight,
                      //   child: TextButton(
                      //     onPressed: () {
                      //       Get.toNamed(AppRoutes.forgotpassword);
                      //     },
                      //     child: Text(
                      //       'Forgot Password?',
                      //       style: TextStyle(
                      //         fontSize: 13,
                      //         color: AppColors.textDark,
                      //       ),
                      //       textAlign: TextAlign.right,
                      //     ),
                      //   ),
                      // ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            controller.login(
                              context: context,
                              username: _usernameController.text.toString(),
                              // mobile: _phoneController.text,
                              // password: _passwordController.text,
                            );
                            //  handleLogin();
                            // _phoneController.clear();
                            // _passwordController.clear();
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
                      const SizedBox(
                        height: 16,
                      ), // Ensure some padding at the bottom
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
