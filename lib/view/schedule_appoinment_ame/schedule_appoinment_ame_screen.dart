import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:icg_navy/controller/bottomnavigation/bottom_navigation_controller.dart';
import 'package:icg_navy/controller/global_controller.dart/blood_group_controller.dart';
import 'package:icg_navy/controller/user_details/user_details_controller.dart';
import 'package:icg_navy/utility/app_colors.dart';
import 'package:icg_navy/utility/app_images.dart';
import 'package:icg_navy/utility/app_routes.dart';

import '../bottomnavigation/bottomnavigation.dart';

class AppointmentModel {
  String personalNumber;
  String rank;
  String name;
  String bloodGroup;
  String command;
  String unit;
  String armCorpsBranchTrade;
  String gender;
  String service;
  String dateOfBirth;
  String totalService;
  String dateOfCommission;
  String lastAmePmeLocation;
  String lastExaminationDate;
  String age;
  String wefDate;
  String pastMedicalHistory;
  String presentMedicalCategory;
  String appointmentYear;
  String preferredDate;
  String scheduledDueDate;
  String mobileNumber;
  bool diver;
  bool submariner;
  bool marco;
  bool aviator;
  bool noneOfAbove;
  bool declarationAgreed;

  AppointmentModel({
    this.personalNumber = "ICGC12345",
    this.rank = "NVK(P)",
    this.name = "Sandeep Kumar",
    this.bloodGroup = "B+",
    this.command = "Coast Guard Headquarters",
    this.unit = "Dte. Information Technology",
    this.armCorpsBranchTrade = "General Duty",
    this.gender = "Male",
    this.service = "Coast Guard",
    this.dateOfBirth = "24/08/2025",
    this.totalService = "15 Years 6 Months",
    this.dateOfCommission = "20/09/2025",
    this.lastAmePmeLocation = "CGHQ New Delhi",
    this.lastExaminationDate = "24/08/2025",
    this.age = "35 Years 5 Months",
    this.wefDate = "05/10/2025",
    this.pastMedicalHistory = "Fit",
    this.presentMedicalCategory = "S1A1",
    this.appointmentYear = "Select Appointment Year",
    this.preferredDate = "24/08/2025",
    this.scheduledDueDate = "24/08/2025",
    this.mobileNumber = "+91 123454654",
    this.diver = false,
    this.submariner = false,
    this.marco = false,
    this.aviator = false,
    this.noneOfAbove = true,
    this.declarationAgreed = false,
  });
}

class ScheduleAppointmentController extends GetxController {
  var appointment = AppointmentModel().obs;

  void updateAppointmentYear(String? year) {
    if (year != null) {
      appointment.update((val) {
        val?.appointmentYear = year;
      });
    }
  }

  void updatePreferredDate(String date) {
    appointment.update((val) {
      val?.preferredDate = date;
    });
  }

  void updateScheduledDueDate(String date) {
    appointment.update((val) {
      val?.scheduledDueDate = date;
    });
  }

  void updateSpecialCategory({
    bool? diver,
    bool? submariner,
    bool? marco,
    bool? aviator,
    bool? noneOfAbove,
  }) {
    appointment.update((val) {
      if (diver != null) val?.diver = diver;
      if (submariner != null) val?.submariner = submariner;
      if (marco != null) val?.marco = marco;
      if (aviator != null) val?.aviator = aviator;
      if (noneOfAbove != null) {
        val?.noneOfAbove = noneOfAbove;
        if (noneOfAbove) {
          val?.diver = false;
          val?.submariner = false;
          val?.marco = false;
          val?.aviator = false;
        }
      }
    });
  }

  void updateDeclarationAgreed(bool value) {
    appointment.update((val) {
      val?.declarationAgreed = value;
    });
  }

  Future<void> selectDate(BuildContext context, bool isPreferredDate) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      String formattedDate =
          "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      if (isPreferredDate) {
        updatePreferredDate(formattedDate);
      } else {
        updateScheduledDueDate(formattedDate);
      }
    }
  }

  void reviewApplication() {
    if (appointment.value.declarationAgreed &&
        appointment.value.appointmentYear != "Select Appointment Year") {
      Get.toNamed(AppRoutes.scheduleAppinmentAMEReview);
      Get.snackbar("Success", "Application submitted for review!");
    } else {
      Get.snackbar(
        "Error",
        "Please agree to the declaration and select a valid appointment year.",
      );
    }
  }
}

