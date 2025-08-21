import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icg_navy/utility/app_images.dart';
import 'package:icg_navy/utility/app_routes.dart';

import '../../../utility/app_colors.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key});

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
          'Confirmation',
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
          SizedBox(height: screenHeight * 0.05),

          Container(
            padding: EdgeInsets.all(50),
            child: Column(
              children: [
                SvgPicture.asset(AppImages.checkIcon),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  "Confirmation",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    color: AppColors.defaultblack,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  "Your appointment has been scheduled successfully.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    color: AppColors.defaultblack,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              margin: EdgeInsets.only(left: 3),
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColors.borderColor.withOpacity(0.5),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  AppImages.calenderBlueIcon,
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Scheduled Due Date",
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primary,
                                      fontSize: 13,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    "24 August 2025",
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.defaultblack,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Card(
                          color: AppColors.green.withOpacity(0.1),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: AppColors.green,
                                  size: 20,
                                ),
                                SizedBox(width: 8.0),
                                Flexible(
                                  // Add Flexible here
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Application Submitted Successfully",
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.green,
                                          fontSize: 13,
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        "Please keep a note of your scheduled date for future reference.",
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.defaultblack,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                OutlinedButton(
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
                    foregroundColor: AppColors.defaultblack, // Text/icon color
                  ),
                  child: Text(
                    'Go To Dashboard',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.defaultblack,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
