import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icg_navy/utility/app_images.dart';
import 'package:icg_navy/utility/app_routes.dart';
import 'package:shimmer/shimmer.dart';

import '../../utility/app_colors.dart';
import '../../utility/app_utility.dart';

class ApppointmentTypeScreen extends StatefulWidget {
  const ApppointmentTypeScreen({super.key});

  @override
  State<ApppointmentTypeScreen> createState() => _ApppointmentTypeScreenState();
}

class _ApppointmentTypeScreenState extends State<ApppointmentTypeScreen> {
  // final CompanyController companyController = Get.put(CompanyController());
  // final DivsionController divisonController = Get.put(DivsionController());
  // final DashboardController controller = Get.put(DashboardController());
  // final TransportController transportController = Get.put(
  //   TransportController(),
  // );

  final List<String> _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  List<int> _getYears() {
    final currentYear = DateTime.now().year;
    return List.generate(10, (index) => currentYear - index);
  }

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
          'Schedule appointment',
          // textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            color: AppColors.defaultblack,
            fontSize: 18,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: Divider(
            color: const Color(0xFFDADADA),
            // thickness: 2,
            height: 0,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose Appointment Type',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(8),
              ),
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,

                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio:
                    1.4, // Makes grid items rectangular (wider than tall)
                children: [
                  _buildCard(
                    icon: AppImages.opdIcon,
                    color: const Color(0xFFE5E7EB),
                    text: 'OPD',
                    tap: () {
                      Get.toNamed(AppRoutes.scheduleAppinment);
                    },
                  ),
                  _buildCard(
                    icon: AppImages.ameIcon,
                    color: const Color(0xFFE5E7EB),
                    text: 'AME / PME',
                    tap: () {
                      Get.toNamed(AppRoutes.scheduleAppinmentAME);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({
    required String icon,
    required Color? color,
    required String text,
    required VoidCallback tap,
  }) {
    return GestureDetector(
      onTap: tap,
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(13),
                decoration: BoxDecoration(shape: BoxShape.circle, color: color),
                child: SvgPicture.asset(icon),
              ),
              const SizedBox(height: 10.0),
              Text(
                text,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.defaultblack,
                ),
                overflow: TextOverflow.ellipsis, // or TextOverflow.clip
                // maxLines: 2, // Allow up to 2 lines for the text
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildNoDataWidget(double screenHeight) {
  return SizedBox(
    height: screenHeight * 0.5,
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.info_outline, size: 48, color: AppColors.grey),
          const SizedBox(height: 16),
          Text(
            'No Data Available',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Please apply Filter or refresh to load data.',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: AppColors.grey.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}

Text _sectionTitle(String title) {
  return Text(
    title,
    style: GoogleFonts.poppins(
      color: AppColors.grey,
      fontWeight: FontWeight.w600,
      fontSize: 18,
    ),
  );
}

Widget _buildShimmerGrid(double screenWidth) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: screenWidth * 0.04,
      mainAxisSpacing: screenWidth * 0.04,
      childAspectRatio: 1.1,
      children: List.generate(8, (index) => _buildShimmerItem()),
    ),
  );
}

Widget _buildShimmerItem() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(width: 32, height: 32, color: Colors.white),
        const SizedBox(height: 8),
        Container(width: 60, height: 28, color: Colors.white),
        const SizedBox(height: 8),
        Container(width: 100, height: 28, color: Colors.white),
      ],
    ),
  );
}
