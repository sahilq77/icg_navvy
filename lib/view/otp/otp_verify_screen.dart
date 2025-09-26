import 'dart:async'; // Add this import for Timer
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icg_navy/controller/otp/send_and_verify_otp_controller.dart';
import '../../utility/app_colors.dart';
import '../../utility/app_images.dart';
import '../../utility/app_routes.dart';
import '../../controller/login/login_controller.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final controller = Get.put(SendAndVerifyOtpController());
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  bool _isResendEnabled = false;
  int _resendTimer = 30;
  Timer? _timer; // Timer for countdown

  @override
  void initState() {
    super.initState();
    // Start the resend OTP timer
    _startResendTimer();
  }

  void _startResendTimer() {
    _isResendEnabled = false;
    _resendTimer = 30;
    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendTimer > 0) {
        setState(() {
          _resendTimer--;
        });
      } else {
        setState(() {
          _isResendEnabled = true;
          timer.cancel(); // Stop the timer when it reaches 0
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when disposing
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  Future<void> handleOtpVerification() async {
    if (_formKey.currentState!.validate()) {
      final otp = _otpControllers.map((controller) => controller.text).join();
      if (otp.length == 6) {
        Get.snackbar(
          'Success',
          'OTP Verified Successfully!',
          backgroundColor: AppColors.success,
          colorText: Colors.white,
        );
        Get.offNamed(AppRoutes.home);
      } else {
        Get.snackbar(
          'Error',
          'Invalid OTP. Please try again.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
      for (var controller in _otpControllers) {
        controller.clear();
      }
    }
  }

  void resendOtp() {
    if (_isResendEnabled) {
      setState(() {
        _isResendEnabled = false;
      });
      Get.snackbar(
        'Resent',
        'OTP has been resent!',
        backgroundColor: AppColors.success,
        colorText: Colors.white,
      );
      _startResendTimer(); // Restart the timer
    }
  }

  Widget buildOtpField(int index) {
    return SizedBox(
      width: 50,
      child: TextFormField(
        controller: _otpControllers[index],
        focusNode: _focusNodes[index],
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
        ),
        style: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.defaultblack,
        ),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(1),
        ],
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '';
          }
          return null;
        },
        onChanged: (value) {
          if (value.length == 1 && index < 5) {
            _focusNodes[index].unfocus();
            _focusNodes[index + 1].requestFocus();
          } else if (value.isEmpty && index > 0) {
            _focusNodes[index].unfocus();
            _focusNodes[index - 1].requestFocus();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Background image at the bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset(AppImages.shipGrey, fit: BoxFit.fitHeight),
            ),
            // Scrollable OTP form
            SizedBox(
              height: screenHeight,
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
                              height: screenHeight * 0.15,
                              width: screenHeight * 0.15,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.06),
                      Center(
                        child: Text(
                          'OTP Verification',
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Center(
                        child: Text(
                          "Enter the 6-digit OTP sent to your mobile",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w400,
                            color: AppColors.textDark,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          6,
                          (index) => buildOtpField(index),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _isResendEnabled
                                ? 'Resend OTP'
                                : 'Resend OTP in $_resendTimer s',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: _isResendEnabled
                                  ? AppColors.primary
                                  : AppColors.textDark,
                            ),
                          ),
                          TextButton(
                            onPressed: _isResendEnabled ? resendOtp : null,
                            child: Text(
                              'Resend',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: _isResendEnabled
                                    ? AppColors.primary
                                    : AppColors.textDark,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: handleOtpVerification,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                        ),
                        child: Text(
                          'Verify OTP',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
