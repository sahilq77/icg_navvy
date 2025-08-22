import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icg_navy/utility/app_colors.dart';
import 'package:icg_navy/utility/app_images.dart';
import 'package:intl/intl.dart';

import '../../controller/bottomnavigation/bottom_navigation_controller.dart';
import '../../utility/app_routes.dart';
import '../bottomnavigation/bottomnavigation.dart';

// Models (unchanged)
class PersonalDetails {
  final String serviceNo;
  final String rank;
  final String employeeName;
  final String unitLocation;
  final String tradeBranch;
  final String age;
  final String gender;

  PersonalDetails({
    required this.serviceNo,
    required this.rank,
    required this.employeeName,
    required this.unitLocation,
    required this.tradeBranch,
    required this.age,
    required this.gender,
  });
}

class FamilyMember {
  final String name;
  final String relation;
  final String age;
  final String gender;
  final String dob;
  RxBool selected;

  FamilyMember({
    required this.name,
    required this.relation,
    required this.age,
    required this.gender,
    required this.dob,
    required bool selected,
  }) : selected = selected.obs;
}

class Token {
  final String number;
  final String time;
  final bool available;

  Token({required this.number, required this.time, required this.available});
}

class AppointmentDetails {
  final String serviceNo;
  RxString relation;
  RxString fullName;
  RxString hospital;
  RxString department;
  RxString appointmentType;
  RxString appointmentDate;
  final List<Token> tokens;

  AppointmentDetails({
    required this.serviceNo,
    required String relation,
    required String fullName,
    required String hospital,
    required String department,
    required String appointmentType,
    required String appointmentDate,
    required this.tokens,
  }) : relation = relation.obs,
       fullName = fullName.obs,
       hospital = hospital.obs,
       department = department.obs,
       appointmentType = appointmentType.obs,
       appointmentDate = appointmentDate.obs;
}

// Controller (updated for dynamic token selection)
class AppointmentController extends GetxController {
  final personalDetails = PersonalDetails(
    serviceNo: '13075-S',
    rank: 'NVK(P)',
    employeeName: 'Sandeep Kumar',
    unitLocation: 'Yard 36010 (C-44...)',
    tradeBranch: 'Electrical Technician...',
    age: '26',
    gender: 'Male',
  );

  final familyMembers = <FamilyMember>[
    FamilyMember(
      name: 'Priya Kumar',
      relation: 'Wife',
      age: '32 years',
      gender: 'Female',
      dob: '10/05/2000',
      selected: true,
    ),
    FamilyMember(
      name: 'Arjun Kumar',
      relation: 'Son',
      age: '08 years',
      gender: 'Male',
      dob: '15/08/2023',
      selected: false,
    ),
    FamilyMember(
      name: 'Anita Kumar',
      relation: 'Mother',
      age: '60 years',
      gender: 'Female',
      dob: '10/09/1965',
      selected: false,
    ),
  ].obs;

  final appointmentDetails = AppointmentDetails(
    serviceNo: '13075-S',
    relation: 'Wife',
    fullName: 'Priya Kumar',
    hospital: 'Select',
    department: 'Select',
    appointmentType: 'Select',
    appointmentDate: '24/08/2025',
    tokens: [
      Token(number: '01', time: '09:00 AM to 09:06 AM', available: false),
      Token(number: '02', time: '09:06 AM to 09:12 AM', available: true),
      Token(number: '03', time: '09:12 AM to 09:18 AM', available: true),
      Token(number: '04', time: '09:18 AM to 09:24 AM', available: true),
      Token(number: '05', time: '09:24 AM to 09:30 AM', available: true),
      Token(number: '06', time: '09:30 AM to 09:36 AM', available: true),
    ],
  ).obs;

  final hospitals = ['Select', 'Hospital A', 'Hospital B', 'Hospital C'].obs;
  final departments = ['Select', 'Cardiology', 'Orthopedics', 'Neurology'].obs;
  final appointmentTypes = [
    'Select',
    'Consultation',
    'Follow-up',
    'Emergency',
  ].obs;

  // Track selected token index
  final selectedTokenIndex = (-1).obs;

  void updateFamilyMemberSelection(int index, bool value) {
    for (var member in familyMembers) {
      member.selected.value = false;
    }
    familyMembers[index].selected.value = value;
    if (value) {
      appointmentDetails.value.fullName.value = familyMembers[index].name;
      appointmentDetails.value.relation.value = familyMembers[index].relation;
    } else {
      appointmentDetails.value.fullName.value = '';
      appointmentDetails.value.relation.value = '';
    }
    familyMembers.refresh();
    appointmentDetails.refresh();
  }

  void updateHospital(String? value) {
    if (value != null) {
      appointmentDetails.value.hospital.value = value;
      appointmentDetails.refresh();
    }
  }

  void updateDepartment(String? value) {
    if (value != null) {
      appointmentDetails.value.department.value = value;
      appointmentDetails.refresh();
    }
  }

