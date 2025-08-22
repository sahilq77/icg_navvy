import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:icg_navy/controller/medical_officer/processed_appoinment/processed_appoinment_medical_controller.dart';
import '../../../controller/appoinment_history/appoinment_history_controller.dart';
import '../../../controller/my_report/my_report_controlller.dart';
import '../../../utility/app_colors.dart';
import '../../../utility/app_images.dart';
import '../../bottomnavigation/bottomnavigation.dart' show CustomBottomBar;

class ProceessedAppoinmetMedicalScreen extends StatefulWidget {
  @override
  State<ProceessedAppoinmetMedicalScreen> createState() =>
      _ProceessedAppoinmetMedicalScreenState();
}

class _ProceessedAppoinmetMedicalScreenState
    extends State<ProceessedAppoinmetMedicalScreen> {
  final ProcessedAppoinmentMedicalController controller = Get.put(
    ProcessedAppoinmentMedicalController(),
  );

  void _showFilterBottomSheet(BuildContext context) {
    DateTime? fromDate = DateTime(2025, 8, 22);
    DateTime? toDate = DateTime(2025, 8, 24);
    String patientName = "Priya Kumar";
    String appointmentType = "Select Type";
    String relation = "Select";

    showModalBottomSheet(
      backgroundColor: AppColors.background,
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        height: 5,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Color(0xFF6B7280),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Filters',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            size: 30,
                            Icons.close_sharp,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'From Date',
                              suffixIcon: Icon(Icons.calendar_today),
                              border: OutlineInputBorder(),
                            ),
                            controller: TextEditingController(
                              text: fromDate.toString().split(' ')[0],
                            ),
                            readOnly: true,
                            onTap: () async {
                              DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: fromDate ?? DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );
                              if (picked != null && picked != fromDate)
                                setState(() => fromDate = picked);
                            },
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'To Date',
                              suffixIcon: Icon(Icons.calendar_today),
                              border: OutlineInputBorder(),
                            ),
                            controller: TextEditingController(
                              text: toDate.toString().split(' ')[0],
                            ),
                            readOnly: true,
                            onTap: () async {
                              DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: toDate ?? DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );
                              if (picked != null && picked != toDate)
                                setState(() => toDate = picked);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    DropdownSearch<String>(
                      popupProps: PopupProps.menu(
                        showSearchBox: true,
                        searchFieldProps: TextFieldProps(
                          decoration: InputDecoration(
                            labelText: 'Search Appointment Type',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      items: [
                        'Select Type',
                        'OPD Appointment',
                        'AME/PME Appointment',
                        'Follow-up',
                      ],
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: 'Appointment Type',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          appointmentType = newValue ?? 'Select Type';
                        });
                      },
                      selectedItem: appointmentType,
                    ),
                    SizedBox(height: 16),
                    DropdownSearch<String>(
                      popupProps: PopupProps.menu(
                        showSearchBox: true,
                        searchFieldProps: TextFieldProps(
                          decoration: InputDecoration(
                            labelText: 'Search Relation',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      items: [
                        'Select',
                        'Self',
                        'Wife',
                        'Husband',
                        'Child',
                        'Parent',
                      ],
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: 'Relation',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          relation = newValue ?? 'Select';
                        });
                      },
                      selectedItem: relation,
                    ),
                    SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Patient Name',
                        border: OutlineInputBorder(),
                      ),
                      controller: TextEditingController(text: patientName),
                      onChanged: (value) => setState(() => patientName = value),
                    ),
                    SizedBox(height: 16),
                    Divider(),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              controller.resetFilters();
                              Get.back();
                            },
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              side: BorderSide(
                                color: AppColors.primary,
                                width: 1.5,
                              ),
                              foregroundColor: AppColors.defaultblack,
                            ),
                            child: Text(
                              'Clear',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              controller.filterAppointments(
                                patientName: patientName,
                                appointmentType:
                                    appointmentType == 'Select Type'
                                    ? null
                                    : appointmentType,
                                relation: relation == 'Select'
                                    ? null
                                    : relation,
                                fromDate: fromDate,
                                toDate: toDate,
                              );
                              Get.back();
                            },
                            child: Text(
                              'Apply',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'List of Processed',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            color: AppColors.defaultblack,
            fontSize: 18,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              _showFilterBottomSheet(context);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                border: Border.all(color: Color(0xFFDADADA), width: 1.0),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Filter',
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  Icon(
                    Icons.filter_alt_outlined,
                    color: Colors.black,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(10),
          child: Divider(color: const Color(0xFFDADADA), height: 0),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () => ListView.builder(
            itemCount: controller.appointments.length,
            itemBuilder: (context, index) {
              final appointment = controller.appointments[index];
              return AppointmentCard(
                name: appointment.name,
                relation: appointment.relation,
                age: appointment.age,
                gender: appointment.gender,
                status: appointment.status,
                type: appointment.type,
                hospital: appointment.hospital,
                department: appointment.department,
                date: appointment.date,
              );
            },
          ),
        ),
      ),
      //bottomNavigationBar: CustomBottomBar(),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final String name;
  final String relation;
  final int age;
  final String gender;
  final String status;
  final String type;
  final String hospital;
  final String department;
  final String date;

  AppointmentCard({
    required this.name,
    required this.relation,
    required this.age,
    required this.gender,
    required this.status,
    required this.type,
    required this.hospital,
    required this.department,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, Color> statusColors = {
      'approved': Colors.green[100]!,
      'processed': Colors.orange[100]!,
      'pending': Colors.yellow[100]!,
    };

    Color statusColor = statusColors[status.toLowerCase()] ?? Colors.grey[100]!;

    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Handle overflow for name
                Expanded(
                  child: Text(
                    name,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis, // Truncate with ellipsis
                    maxLines: 1, // Limit to one line
                  ),
                ),
                // Uncomment if you want to include the status container
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                //   decoration: BoxDecoration(
                //     color: statusColor,
                //     borderRadius: BorderRadius.circular(12.0),
                //   ),
                //   child: Text(
                //     status,
                //     style: GoogleFonts.inter(
                //       fontSize: 12,
                //       fontWeight: FontWeight.w500,
                //       color: Colors.black,
                //     ),
                //     overflow: TextOverflow.ellipsis,
                //     maxLines: 1,
                //   ),
                // ),
              ],
            ),
            // Handle overflow for relation, age, and gender
            Text(
              '$relation • $age years • $gender',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                SvgPicture.asset(AppImages.calenderPlusgreyIcon),
                SizedBox(width: 4.0),
                // Handle overflow for type
                Expanded(
                  child: Text(
                    type,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Row(
              children: [
                SvgPicture.asset(AppImages.hospitalgreyIcon),
                SizedBox(width: 4.0),
                // Handle overflow for hospital
                Expanded(
                  child: Text(
                    hospital,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Row(
              children: [
                SvgPicture.asset(AppImages.doctorgreyIcon),
                SizedBox(width: 4.0),
                // Handle overflow for department
                Expanded(
                  child: Text(
                    department,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Row(
              children: [
                SvgPicture.asset(AppImages.calendergreyIcon),
                SizedBox(width: 4.0),
                // Handle overflow for date
                Expanded(
                  child: Text(
                    date,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            // Uncomment if you want to include the button
            // SizedBox(height: 8.0),
            // ElevatedButton(
            //   onPressed: () {},
            //   child: Text(
            //     'Download Report',
            //     style: GoogleFonts.inter(
            //       fontSize: 14,
            //       fontWeight: FontWeight.w500,
            //       color: AppColors.white,
            //     ),
            //   ),
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: AppColors.primary,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
