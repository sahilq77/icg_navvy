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

  // void _showFilterBottomSheet() {
  //   String? tempSelectedCompanyId =
  //       controller.selectedCompanyId.value.isNotEmpty
  //       ? controller.selectedCompanyId.value
  //       : null;
  //   String? tempSelectedDivisionId =
  //       controller.selectedDivisionId.value.isNotEmpty
  //       ? controller.selectedDivisionId.value
  //       : null;
  //   String? tempSelectedTransportId =
  //       controller.selectedTransportId.value.isNotEmpty
  //       ? controller.selectedTransportId.value
  //       : null;
  //   String? tempSelectedMonth = controller.selectedMonth.value.isNotEmpty
  //       ? controller.selectedMonth.value
  //       : null;
  //   int? tempSelectedYear = controller.selectedYear.value != 0
  //       ? controller.selectedYear.value
  //       : null;

  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //     ),
  //     builder: (context) {
  //       return StatefulBuilder(
  //         builder: (BuildContext context, StateSetter setBottomSheetState) {
  //           return Padding(
  //             padding: EdgeInsets.only(
  //               bottom: MediaQuery.of(context).viewInsets.bottom,
  //               left: 16,
  //               right: 16,
  //               top: 16,
  //             ),
  //             child: SingleChildScrollView(
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   const Text(
  //                     'Filter',
  //                     style: TextStyle(
  //                       fontSize: 20,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                   const SizedBox(height: 16),
  //                   Obx(
  //                     () => SizedBox(
  //                       height: 55,
  //                       child: DropdownSearch<String>(
  //                         popupProps: const PopupProps.menu(
  //                           showSearchBox: true,
  //                           showSelectedItems: true,
  //                           searchFieldProps: TextFieldProps(
  //                             decoration: InputDecoration(
  //                               labelText: 'Search Company',
  //                               border: OutlineInputBorder(),
  //                             ),
  //                           ),
  //                         ),
  //                         items: companyController.getCompanyNames(),
  //                         dropdownDecoratorProps: const DropDownDecoratorProps(
  //                           dropdownSearchDecoration: InputDecoration(
  //                             labelText: 'Select Company',
  //                             border: OutlineInputBorder(),
  //                             contentPadding: EdgeInsets.symmetric(
  //                               horizontal: 12,
  //                             ),
  //                             constraints: BoxConstraints.tightFor(height: 55),
  //                           ),
  //                           baseStyle: TextStyle(fontSize: 16),
  //                         ),
  //                         onChanged: (String? selectedCompanyName) {
  //                           if (selectedCompanyName != null) {
  //                             setState(() {
  //                               tempSelectedCompanyId = companyController
  //                                   .getCompanyId(selectedCompanyName);
  //                               tempSelectedDivisionId = null;
  //                               divisonController.divisionList.clear();
  //                               divisonController.fetchDivison(
  //                                 context: context,
  //                                 comapnyID: tempSelectedCompanyId,
  //                               );
  //                             });
  //                           }
  //                         },
  //                         selectedItem: tempSelectedCompanyId != null
  //                             ? companyController.getCompanyNameById(
  //                                 tempSelectedCompanyId!,
  //                               )
  //                             : null,
  //                         enabled: !companyController.isLoading.value,
  //                         dropdownBuilder: (context, selectedItem) {
  //                           return Container(
  //                             alignment: Alignment.centerLeft,
  //                             child: Text(
  //                               selectedItem ?? 'Select Company',
  //                               style: TextStyle(
  //                                 fontSize: 16,
  //                                 color: companyController.isLoading.value
  //                                     ? Colors.grey
  //                                     : Colors.black,
  //                               ),
  //                             ),
  //                           );
  //                         },
  //                       ),
  //                     ),
  //                   ),
  //                   const SizedBox(height: 16),
  //                   Obx(
  //                     () => SizedBox(
  //                       height: 55,
  //                       child: DropdownSearch<String>(
  //                         popupProps: const PopupProps.menu(
  //                           showSearchBox: true,
  //                           showSelectedItems: true,
  //                           searchFieldProps: TextFieldProps(
  //                             decoration: InputDecoration(
  //                               labelText: 'Search Division',
  //                               border: OutlineInputBorder(),
  //                             ),
  //                           ),
  //                         ),
  //                         items: divisonController.getDivisionNames(),
  //                         dropdownDecoratorProps: const DropDownDecoratorProps(
  //                           dropdownSearchDecoration: InputDecoration(
  //                             labelText: 'Select Division',
  //                             border: OutlineInputBorder(),
  //                             contentPadding: EdgeInsets.symmetric(
  //                               horizontal: 12,
  //                             ),
  //                             constraints: BoxConstraints.tightFor(height: 55),
  //                           ),
  //                           baseStyle: TextStyle(fontSize: 16),
  //                         ),
  //                         onChanged: (String? selectedDivisionName) {
  //                           if (selectedDivisionName != null) {
  //                             setBottomSheetState(() {
  //                               tempSelectedDivisionId = divisonController
  //                                   .getDivisionId(selectedDivisionName);
  //                             });
  //                           }
  //                         },
  //                         selectedItem: tempSelectedDivisionId != null
  //                             ? divisonController.getDivisionNameById(
  //                                 tempSelectedDivisionId!,
  //                               )
  //                             : null,
  //                         enabled: !divisonController.isLoading.value,
  //                         dropdownBuilder: (context, selectedItem) {
  //                           return Container(
  //                             alignment: Alignment.centerLeft,
  //                             child: Text(
  //                               selectedItem ?? 'Select Division',
  //                               style: TextStyle(
  //                                 fontSize: 16,
  //                                 color: divisonController.isLoading.value
  //                                     ? Colors.grey
  //                                     : Colors.black,
  //                               ),
  //                             ),
  //                           );
  //                         },
  //                       ),
  //                     ),
  //                   ),
  //                   const SizedBox(height: 16),
  //                   Obx(
  //                     () => SizedBox(
  //                       height: 55,
  //                       child: DropdownSearch<String>(
  //                         popupProps: const PopupProps.menu(
  //                           showSearchBox: true,
  //                           showSelectedItems: true,
  //                           searchFieldProps: TextFieldProps(
  //                             decoration: InputDecoration(
  //                               labelText: 'Search Transport',
  //                               border: OutlineInputBorder(),
  //                             ),
  //                           ),
  //                         ),
  //                         items: transportController.getTransportNames(),
  //                         dropdownDecoratorProps: const DropDownDecoratorProps(
  //                           dropdownSearchDecoration: InputDecoration(
  //                             labelText: 'Select Transport',
  //                             border: OutlineInputBorder(),
  //                             contentPadding: EdgeInsets.symmetric(
  //                               horizontal: 12,
  //                             ),
  //                             constraints: BoxConstraints.tightFor(height: 55),
  //                           ),
  //                           baseStyle: TextStyle(fontSize: 16),
  //                         ),
  //                         onChanged: (String? selectedTransportName) {
  //                           if (selectedTransportName != null) {
  //                             setBottomSheetState(() {
  //                               tempSelectedTransportId = transportController
  //                                   .getTransportId(selectedTransportName);
  //                             });
  //                           }
  //                         },
  //                         selectedItem: tempSelectedTransportId != null
  //                             ? transportController.getTransportNameById(
  //                                 tempSelectedTransportId!,
  //                               )
  //                             : null,
  //                         enabled: !transportController.isLoading.value,
  //                         dropdownBuilder: (context, selectedItem) {
  //                           return Container(
  //                             alignment: Alignment.centerLeft,
  //                             child: Text(
  //                               selectedItem ?? 'Select Transport',
  //                               style: TextStyle(
  //                                 fontSize: 16,
  //                                 color: transportController.isLoading.value
  //                                     ? Colors.grey
  //                                     : Colors.black,
  //                               ),
  //                             ),
  //                           );
  //                         },
  //                       ),
  //                     ),
  //                   ),
  //                   const SizedBox(height: 16),
  //                   SizedBox(
  //                     height: 55,
  //                     child: DropdownSearch<String>(
  //                       popupProps: const PopupProps.menu(
  //                         showSearchBox: true,
  //                         showSelectedItems: true,
  //                         searchFieldProps: TextFieldProps(
  //                           decoration: InputDecoration(
  //                             labelText: 'Search Month',
  //                             border: OutlineInputBorder(),
  //                           ),
  //                         ),
  //                       ),
  //                       items: _months,
  //                       dropdownDecoratorProps: const DropDownDecoratorProps(
  //                         dropdownSearchDecoration: InputDecoration(
  //                           labelText: 'Select Month',
  //                           border: OutlineInputBorder(),
  //                           contentPadding: EdgeInsets.symmetric(
  //                             horizontal: 12,
  //                           ),
  //                           constraints: BoxConstraints.tightFor(height: 55),
  //                         ),
  //                         baseStyle: TextStyle(fontSize: 16),
  //                       ),
  //                       onChanged: (String? selectedMonth) {
  //                         setBottomSheetState(() {
  //                           tempSelectedMonth = selectedMonth;
  //                         });
  //                       },
  //                       selectedItem: tempSelectedMonth,
  //                       dropdownBuilder: (context, selectedItem) {
  //                         return Container(
  //                           alignment: Alignment.centerLeft,
  //                           child: Text(
  //                             selectedItem ?? 'Select Month',
  //                             style: const TextStyle(
  //                               fontSize: 16,
  //                               color: Colors.black,
  //                             ),
  //                           ),
  //                         );
  //                       },
  //                     ),
  //                   ),
  //                   const SizedBox(height: 16),
  //                   SizedBox(
  //                     height: 55,
  //                     child: DropdownSearch<String>(
  //                       popupProps: const PopupProps.menu(
  //                         showSearchBox: true,
  //                         showSelectedItems: true,
  //                         searchFieldProps: TextFieldProps(
  //                           decoration: InputDecoration(
  //                             labelText: 'Search Year',
  //                             border: OutlineInputBorder(),
  //                           ),
  //                         ),
  //                       ),
  //                       items: _getYears()
  //                           .map((year) => year.toString())
  //                           .toList(),
  //                       dropdownDecoratorProps: const DropDownDecoratorProps(
  //                         dropdownSearchDecoration: InputDecoration(
  //                           labelText: 'Select Year',
  //                           border: OutlineInputBorder(),
  //                           contentPadding: EdgeInsets.symmetric(
  //                             horizontal: 12,
  //                           ),
  //                           constraints: BoxConstraints.tightFor(height: 55),
  //                         ),
  //                         baseStyle: TextStyle(fontSize: 16),
  //                       ),
  //                       onChanged: (String? selectedYear) {
  //                         setBottomSheetState(() {
  //                           tempSelectedYear = selectedYear != null
  //                               ? int.parse(selectedYear)
  //                               : null;
  //                         });
  //                       },
  //                       selectedItem: tempSelectedYear?.toString(),
  //                       dropdownBuilder: (context, selectedItem) {
  //                         return Container(
  //                           alignment: Alignment.centerLeft,
  //                           child: Text(
  //                             selectedItem ?? 'Select Year',
  //                             style: const TextStyle(
  //                               fontSize: 16,
  //                               color: Colors.black,
  //                             ),
  //                           ),
  //                         );
  //                       },
  //                     ),
  //                   ),
  //                   const SizedBox(height: 16),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Expanded(
  //                         child: ElevatedButton(
  //                           onPressed: () async {
  //                             setBottomSheetState(() {
  //                               tempSelectedCompanyId = null;
  //                               tempSelectedDivisionId = null;
  //                               tempSelectedTransportId = null;
  //                               tempSelectedMonth = null;
  //                               tempSelectedYear = null;
  //                             });
  //                             controller.fetchInwardList(
  //                               context: context,
  //                               reset: true,
  //                               companyId: null,
  //                               divisionId: null,
  //                               transportId: null,
  //                               month: null,
  //                               year: null,
  //                             );
  //                             Navigator.pop(context);
  //                           },
  //                           child: const Text('Clear Filter'),
  //                           style: ElevatedButton.styleFrom(
  //                             backgroundColor: Colors.white,
  //                             foregroundColor: AppColors.primary,
  //                             shape: RoundedRectangleBorder(
  //                               borderRadius: BorderRadius.circular(10),
  //                               side: BorderSide(color: AppColors.primary),
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                       const SizedBox(width: 16),
  //                       Expanded(
  //                         child: ElevatedButton(
  //                           onPressed: () {
  //                             controller.fetchInwardList(
  //                               context: context,
  //                               reset: true,
  //                               companyId: tempSelectedCompanyId,
  //                               divisionId: tempSelectedDivisionId,
  //                               transportId: tempSelectedTransportId,
  //                               month: tempSelectedMonth,
  //                               year: tempSelectedYear,
  //                             );
  //                             Navigator.pop(context);
  //                           },
  //                           child: const Text('Apply Filter'),
  //                           style: ElevatedButton.styleFrom(
  //                             backgroundColor: AppColors.primary,
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   const SizedBox(height: 16),
  //                 ],
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("Dashboard", style: TextStyle(color: Colors.white)),
        actions: [
          // IconButton(
          //   onPressed: _showFilterBottomSheet,
          //   icon: const Icon(Icons.filter_list),
          // ),
        ],
        elevation: 2,
        backgroundColor: AppColors.primary,
      ),

      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.green.withOpacity(0.3),
                    ),
                    child: SvgPicture.asset(
                      AppImages.calenderCheck,
                      height: 18,
                      width: 18,
                    ),
                  ),
                  title: Text(
                    'Booking Confirmed',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.green,
                    ),
                  ),
                  subtitle: Text(
                    'Booking Confirmed',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.green,
                    ),
                  ),
                  trailing: SvgPicture.asset(
                    AppImages.nextArrow,
                    // height: 18,
                    // width: 18,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                'Appointment Dashboard',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.defaultblack,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                'Manage your medical appointments',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.grey,
                ),
              ),
              // Container(
              //   padding: EdgeInsets.all(16),
              //   decoration: BoxDecoration(
              //     color: const Color(0xFFF9FAFB),
              //     borderRadius: BorderRadius.circular(8),
              //   ),
              //   child: GridView.count(
              //     physics: NeverScrollableScrollPhysics(),
              //     shrinkWrap: true,
              //     crossAxisCount: 2,

              //     crossAxisSpacing: 16.0,
              //     mainAxisSpacing: 16.0,
              //     childAspectRatio:
              //         1.4, // Makes grid items rectangular (wider than tall)
              //     children: [
              //       _buildCard(
              //         icon: AppImages.calenderPlusIcon,
              //         color: Colors.blue[100],
              //         text: 'Schedule Appointment',
              //         tap: () {},
              //       ),
              //       _buildCard(
              //         icon: AppImages.myAppoinmentIcon,
              //         color: Colors.blue[100],
              //         text: 'My Appointment',
              //         tap: () {},
              //       ),
              //       _buildCard(
              //         icon: AppImages.myReportIcon,
              //         color: Colors.green[100],
              //         text: 'My Report',
              //         tap: () {},
              //       ),
              //       _buildCard(
              //         icon: AppImages.notificationIcon,
              //         color: Colors.purple[100],
              //         text: 'Notification',
              //         tap: () {},
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
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