  void updateAppointmentType(String? value) {
    if (value != null) {
      appointmentDetails.value.appointmentType.value = value;
      appointmentDetails.refresh();
    }
  }

  void updateAppointmentDate(DateTime date) {
    appointmentDetails.value.appointmentDate.value = DateFormat(
      'dd/MM/yyyy',
    ).format(date);
    appointmentDetails.refresh();
  }

  void selectToken(int index) {
    if (appointmentDetails.value.tokens[index].available) {
      selectedTokenIndex.value = index;
      appointmentDetails.refresh();
    }
  }

  void scheduleAppointment() {
    if (selectedTokenIndex.value != -1) {
      print(
        'Appointment scheduled for ${appointmentDetails.value.fullName.value} '
        'on ${appointmentDetails.value.appointmentDate.value} '
        'at ${appointmentDetails.value.tokens[selectedTokenIndex.value].time}',
      );
    } else {
      print('No token selected');
    }
  }

  void addFamilyMember(FamilyMember member) {
    familyMembers.add(member);
    familyMembers.refresh();
  }
}

// Screen (updated for dynamic token selection)
class ScheduleAppointmentScreen extends StatefulWidget {
  @override
  State<ScheduleAppointmentScreen> createState() =>
      _ScheduleAppointmentScreenState();
}

class _ScheduleAppointmentScreenState extends State<ScheduleAppointmentScreen> {
  final controller = Get.put(AppointmentController());
  final bottomController = Get.put(BottomNavigationController());
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
            'Schedule Appointment',
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

