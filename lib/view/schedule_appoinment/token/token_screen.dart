import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icg_navy/utility/app_images.dart';
import 'package:icg_navy/utility/app_routes.dart';

import '../../../utility/app_colors.dart';

class TokenScreen extends StatelessWidget {
  const TokenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'Token',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            color: AppColors.defaultblack,
            fontSize: 18,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(10),
          child: Divider(
            color: const Color(0xFFDADADA),
            // thickness: 2,
            height: 0,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: screenHeight * 0.1),

          Container(
            padding: EdgeInsets.all(50),
            child: Column(
              children: [
                SvgPicture.asset(AppImages.tokenIcon),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  "Appointment confirmed",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    color: AppColors.defaultblack,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  "Your slot has been scheduled successfully, You can now download your token.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    color: AppColors.defaultblack,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Get.back(),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          side: BorderSide(
                            color: Colors.grey[300]!, // Border color
                            width: 1.5, // Border width
                          ),
                          foregroundColor:
                              AppColors.defaultblack, // Text/icon color
                        ),
                        child: Text(
                          'Back',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.defaultblack,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Final submission logic
                          // Get.snackbar(
                          //   "Success",
                          //   "Application successfully submitted!",
                          // );
                          // Optionally navigate to a confirmation screen or home
                          Get.toNamed(AppRoutes.viewpdf);
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          backgroundColor: AppColors.primary,
                        ),
                        child: Text(
                          'Download',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
