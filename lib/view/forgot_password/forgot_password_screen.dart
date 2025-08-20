import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utility/app_colors.dart';
import '../../utility/app_images.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  // final controller = Get.put(ForgotPasswordController());
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
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
                  'Reset Your Password',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 24),
              Text(
                "Email Address",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  color: AppColors.defaultblack,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  hintText: "Enter email address",

                  // labelText: 'Enter email address',
                  // prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'^\s')),
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Please enter your mobile number';
                //   }
                //   if (value.length != 10) {
                //     return 'Mobile number must be exactly 10 digits';
                //   }
                //   if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                //     return 'Please enter a valid mobile number';
                //   }
                //   return null;
                // },
              ),
              const SizedBox(height: 24),

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
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Reset Password',
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
    );
  }
}
