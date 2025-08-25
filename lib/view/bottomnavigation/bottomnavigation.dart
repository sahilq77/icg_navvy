import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:icg_navy/utility/app_utility.dart';

import '../../controller/bottomnavigation/bottom_navigation_controller.dart';
import '../../utility/app_colors.dart';
import '../../utility/app_images.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({super.key});

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BottomNavigationController());
    return Container(
      height: 70.0,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Obx(
        () => AppUtility.userType == "0"
            ? _indivisualUser(controller)
            : _officer(controller),
      ),
    );
  }

  Row _indivisualUser(BottomNavigationController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildNavItem(
          index: 0,
          assetPath: AppImages.homeIcon,
          label: 'Home',
          controller: controller,
        ),
        _buildNavItem(
          index: 1,
          assetPath: AppImages.crownIcon,
          label: 'AME/PME',
          controller: controller,
        ),
        _buildNavItem(
          index: 2,
          assetPath: AppImages.leadsIcon,
          label: 'OPD',
          controller: controller,
        ),
        _buildNavItem(
          index: 3,
          assetPath: AppImages.videoIcon,
          label: 'Report',
          controller: controller,
        ),
      ],
    );
  }

  Row _officer(BottomNavigationController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildNavItem(
          index: 0,
          assetPath: AppImages.homeIcon,
          label: 'Home',
          controller: controller,
        ),
        _buildNavItem(
          index: 1,
          assetPath: AppImages.myAppoinmnetIcon,
          label: 'My Appointments',
          controller: controller,
        ),
        _buildNavItem(
          index: 2,
          assetPath: AppImages.bellGreyIcon,
          label: 'Notification',
          controller: controller,
        ),
        _buildNavItem(
          index: 3,
          assetPath: AppImages.switchGrey,
          label: 'logout',
          controller: controller,
        ),
      ],
    );
  }

  Widget _buildNavItem({
    required int index,
    required String assetPath,
    required String label,
    required BottomNavigationController controller,
  }) {
    final isSelected = controller.selectedIndex.value == index;
    final iconColor = isSelected ? AppColors.primary : Colors.grey;
    final textColor = isSelected ? AppColors.primary : Colors.grey;
    final fontWeight = isSelected ? FontWeight.w600 : FontWeight.normal;

    return GestureDetector(
      onTap: () => controller.changeTab(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              assetPath,
              width: 25.0,
              height: 25.0,
              color: iconColor,
              colorBlendMode: BlendMode.srcIn,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error, size: 20.0, color: Colors.red),
            ),
            // Image.asset(
            //   assetPath,
            //   width: 20.0,
            //   height: 20.0,
            //   color: iconColor,
            //   colorBlendMode: BlendMode.srcIn,
            //   errorBuilder: (context, error, stackTrace) => const Icon(
            //     Icons.error,
            //     size: 20.0,
            //     color: Colors.red,
            //   ),
            // ),
            const SizedBox(height: 4.0),
            Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: 12.0,
                fontWeight: fontWeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
