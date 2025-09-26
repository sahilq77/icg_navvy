import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icg_navy/controller/otp/send_and_verify_otp_controller.dart';
import '../../utility/app_colors.dart';
import '../../utility/app_images.dart';
import '../../utility/app_routes.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final controller = Get.find<SendAndVerifyOtpController>();
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  bool _isResendEnabled = false;
  int _resendTimer = 30;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  void _startResendTimer() {
    _isResendEnabled = false;
    _resendTimer = 30;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendTimer > 0) {
        setState(() {
          _resendTimer--;
        });
      } else {
        setState(() {
          _isResendEnabled = true;
          timer.cancel();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
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
      final args = Get.arguments;
      final username = args['username'] as String?;
      final mobileNumber = args['mobileNumber'] as String?;

      await controller.verifyOTP(
        context: context,
        username: username,
        mobileNumber: mobileNumber,
        otp: otp,
      );

      //   if (isVerified) {
      //     // Clear OTP fields
      //     for (var controller in _otpControllers) {
      //       controller.clear();
      //     }
      //     // Navigate back with success result
      //     Get.back(result: true);
      //   } else {
      //     // Stay on the screen to allow retry
      //     for (var controller in _otpControllers) {
      //       controller.clear();
      //     }
      //   }
    }
  }

  void resendOtp() {
    if (_isResendEnabled) {
      final args = Get.arguments;
      final username = args['username'] as String?;
      final mobileNumber = args['mobileNumber'] as String?;

      controller.sendOTP(
        context: Get.context,
        username: username,
        mobileNumber: mobileNumber,
      );
      setState(() {
        _isResendEnabled = false;
        _startResendTimer();
      });
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
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset(AppImages.shipGrey, fit: BoxFit.fitHeight),
            ),
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
