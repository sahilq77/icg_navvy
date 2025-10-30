
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icg_navy/utility/app_colors.dart';
import 'package:icg_navy/utility/app_images.dart';
import 'package:icg_navy/utility/app_routes.dart';
import '../../controller/schedule_ame/schedule_appinment_controller.dart';

class ScheduleAppointmentAmeReviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ScheduleAppointmentController>();

    return WillPopScope(
      onWillPop: () async {
        Get.offNamed(AppRoutes.scheduleAppinmentAME);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
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
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: Divider(color: Color(0xFFDADADA), height: 0),
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
                        const SizedBox(height: 10),
                        _reviewField(
                            "Personal Number", controller.appointment.value.personalNumber),
                        _reviewField("Rank", controller.appointment.value.rank),
                        _reviewField("Name", controller.appointment.value.name),
                        _reviewField("Blood Group", controller.appointment.value.bloodGroup),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionTitle(AppImages.serviceIcon, "Service Details"),
                        const SizedBox(height: 10),
                        _reviewField("Command", controller.appointment.value.command),
                        _reviewField("Unit", controller.appointment.value.unit),
                        _reviewField("Arm/Corps/Branch/Trade",
                            controller.appointment.value.armCorpsBranchTrade),
                        _reviewField("Gender", controller.appointment.value.gender),
                        _reviewField("Service", controller.appointment.value.service),
                        _reviewField(
                            "Date of Birth", controller.appointment.value.dateOfBirth),
                        _reviewField(
                            "Total Service", controller.appointment.value.totalService),
                        _reviewField("Date of Commission",
                            controller.appointment.value.dateOfCommission),
                        _reviewField("Last AME/PME Carried Out At",
                            controller.appointment.value.lastAmePmeLocation),
                        _reviewField("Last Examination Date",
                            controller.appointment.value.lastExaminationDate),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionTitle(AppImages.heartbeatIcon, "Medical Details"),
                        const SizedBox(height: 10),
                        _reviewField("Age", controller.appointment.value.age),
                        _reviewField("W.E.F. Date", controller.appointment.value.wefDate),
                        _reviewField("Past Medical History",
                            controller.appointment.value.pastMedicalHistory),
                        _reviewField("Present Medical Category",
                            controller.appointment.value.presentMedicalCategory),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionTitle(
                            AppImages.calenderCheckBlueIcon, "Appointment Details"),
                        const SizedBox(height: 10),
                        _reviewField(
                            "Year of AME/PME", controller.appointment.value.appointmentYear),
                        _reviewField(
                            "Preferred Date", controller.appointment.value.preferredDate),
                        _reviewField("Scheduled Due Date",
                            controller.appointment.value.scheduledDueDate),
                        _reviewField(
                            "Mobile Number", controller.appointment.value.mobileNumber),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionTitle(AppImages.uploadArrowIcon, "Document Upload"),
                        const SizedBox(height: 10),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.file_copy, color: Colors.grey),
                                      Text(
                                        controller.selectedFile.value?.name ??
                                            'No file uploaded',
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
                const SizedBox(height: 15),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionTitle(AppImages.declarationIcon, "Declaration"),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8EAEF).withOpacity(0.4),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            "I hereby declare that the information provided above is true and correct to the best of my knowledge. I understand that any false information may result in disciplinary action.",
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromARGB(255, 55, 60, 59),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        _reviewField(
                          "Declaration Agreed",
                          controller.appointment.value.declarationAgreed ? "Yes" : "No",
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionTitle(AppImages.declarationIcon, "Special Category"),
                        const SizedBox(height: 10),
                        _reviewField(
                            "Diver", controller.appointment.value.diver ? "Yes" : "No"),
                        _reviewField("Submariner",
                            controller.appointment.value.submariner ? "Yes" : "No"),
                        _reviewField(
                            "Marco", controller.appointment.value.marco ? "Yes" : "No"),
                        _reviewField(
                            "Aviator", controller.appointment.value.aviator ? "Yes" : "No"),
                        _reviewField("None of the Above",
                            controller.appointment.value.noneOfAbove ? "Yes" : "No"),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Get.offNamed(AppRoutes.scheduleAppinmentAME),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          side: const BorderSide(
                            color: Colors.grey,
                            width: 1.5,
                          ),
                          foregroundColor: AppColors.defaultblack,
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
                    const SizedBox(width: 10),
                    Expanded(
                      child: Obx(() => ElevatedButton(
                            onPressed: controller.isLoadingup.value
                                ? null
                                : () async {
                                    await controller.submitAme(context: context);
                                  },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor: AppColors.primary,
                            ),
                            child: controller.isLoadingup.value
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    'Confirm & Submit',
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                          )),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
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
        const SizedBox(width: 5),
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

  Widget _reviewField(String title, String? value) {
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
          const SizedBox(height: 5),
          Text(
            value ?? 'N/A',
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
