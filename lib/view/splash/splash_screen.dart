import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icg_navy/utility/app_images.dart';
import '../../controller/splash/splash_controller.dart';
import '../../utility/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Container(
        color: AppColors.primary, // Blue background
        child: SafeArea(
          child: Center(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: screenWidth * 0.9),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Center(
                          child: Image.asset(
                            AppImages.splashlogo,
                            height: screenHeight * 0.20,
                            width: screenHeight * 0.20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Text(
                          '© 2025 ICG. All rights reserved.',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: screenWidth * 0.03 > 12
                                ? 12
                                : screenWidth * 0.03,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