        body: GetX<AppointmentController>(
          builder: (controller) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _sectionTitle(
                              AppImages.personIcon,
                              "Personal Details",
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _textFieldTitle("Service No"),
                                      SizedBox(height: 5),
                                      TextFormField(
                                        initialValue: controller
                                            .personalDetails
                                            .serviceNo,
                                        decoration: InputDecoration(
                                          filled: true,
                                        ),
                                        enabled: false,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _textFieldTitle("Rank"),
                                      SizedBox(height: 5),
                                      TextFormField(
                                        initialValue:
                                            controller.personalDetails.rank,
                                        decoration: InputDecoration(
                                          filled: true,
                                        ),
                                        enabled: false,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            _textFieldTitle("Employee Name"),
                            SizedBox(height: 5),
                            TextFormField(
                              initialValue:
                                  controller.personalDetails.employeeName,
                              decoration: InputDecoration(filled: true),
                              enabled: false,
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _textFieldTitle("Unit / Location"),
                                      SizedBox(height: 5),
                                      TextFormField(
                                        initialValue: controller
                                            .personalDetails
                                            .unitLocation,
                                        decoration: InputDecoration(
                                          filled: true,
                                        ),
                                        enabled: false,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _textFieldTitle("Trade / Branch"),
                                      SizedBox(height: 5),
                                      TextFormField(
                                        initialValue: controller
                                            .personalDetails
                                            .tradeBranch,
                                        decoration: InputDecoration(
                                          filled: true,
                                        ),
                                        enabled: false,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _textFieldTitle("Age"),
                                      SizedBox(height: 5),
                                      TextFormField(
                                        initialValue:
                                            controller.personalDetails.age,
                                        decoration: InputDecoration(
                                          filled: true,
                                        ),
                                        enabled: false,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _textFieldTitle("Gender"),
                                      SizedBox(height: 5),
                                      TextFormField(
                                        initialValue:
                                            controller.personalDetails.gender,
                                        decoration: InputDecoration(
                                          filled: true,
                                        ),
                                        enabled: false,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionTitle(AppImages.groupIcon, "Family Members"),
                        SizedBox(height: 10),
                        ...controller.familyMembers.asMap().entries.map(
                          (entry) => Card(
                            margin: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 0,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.white, Colors.grey.shade50],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(10),
                                border: Border(
                                  left: BorderSide(
                                    color: AppColors.primary,
                                    width: 5,
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 0,
                                ),
                                child: ListTile(
                                  title: Text(
                                    '${entry.value.name} ',
                                    style: GoogleFonts.inter(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.defaultblack,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${entry.value.relation} • ${entry.value.age} • ${entry.value.gender}',
                                        style: GoogleFonts.inter(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.defaultblack,
                                        ),
                                      ),
                                      SizedBox(height: 3),
                                      Text(
                                        'DOB: ${entry.value.dob}',
                                        style: GoogleFonts.inter(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.defaultblack,
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: Obx(
                                    () => Checkbox(
                                      value: entry.value.selected.value,
                                      onChanged: (value) {
                                        if (value != null) {
                                          controller
                                              .updateFamilyMemberSelection(
                                                entry.key,
                                                value,
                                              );
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _sectionTitle(
                              AppImages.groupIcon,
                              "Family Member Information",
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _textFieldTitle("Service No"),
                                      SizedBox(height: 5),
                                      TextFormField(
                                        initialValue: controller
                                            .appointmentDetails
                                            .value
                                            .serviceNo,
                                        decoration: InputDecoration(
                                          filled: true,
                                        ),
                                        enabled: false,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _textFieldTitle("Relation"),
                                      SizedBox(height: 5),
                                      Obx(
                                        () => TextFormField(
                                          key: ValueKey(
                                            controller
                                                .appointmentDetails
                                                .value
                                                .relation
                                                .value,
                                          ),
                                          initialValue: controller
                                              .appointmentDetails
                                              .value
                                              .relation
                                              .value,
                                          decoration: InputDecoration(
                                            filled: true,
                                          ),
                                          enabled: false,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            _textFieldTitle("Full Name"),
                            SizedBox(height: 5),
                            Obx(
                              () => TextFormField(
                                key: ValueKey(
                                  controller
                                      .appointmentDetails
                                      .value
                                      .fullName
                                      .value,
                                ),
                                initialValue: controller
                                    .appointmentDetails
                                    .value
                                    .fullName
                                    .value,
                                decoration: InputDecoration(filled: true),
                                enabled: false,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _sectionTitle(
                              AppImages.medicalkitIcon,
                              "Appointment Details",
                            ),
                            SizedBox(height: 20),
                            Obx(
                              () => DropdownSearch<String>(
                                popupProps: PopupProps.menu(
                                  showSelectedItems: true,
                                  showSearchBox: true,
                                  disabledItemFn: (String s) =>
                                      s.startsWith('I'),
                                ),
                                items: controller.hospitals,
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    labelText: "Hospital",
                                  ),
                                ),
                                onChanged: controller.updateHospital,
                                selectedItem: controller
                                    .appointmentDetails
                                    .value
                                    .hospital
                                    .value,
                              ),
                            ),
                            SizedBox(height: 16),
                            Obx(
                              () => DropdownSearch<String>(
                                popupProps: PopupProps.menu(
                                  showSelectedItems: true,
                                  showSearchBox: true,
                                  disabledItemFn: (String s) =>
                                      s.startsWith('I'),
                                ),
                                items: controller.departments,
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    labelText: "Department",
                                  ),
                                ),
                                onChanged: controller.updateDepartment,
                                selectedItem: controller
                                    .appointmentDetails
                                    .value
                                    .department
                                    .value,
                              ),
                            ),
                            SizedBox(height: 16),
                            Obx(
                              () => DropdownSearch<String>(
                                popupProps: PopupProps.menu(
                                  showSelectedItems: true,
                                  showSearchBox: true,
                                  disabledItemFn: (String s) =>
                                      s.startsWith('I'),
                                ),
                                items: controller.appointmentTypes,
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    labelText: "Appointment Type",
                                  ),
                                ),
                                onChanged: controller.updateAppointmentType,
                                selectedItem: controller
                                    .appointmentDetails
                                    .value
                                    .appointmentType
                                    .value,
                              ),
                            ),
                            SizedBox(height: 16),
                            Obx(
                              () => TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                  labelText: 'Appointment Date',
                                  suffixIcon: Icon(Icons.calendar_today),
                                ),
                                controller: TextEditingController(
                                  text: controller
                                      .appointmentDetails
                                      .value
                                      .appointmentDate
                                      .value,
                                ),
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2026),
                                  );
                                  if (pickedDate != null) {
                                    controller.updateAppointmentDate(
                                      pickedDate,
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Please Select Token',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Obx(
                      () => GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1.9,
                        ),
                        itemCount:
                            controller.appointmentDetails.value.tokens.length,
                        itemBuilder: (context, index) {
                          final token =
                              controller.appointmentDetails.value.tokens[index];
                          return Obx(
                            () => InkWell(
                              onTap: token.available
                                  ? () => controller.selectToken(index)
                                  : null,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: token.available
                                      ? (controller.selectedTokenIndex.value ==
                                                index
                                            ? AppColors.primary.withOpacity(
                                                0.3,
                                              ) // Selected token color
                                            : Colors.green.withOpacity(0.1))
                                      : const Color(
                                          0xFFFFEFEF,
                                        ), // Unavailable token color
                                  border: Border.all(
                                    color: token.available
                                        ? (controller
                                                      .selectedTokenIndex
                                                      .value ==
                                                  index
                                              ? AppColors
                                                    .primary // Selected token color
                                              : Colors.green)
                                        : Colors.red, //
                                    width:
                                        controller.selectedTokenIndex.value ==
                                            index
                                        ? 2
                                        : 1,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ), // Optional: for rounded corners
                                ),
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Token ${token.number}',
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: token.available
                                            ? (controller
                                                          .selectedTokenIndex
                                                          .value ==
                                                      index
                                                  ? AppColors
                                                        .primary // Selected token color
                                                  : Colors.green)
                                            : Colors.red, //
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      token.time,
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: token.available
                                            ? (controller
                                                          .selectedTokenIndex
                                                          .value ==
                                                      index
                                                  ? AppColors
                                                        .primary // Selected token color
                                                  : Colors.green)
                                            : Colors.red, //
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.tokenSuccess);
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Schedule Appointment',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
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
