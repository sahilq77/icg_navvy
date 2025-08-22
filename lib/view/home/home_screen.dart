import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icg_navy/utility/app_images.dart';
import 'package:icg_navy/utility/app_routes.dart';
import 'package:icg_navy/view/bottomnavigation/bottomnavigation.dart';
import 'package:shimmer/shimmer.dart';

import '../../controller/bottomnavigation/bottom_navigation_controller.dart';
import '../../utility/app_colors.dart';
import '../../utility/app_utility.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final CompanyController companyController = Get.put(CompanyController());
  // final DivsionController divisonController = Get.put(DivsionController());
  // final DashboardController controller = Get.put(DashboardController());
  // final TransportController transportController = Get.put(
  //   TransportController(),
  // );
  final BottomNavigationController bottomController = Get.put(
    BottomNavigationController(),
  );
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
    return WillPopScope(
      onWillPop: () => bottomController.onWillPop(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(
              40.0,
            ), // Height of the bottom area
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(
                bottom: 16.0,
              ), // Optional padding for better positioning
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Welcome To ICG",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                            fontSize: 20,
                          ),
                          overflow:
                              TextOverflow.ellipsis, // or TextOverflow.clip
                          // maxLines: 2, // Allow up to 2 lines for the text
                        ),
                        SizedBox(width: 10),
                        SvgPicture.asset(AppImages.navyCapIcon),
                      ],
                    ),
                    Icon(
                      Icons.power_settings_new,
                      color: Colors.white,
                      size: 40,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Medical Officer Dashboard',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.defaultblack,
                  ),
                ),
                SizedBox(height: screenHeight * 0.005),
                Text(
                  'Track Pending, Processed & Approved Appointment',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.grey,
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(vertical: 16),
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
                        icon: AppImages.pendingIcon,
                        color: const Color(0xFFFEF9C3),
                        text: 'Total Number of Pending',
                        tap: () {
                          Get.toNamed(AppRoutes.pendingAppoinmentMedical);
                        },
                      ),
                      _buildCard(
                        icon: AppImages.processedIcon,
                        color: const Color(0xFFFFEDD5),
                        text: 'Total Number of Processed',
                        tap: () {
                          Get.toNamed(AppRoutes.proceessedAppoinmetMedical);
                        },
                      ),
                      _buildCard(
                        icon: AppImages.approvedIcon,
                        color: AppColors.green.withOpacity(0.1),
                        text: 'Total Number of Approved',
                        tap: () {
                          Get.toNamed(AppRoutes.approvedAppoinmentMedical);
                        },
                      ),
                      _buildCard(
                        icon: AppImages.notificationIcon,
                        color: const Color(0xFF7441CD).withOpacity(0.1),
                        text: 'Notification',
                        tap: () {
                          Get.toNamed(AppRoutes.notification);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Container(
            //       padding: EdgeInsets.all(8),
            //       decoration: BoxDecoration(
            //         color: AppColors.green.withOpacity(0.1),
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //       child: ListTile(
            //         leading: Container(
            //           height: 50,
            //           width: 50,
            //           padding: EdgeInsets.all(12),
            //           decoration: BoxDecoration(
            //             shape: BoxShape.circle,
            //             color: AppColors.green.withOpacity(0.3),
            //           ),
            //           child: SvgPicture.asset(
            //             AppImages.calenderCheck,
            //             height: 18,
            //             width: 18,
            //           ),
            //         ),
            //         title: Text(
            //           'Booking Confirmed',
            //           style: GoogleFonts.inter(
            //             fontSize: 16,
            //             fontWeight: FontWeight.w600,
            //             color: AppColors.green,
            //           ),
            //         ),
            //         subtitle: Text(
            //           'Booking Confirmed',
            //           style: GoogleFonts.inter(
            //             fontSize: 12,
            //             fontWeight: FontWeight.w600,
            //             color: AppColors.green,
            //           ),
            //         ),
            //         trailing: SvgPicture.asset(
            //           AppImages.nextArrow,
            //           // height: 18,
            //           // width: 18,
            //         ),
            //       ),
            //     ),
            //     SizedBox(height: screenHeight * 0.02),
            //     Text(
            //       'Appointment Dashboard',
            //       style: GoogleFonts.inter(
            //         fontSize: 16,
            //         fontWeight: FontWeight.w600,
            //         color: AppColors.defaultblack,
            //       ),
            //     ),
            //     SizedBox(height: screenHeight * 0.005),
            //     Text(
            //       'Manage your medical appointments',
            //       style: GoogleFonts.inter(
            //         fontSize: 13,
            //         fontWeight: FontWeight.w600,
            //         color: AppColors.grey,
            //       ),
            //     ),
            //     Container(
            //       padding: EdgeInsets.all(16),
            //       decoration: BoxDecoration(
            //         color: const Color(0xFFF9FAFB),
            //         borderRadius: BorderRadius.circular(8),
            //       ),
            //       child: GridView.count(
            //         physics: NeverScrollableScrollPhysics(),
            //         shrinkWrap: true,
            //         crossAxisCount: 2,

            //         crossAxisSpacing: 16.0,
            //         mainAxisSpacing: 16.0,
            //         childAspectRatio:
            //             1.4, // Makes grid items rectangular (wider than tall)
            //         children: [
            //           _buildCard(
            //             icon: AppImages.calenderPlusIcon,
            //             color: const Color(0xFFE5E7EB),
            //             text: 'Schedule Appointment',
            //             tap: () {
            //               Get.toNamed(AppRoutes.appoinmentType);
            //             },
            //           ),
            //           _buildCard(
            //             icon: AppImages.myAppoinmentIcon,
            //             color: const Color(0xFF0EA5E9).withOpacity(0.1),
            //             text: 'My Appointment',
            //             tap: () {
            //               Get.toNamed(AppRoutes.appoinmentHistory);
            //             },
            //           ),
            //           _buildCard(
            //             icon: AppImages.myReportIcon,
            //             color: AppColors.green.withOpacity(0.1),
            //             text: 'My Report',
            //             tap: () {
            //               Get.toNamed(AppRoutes.myReportlist);
            //             },
            //           ),
            //           _buildCard(
            //             icon: AppImages.notificationIcon,
            //             color: const Color(0xFF7441CD).withOpacity(0.1),
            //             text: 'Notification',
            //             tap: () {
            //               Get.toNamed(AppRoutes.notification);
            //             },
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
          ),
        ),
        bottomNavigationBar: CustomBottomBar(),
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
                maxLines: 2, // Allow up to 2 lines for the text
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