class ScheduleAppointmentAmeScreen extends StatefulWidget {
  @override
  State<ScheduleAppointmentAmeScreen> createState() =>
      _ScheduleAppointmentAmeScreenState();
}

class _ScheduleAppointmentAmeScreenState
    extends State<ScheduleAppointmentAmeScreen> {
  final controller = Get.put(ScheduleAppointmentController());
  final bottomController = Get.put(BottomNavigationController());
  final userController = Get.put(UserDetailsController());
  final bloodGroupController = Get.put(BloodGroupController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloodGroupController.fetchBloodGroups(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => bottomController.onWillPop(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: AppColors.background,
          elevation: 0,
          centerTitle: false,
          title: Text(
            'Schedule Appointment AME/PME',
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
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _textFieldTitle("Personal Number"),
                                  SizedBox(height: 5),
                                  TextFormField(
                                    initialValue: userController
                                        .userProfileList
                                        .first
                                        .personnel!
                                        .personalNumber,
                                    decoration: InputDecoration(filled: true),
                                    enabled: false,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _textFieldTitle("Rank"),
                                  SizedBox(height: 5),
                                  TextFormField(
                                    initialValue:
                                        controller.appointment.value.rank,
                                    decoration: InputDecoration(filled: true),
                                    enabled: false,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        _textFieldTitle("Name"),
                        SizedBox(height: 5),
                        TextFormField(
                          initialValue: userController
                              .userProfileList
                              .first
                              .personnel!
                              .fullName,
                          decoration: InputDecoration(filled: true),
                          enabled: false,
                        ),
                        SizedBox(height: 10),
                        _textFieldTitle("Blood Group"),
                        SizedBox(height: 5),
                        Obx(() {
                          // Get the blood group name corresponding to the user's blood group code
                          String? initialBloodGroup = bloodGroupController
                              .getBloodGroupNameById(
                                userController
                                        .userProfileList
                                        .first
                                        .personnel!
                                        .bloodGroupCode ??
                                    '',
                              );

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DropdownSearch<String>(
                                popupProps: const PopupProps.menu(
                                  showSelectedItems: true,
                                  showSearchBox: true,
                                  searchFieldProps: TextFieldProps(
                                    decoration: InputDecoration(
                                      labelText: 'Search Blood Group',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                items: bloodGroupController
                                    .getBloodGroupNames(),

                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    hintText: "Select Blood Group",
                                    border: const OutlineInputBorder(),
                                    errorText:
                                        bloodGroupController
                                            .errorMessage
                                            .value
                                            .isNotEmpty
                                        ? bloodGroupController
                                              .errorMessage
                                              .value
                                        : null,
                                  ),
                                ),
                                onChanged: (String? selectedBloodGroup) {
                                  if (selectedBloodGroup != null) {
                                    bloodGroupController.selectedBloodGroupVal =
                                        selectedBloodGroup.obs;
                                    String? bloodGroupCode =
                                        bloodGroupController.getBloodGroupId(
                                          selectedBloodGroup,
                                        );
                                    print(
                                      'Selected Blood Group: $selectedBloodGroup, Code: $bloodGroupCode',
                                    );
                                    // Optionally, update the appointment model with the selected blood group
                                    controller.appointment.update((val) {
                                      val?.bloodGroup = selectedBloodGroup;
                                    });
                                  }
                                },
                                selectedItem:
                                    initialBloodGroup ??
                                    bloodGroupController
                                        .selectedBloodGroupVal
                                        ?.value,
                              ),
                              if (bloodGroupController.isLoading.value)
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: CircularProgressIndicator(),
                                ),
                            ],
                          );
                        }),
                        // TextFormField(
                        //   initialValue: controller.appointment.value.bloodGroup,
                        //   decoration: InputDecoration(filled: true),
                        //   enabled: false,
                        // ),
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
                        _textFieldTitle("Command"),
                        SizedBox(height: 5),
                        TextFormField(
                          initialValue: controller.appointment.value.command,
                          decoration: InputDecoration(filled: true),
                          enabled: false,
                        ),
                        SizedBox(height: 10),
                        _textFieldTitle("Unit"),
                        SizedBox(height: 5),
                        TextFormField(
                          initialValue: controller.appointment.value.unit,
                          decoration: InputDecoration(filled: true),
                          enabled: false,
                        ),
                        SizedBox(height: 10),
                        _textFieldTitle("Arm/Corps/Branch/Trade"),
                        SizedBox(height: 5),
                        TextFormField(
                          initialValue:
                              controller.appointment.value.armCorpsBranchTrade,
                          decoration: InputDecoration(filled: true),
                          enabled: false,
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _textFieldTitle("Gender"),
                                  SizedBox(height: 5),
                                  TextFormField(
                                    initialValue:
                                        controller.appointment.value.gender,
                                    decoration: InputDecoration(filled: true),
                                    enabled: false,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _textFieldTitle("Service"),
                                  SizedBox(height: 5),
                                  TextFormField(
                                    initialValue:
                                        controller.appointment.value.service,
                                    decoration: InputDecoration(filled: true),
                                    enabled: false,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        _textFieldTitle("Date of Birth"),
                        SizedBox(height: 5),
                        TextFormField(
                          initialValue:
                              controller.appointment.value.dateOfBirth,
                          decoration: InputDecoration(filled: true),
                          enabled: false,
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _textFieldTitle("Total Service"),
                                  SizedBox(height: 5),
                                  TextFormField(
                                    initialValue: controller
                                        .appointment
                                        .value
                                        .totalService,
                                    decoration: InputDecoration(filled: true),
                                    enabled: false,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _textFieldTitle("Date of Commission"),
                                  SizedBox(height: 5),
                                  TextFormField(
                                    initialValue: controller
                                        .appointment
                                        .value
                                        .dateOfCommission,
                                    decoration: InputDecoration(filled: true),
                                    enabled: false,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        _textFieldTitle("Last AME/PME carried out at"),
                        SizedBox(height: 5),
                        TextFormField(
                          initialValue:
                              controller.appointment.value.lastAmePmeLocation,
                          decoration: InputDecoration(filled: true),
                          enabled: false,
                        ),
                        SizedBox(height: 10),
                        _textFieldTitle("Last Examination date"),
                        SizedBox(height: 5),
                        TextFormField(
                          initialValue:
                              controller.appointment.value.lastExaminationDate,
                          decoration: InputDecoration(filled: true),
                          enabled: false,
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
                          AppImages.heartbeatIcon,
                          "Medical Details",
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _textFieldTitle("Age"),
                                  SizedBox(height: 5),
                                  TextFormField(
                                    initialValue:
                                        controller.appointment.value.age,
                                    decoration: InputDecoration(filled: true),
                                    enabled: false,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _textFieldTitle("W.E.F. Date"),
                                  SizedBox(height: 5),
                                  TextFormField(
                                    initialValue:
                                        controller.appointment.value.wefDate,
                                    decoration: InputDecoration(filled: true),
                                    enabled: false,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        _textFieldTitle("Past Medical History"),
                        SizedBox(height: 5),
                        TextFormField(
                          initialValue:
                              controller.appointment.value.pastMedicalHistory,
                          decoration: InputDecoration(filled: true),
                          enabled: false,
                        ),
                        SizedBox(height: 10),
                        _textFieldTitle("Present Medical Category"),
                        SizedBox(height: 5),
                        TextFormField(
                          initialValue: controller
                              .appointment
                              .value
                              .presentMedicalCategory,
                          decoration: InputDecoration(filled: true),
                          enabled: false,
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
                        _textFieldTitle("Year Of AME/PME*"),
                        SizedBox(height: 5),
                        DropdownSearch<String>(
                          popupProps: PopupProps.menu(
                            showSearchBox: true,
                            searchFieldProps: TextFieldProps(
                              decoration: InputDecoration(
                                hintText: "Search year...",
                                //filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          items: ['Select Appointment Year', '2025', '2026'],
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              //        filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          onChanged: controller.updateAppointmentYear,
                          selectedItem:
                              controller.appointment.value.appointmentYear,
                        ),
                        SizedBox(height: 10),
                        _textFieldTitle("Preferred Date"),
                        SizedBox(height: 5),
                        TextFormField(
                          controller: TextEditingController(
                            text: controller.appointment.value.preferredDate,
                          ),
                          decoration: InputDecoration(
                            //filled: true,
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                          readOnly: true,
                          onTap: () => controller.selectDate(context, true),
                        ),
                        SizedBox(height: 10),
                        _textFieldTitle("Scheduled Due Date"),
                        SizedBox(height: 5),
                        TextFormField(
                          controller: TextEditingController(
                            text: controller.appointment.value.scheduledDueDate,
                          ),
                          decoration: InputDecoration(
                            // filled: true,
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                          readOnly: true,
                          onTap: () => controller.selectDate(context, false),
                        ),
                        SizedBox(height: 10),
                        _textFieldTitle("Mobile Number"),
                        SizedBox(height: 5),
                        TextFormField(
                          initialValue:
                              controller.appointment.value.mobileNumber,
                          decoration: InputDecoration(
                            //   filled: true
                          ),
                          enabled: false,
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
                        DottedBorder(
                          borderType: BorderType.RRect,
                          radius: Radius.circular(8),
                          color: Colors.grey,
                          strokeWidth: 1.0,
                          dashPattern: [4, 4],
                          child: Container(
                            height: 100,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(AppImages.uploadSkyIcon),
                                  SizedBox(height: 10),
                                  Text(
                                    "Upload Condonation Document",
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Drag & drop files here or click to browse",
                                    style: GoogleFonts.inter(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey,
                                    ),
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
                              color: const Color.from(
                                alpha: 1,
                                red: 0.216,
                                green: 0.235,
                                blue: 0.231,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Checkbox(
                              value: controller
                                  .appointment
                                  .value
                                  .declarationAgreed,
                              onChanged: (value) => controller
                                  .updateDeclarationAgreed(value ?? false),
                            ),
                            Expanded(
                              child: Text(
                                "I agree to the terms and conditions stated in the declaration above.",
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.defaultblack,
                                ),
                              ),
                            ),
                          ],
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
                        CheckboxListTile(
                          title: Text(
                            "Diver",
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: AppColors.defaultblack,
                            ),
                          ),
                          value: controller.appointment.value.diver,
                          onChanged: (value) =>
                              controller.updateSpecialCategory(
                                diver: value,
                                noneOfAbove: value == true ? false : null,
                              ),
                          controlAffinity: ListTileControlAffinity.leading,
                          dense: true,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 0,
                          ),
                        ),
                        CheckboxListTile(
                          title: Text(
                            "Submariner",
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: AppColors.defaultblack,
                            ),
                          ),
                          value: controller.appointment.value.submariner,
                          onChanged: (value) =>
                              controller.updateSpecialCategory(
                                submariner: value,
                                noneOfAbove: value == true ? false : null,
                              ),
                          controlAffinity: ListTileControlAffinity.leading,
                          dense: true,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 0,
                          ),
                        ),
                        CheckboxListTile(
                          title: Text(
                            "Marco",
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: AppColors.defaultblack,
                            ),
                          ),
                          value: controller.appointment.value.marco,
                          onChanged: (value) =>
                              controller.updateSpecialCategory(
                                marco: value,
                                noneOfAbove: value == true ? false : null,
                              ),
                          controlAffinity: ListTileControlAffinity.leading,
                          dense: true,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 0,
                          ),
                        ),
                        CheckboxListTile(
                          title: Text(
                            "Aviator",
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: AppColors.defaultblack,
                            ),
                          ),
                          value: controller.appointment.value.aviator,
                          onChanged: (value) =>
                              controller.updateSpecialCategory(
                                aviator: value,
                                noneOfAbove: value == true ? false : null,
                              ),
                          controlAffinity: ListTileControlAffinity.leading,
                          dense: true, // Reduces vertical height
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 0,
                          ), // Adjust padding
                        ),
                        CheckboxListTile(
                          title: Text(
                            "None of the Above",
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: AppColors.defaultblack,
                            ),
                          ),
                          value: controller.appointment.value.noneOfAbove,
                          onChanged: (value) => controller
                              .updateSpecialCategory(noneOfAbove: value),
                          controlAffinity: ListTileControlAffinity.leading,
                          dense: true, // Reduces vertical height
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 0,
                          ), // Adjust padding
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: controller.reviewApplication,
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Review Application',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomBar(),
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

  Text _textFieldTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontWeight: FontWeight.w500,
        color: AppColors.defaultblack,
        fontSize: 14,
      ),
    );
  }
}
