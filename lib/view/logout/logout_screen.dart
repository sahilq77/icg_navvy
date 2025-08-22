import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icg_navy/utility/app_images.dart';
import 'package:icg_navy/utility/app_routes.dart';
import 'package:icg_navy/utility/app_utility.dart';

import '../../../utility/app_colors.dart';
import '../../controller/bottomnavigation/bottom_navigation_controller.dart';
import '../../controller/splash/splash_controller.dart';
import '../bottomnavigation/bottomnavigation.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final bottomController = Get.put(BottomNavigationController());
    return WillPopScope(
      onWillPop: () => bottomController.onWillPop(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: AppColors.background,
          elevation: 0,
          centerTitle: false,
          title: Text(
            '',
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
            SizedBox(height: screenHeight * 0.2),

            Container(
              padding: EdgeInsets.all(50),
              child: Column(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.power_settings_new,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    "Stay safe, Guardian!",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      color: AppColors.defaultblack,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    "Are you sure you want to logout?",
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
                            'Cancel',
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
                          onPressed: () async {
                            // Final submission logic
                            // Get.snackbar(
                            //   "Success",
                            //   "Application successfully submitted!",
                            // );
                            // Optionally navigate to a confirmation screen or home
                            await AppUtility.clearUserInfo();
                            Get.offNamed(AppRoutes.login);
                            Get.snackbar(
                              'Success',
                              'Logout Successfully!',
                              backgroundColor: AppColors.success,
                              colorText: Colors.white,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            backgroundColor: AppColors.primary,
                          ),
                          child: Text(
                            'Logout',
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
        bottomNavigationBar: AppUtility.userType != "0"
            ? CustomBottomBar()
            : SizedBox.shrink(),
      ),
    );
  }
}
