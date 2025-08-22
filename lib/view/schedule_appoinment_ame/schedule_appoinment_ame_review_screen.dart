import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icg_navy/utility/app_colors.dart';
import 'package:icg_navy/utility/app_images.dart';
import 'package:icg_navy/utility/app_routes.dart';
import 'package:icg_navy/view/schedule_appoinment_ame/schedule_appoinment_ame_screen.dart'
    show ScheduleAppointmentController;

// Assuming AppointmentModel and ScheduleAppointmentController are the same as provided
// Import the same AppointmentModel and ScheduleAppointmentController from your code
// (I've included them in the reference but won't repeat here for brevity)

class ScheduleAppointmentAmeReviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ScheduleAppointmentController>();

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'Review Appointment AME/PME',
          textAlign: TextAlign.center,
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

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle(AppImages.personIcon, "Personal Details"),
                      SizedBox(height: 10),
                      _reviewField(
                        "Personal Number",
                        controller.appointment.value.personalNumber,
                      ),
                      _reviewField("Rank", controller.appointment.value.rank),
                      _reviewField("Name", controller.appointment.value.name),
                      _reviewField(
                        "Blood Group",
                        controller.appointment.value.bloodGroup,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle(AppImages.serviceIcon, "Service Details"),
                      SizedBox(height: 10),
                      _reviewField(
                        "Command",
                        controller.appointment.value.command,
                      ),
                      _reviewField("Unit", controller.appointment.value.unit),
                      _reviewField(
                        "Arm/Corps/Branch/Trade",
                        controller.appointment.value.armCorpsBranchTrade,
                      ),
                      _reviewField(
                        "Gender",
                        controller.appointment.value.gender,
                      ),
                      SizedBox(width: 10),
                      _reviewField(
                        "Service",
                        controller.appointment.value.service,
                      ),
                      _reviewField(
                        "Date of Birth",
                        controller.appointment.value.dateOfBirth,
                      ),
                      _reviewField(
                        "Total Service",
                        controller.appointment.value.totalService,
                      ),
                      SizedBox(width: 10),
                      _reviewField(
                        "Date of Commission",
                        controller.appointment.value.dateOfCommission,
                      ),
                      _reviewField(
                        "Last AME/PME Carried Out At",
                        controller.appointment.value.lastAmePmeLocation,
                      ),
                      _reviewField(
                        "Last Examination Date",
                        controller.appointment.value.lastExaminationDate,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle(AppImages.heartbeatIcon, "Medical Details"),
                      SizedBox(height: 10),
                      _reviewField("Age", controller.appointment.value.age),
                      _reviewField(
                        "W.E.F. Date",
                        controller.appointment.value.wefDate,
                      ),

                      _reviewField(
                        "Past Medical History",
                        controller.appointment.value.pastMedicalHistory,
                      ),
                      _reviewField(
                        "Present Medical Category",
                        controller.appointment.value.presentMedicalCategory,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle(
                        AppImages.calenderCheckBlueIcon,
                        "Appointment Details",
                      ),
                      SizedBox(height: 10),
                      _reviewField(
                        "Year of AME/PME",
                        controller.appointment.value.appointmentYear,
                      ),
                      _reviewField(
                        "Preferred Date",
                        controller.appointment.value.preferredDate,
                      ),
                      _reviewField(
                        "Scheduled Due Date",
                        controller.appointment.value.scheduledDueDate,
                      ),
                      _reviewField(
                        "Mobile Number",
                        controller.appointment.value.mobileNumber,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle(
                        AppImages.uploadArrowIcon,
                        "Document Upload",
                      ),
                      SizedBox(height: 10),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.file_copy, color: Colors.grey),
                                    Text(
                                      " 74644545465465.pdf",
                                      style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 15),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle(AppImages.declarationIcon, "Declaration"),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Color(0xFFE8EAEF).withOpacity(0.4),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          "I hereby declare that the information provided above is true and correct to the best of my knowledge. I understand that any false information may result in disciplinary action.",
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 55, 60, 59),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      _reviewField(
                        "Declaration Agreed",
                        controller.appointment.value.declarationAgreed
                            ? "Yes"
                            : "No",
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle(
                        AppImages.declarationIcon,
                        "Special Category",
                      ),
                      SizedBox(height: 10),
                      _reviewField(
                        "Diver",
                        controller.appointment.value.diver ? "Yes" : "No",
                      ),
                      _reviewField(
                        "Submariner",
                        controller.appointment.value.submariner ? "Yes" : "No",
                      ),
                      _reviewField(
                        "Marco",
                        controller.appointment.value.marco ? "Yes" : "No",
                      ),
                      _reviewField(
                        "Aviator",
                        controller.appointment.value.aviator ? "Yes" : "No",
                      ),
                      _reviewField(
                        "None of the Above",
                        controller.appointment.value.noneOfAbove ? "Yes" : "No",
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
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
                        'Go Back & Edit',
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
                        Get.toNamed(AppRoutes.confirmtionScreen);
                        Get.snackbar(
                          "Success",
                          "Application successfully submitted!",
                        );
                        // Optionally navigate to a confirmation screen or home
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: AppColors.primary,
                      ),
                      child: Text(
                        'Confirm & Submit',
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
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Row _sectionTitle(String icon, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.asset(icon),
        SizedBox(width: 5),
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }

  Widget _reviewField(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 5),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
