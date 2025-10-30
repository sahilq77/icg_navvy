import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:icg_navy/controller/bottomnavigation/bottom_navigation_controller.dart';
import 'package:icg_navy/controller/global_controller/all_unit/all_unit_controller.dart';
import 'package:icg_navy/controller/global_controller/blood_group/blood_group_controller.dart';
import 'package:icg_navy/controller/global_controller/branch/branch_controller.dart';
import 'package:icg_navy/controller/global_controller/rank/rank_controller.dart';
import 'package:icg_navy/controller/user_details/user_details_controller.dart';
import 'package:icg_navy/utility/app_colors.dart';
import 'package:icg_navy/utility/app_images.dart';
import 'package:icg_navy/utility/app_routes.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:file_picker/file_picker.dart';
import '../../controller/global_controller/command/commnand_controller.dart';
import '../../controller/global_controller/financial_year/financial_year_controller.dart';
import '../../controller/global_controller/gender/gender_controller.dart';
import '../../controller/global_controller/medical_category/medical_category_controller.dart';
import '../../controller/global_controller/service/service_controller.dart';
import '../../controller/global_controller/unit/unit_controller.dart';
import '../../controller/schedule_ame/schedule_appinment_controller.dart';
import '../../controller/schedule_ame/schedule_due_date_controller.dart';
import '../bottomnavigation/bottomnavigation.dart';

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
  final rankController = Get.put(RankController());
  final commandController = Get.put(CommandController());
  final genderController = Get.put(GenderController());
  final unitController = Get.put(UnitController());
  final allUnitController = Get.put(AllUnitController());
  final branchController = Get.put(BranchController());
  final serviceController = Get.put(ServiceController());
  final medicalCategoryController = Get.put(MedicalCategoryController());
  final financialYearController = Get.put(FinancialYearController());
  final scheduleDueDateController = Get.put(ScheduleDueDateController());

  @override
  void initState() {
    super.initState();
    // Fetch user profile and other data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userController.fetchUserProfile(context: context);
      rankController.fetchRank(context: context);
      bloodGroupController.fetchBloodGroups(context: context);
      commandController.fetchCommand(context: context);
      branchController.fetchBranches(context: context);
      serviceController.fetchService(context: context);
      medicalCategoryController.fetchMedicalCategory(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Prevent default back navigation
      onPopInvoked: (didPop) async {
        if (!didPop) {
          // Call the same onWillPop logic from BottomNavigationController
          bool shouldPop = await bottomController.onWillPop();
          if (shouldPop && context.mounted) {
            Navigator.of(context).pop();
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
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
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: Divider(color: Color(0xFFDADADA), height: 0),
          ),
        ),
        body: Obx(() {
          // Check if user profile is loading or empty
          if (userController.isLoading.value ||
              userController.userProfileList.isEmpty) {
            return _buildShimmerScreen();
          }
          unitController.fetchUnit(
            context: context,
            commandCode:
                userController.userProfileList.first.personnel?.commandCode ??
                '',
          );
          return SingleChildScrollView(
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
                        _sectionTitle(AppImages.personIcon, "Personal Details"),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _textFieldTitle("Personal Number"),
                                  const SizedBox(height: 5),
                                  TextFormField(
                                    initialValue:
                                        userController
                                            .userProfileList
                                            .first
                                            .personnel
                                            ?.personalNumber ??
                                        '',
                                    decoration: const InputDecoration(
                                      filled: true,
                                    ),
                                    enabled: false,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _textFieldTitle("Rank"),
                                  const SizedBox(height: 5),
                                  _buildShimmerDropdown(
                                    isLoading: rankController.isLoading.value,
                                    child: DropdownSearch<String>(
                                      popupProps: const PopupProps.menu(
                                        showSelectedItems: true,
                                        showSearchBox: true,
                                        searchFieldProps: TextFieldProps(
                                          decoration: InputDecoration(
                                            labelText: 'Search Rank',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                      ),
                                      items: rankController.getRankNames(),
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                            dropdownSearchDecoration:
                                                InputDecoration(
                                                  hintText: "Select Rank",
                                                  border:
                                                      const OutlineInputBorder(),
                                                  errorText:
                                                      rankController
                                                          .errorMessage
                                                          .value
                                                          .isNotEmpty
                                                      ? rankController
                                                            .errorMessage
                                                            .value
                                                      : null,
                                                ),
                                          ),
                                      onChanged: (String? selectedRank) {
                                        if (selectedRank != null) {
                                          rankController.selectedRankVal =
                                              selectedRank.obs;
                                          String? rankCode = rankController
                                              .getRankId(selectedRank);
                                          print(
                                            'Selected Rank: $selectedRank, Code: $rankCode',
                                          );
                                        }
                                      },
                                      selectedItem:
                                          rankController.getRankNameById(
                                            userController
                                                    .userProfileList
                                                    .first
                                                    .personnel
                                                    ?.rankCode ??
                                                '',
                                          ) ??
                                          rankController.selectedRankVal?.value,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        _textFieldTitle("Name"),
                        const SizedBox(height: 5),
                        TextFormField(
                          initialValue:
                              userController
                                  .userProfileList
                                  .first
                                  .personnel
                                  ?.fullName ??
                              '',
                          decoration: const InputDecoration(filled: true),
                          enabled: false,
                        ),
                        const SizedBox(height: 10),
                        _textFieldTitle("Blood Group"),
                        const SizedBox(height: 5),
                        _buildShimmerDropdown(
                          isLoading: bloodGroupController.isLoading.value,
                          child: DropdownSearch<String>(
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
                            items: bloodGroupController.getBloodGroupNames(),
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                hintText: "Select Blood Group",
                                border: const OutlineInputBorder(),
                                errorText:
                                    bloodGroupController
                                        .errorMessage
                                        .value
                                        .isNotEmpty
                                    ? bloodGroupController.errorMessage.value
                                    : null,
                              ),
                            ),
                            onChanged: (String? selectedBloodGroup) {
                              if (selectedBloodGroup != null) {
                                bloodGroupController.selectedBloodGroupVal =
                                    selectedBloodGroup.obs;
                                String? bloodGroupCode = bloodGroupController
                                    .getBloodGroupId(selectedBloodGroup);
                                print(
                                  'Selected Blood Group: $selectedBloodGroup, Code: $bloodGroupCode',
                                );
                              }
                            },
                            selectedItem:
                                bloodGroupController.getBloodGroupNameById(
                                  userController
                                          .userProfileList
                                          .first
                                          .personnel
                                          ?.bloodGroupCode ??
                                      '',
                                ) ??
                                bloodGroupController
                                    .selectedBloodGroupVal
                                    ?.value,
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
                        _sectionTitle(AppImages.serviceIcon, "Service Details"),
                        const SizedBox(height: 10),
                        _textFieldTitle("Command"),
                        const SizedBox(height: 5),
                        _buildShimmerDropdown(
                          isLoading: commandController.isLoading.value,
                          child: DropdownSearch<String>(
                            popupProps: const PopupProps.menu(
                              showSelectedItems: true,
                              showSearchBox: true,
                              searchFieldProps: TextFieldProps(
                                decoration: InputDecoration(
                                  labelText: 'Search Command',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            items: commandController.getCommandNames(),
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                hintText: "Select Command",
                                border: const OutlineInputBorder(),
                                errorText:
                                    commandController
                                        .errorMessage
                                        .value
                                        .isNotEmpty
                                    ? commandController.errorMessage.value
                                    : null,
                              ),
                            ),
                            onChanged: (String? selectedCommand) {
                              if (selectedCommand != null) {
                                commandController.selectedCommandVal =
                                    selectedCommand.obs;
                                String? commandCode = commandController
                                    .getCommandId(selectedCommand);
                                unitController.selectedUnitVal = null;
                                unitController.unitList.clear();
                                unitController.fetchUnit(
                                  context: context,
                                  commandCode: commandCode!,
                                );
                                print(
                                  'Selected Command: $selectedCommand, Code: $commandCode',
                                );
                              }
                            },
                            selectedItem:
                                commandController.getCommandNameById(
                                  userController
                                          .userProfileList
                                          .first
                                          .personnel
                                          ?.commandCode ??
                                      '',
                                ) ??
                                commandController.selectedCommandVal?.value,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _textFieldTitle("Unit"),
                        const SizedBox(height: 5),
                        _buildShimmerDropdown(
                          isLoading: unitController.isLoading.value,
                          child: DropdownSearch<String>(
                            popupProps: const PopupProps.menu(
                              showSelectedItems: true,
                              showSearchBox: true,
                              searchFieldProps: TextFieldProps(
                                decoration: InputDecoration(
                                  labelText: 'Search Unit',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            items: unitController.getUnitNames(),
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                hintText: "Select Unit",
                                border: const OutlineInputBorder(),
                                errorText:
                                    unitController.errorMessage.value.isNotEmpty
                                    ? unitController.errorMessage.value
                                    : null,
                              ),
                            ),
                            onChanged: (String? selectedUnit) {
                              if (selectedUnit != null) {
                                unitController.selectedUnitVal =
                                    selectedUnit.obs;
                                String? unitCode = unitController.getUnitId(
                                  selectedUnit,
                                );
                                print(
                                  'Selected Unit: $selectedUnit, Code: $unitCode',
                                );
                              }
                            },
                            selectedItem:
                                unitController.getUnitNameById(
                                  userController
                                          .userProfileList
                                          .first
                                          .personnel
                                          ?.unitCode ??
                                      '',
                                ) ??
                                unitController.selectedUnitVal?.value,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _textFieldTitle("Arm/Corps/Branch/Trade"),
                        const SizedBox(height: 5),
                        _buildShimmerDropdown(
                          isLoading: branchController.isLoading.value,
                          child: DropdownSearch<String>(
                            popupProps: const PopupProps.menu(
                              showSelectedItems: true,
                              showSearchBox: true,
                              searchFieldProps: TextFieldProps(
                                decoration: InputDecoration(
                                  labelText: 'Search Branch',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            items: branchController.getBranchNames(),
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                hintText: "Select Branch",
                                border: const OutlineInputBorder(),
                                errorText:
                                    branchController
                                        .errorMessage
                                        .value
                                        .isNotEmpty
                                    ? branchController.errorMessage.value
                                    : null,
                              ),
                            ),
                            onChanged: (String? selectedBranch) {
                              if (selectedBranch != null) {
                                branchController.selectedBranchVal =
                                    selectedBranch.obs;
                                String? branchCode = branchController
                                    .getBranchId(selectedBranch);
                                print(
                                  'Selected Branch: $selectedBranch, Code: $branchCode',
                                );
                              }
                            },
                            selectedItem:
                                branchController.getBranchNameById(
                                  userController
                                          .userProfileList
                                          .first
                                          .personnel
                                          ?.branchCode ??
                                      '',
                                ) ??
                                serviceController.selectedServiceVal?.value ??
                                'Select Service',
                          ),
                        ),
                        const SizedBox(height: 10),
                        _textFieldTitle("Gender"),
                        const SizedBox(height: 5),
                        _buildShimmerDropdown(
                          isLoading: genderController.isLoading.value,
                          child: DropdownSearch<String>(
                            popupProps: const PopupProps.menu(
                              showSelectedItems: true,
                              showSearchBox: true,
                              searchFieldProps: TextFieldProps(
                                decoration: InputDecoration(
                                  labelText: 'Search Gender',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            items: genderController.getGenderNames(),
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                hintText: "Gender",
                                border: const OutlineInputBorder(),
                                errorText:
                                    genderController
                                        .errorMessage
                                        .value
                                        .isNotEmpty
                                    ? genderController.errorMessage.value
                                    : null,
                              ),
                            ),
                            onChanged: (String? selectedGender) {
                              if (selectedGender != null) {
                                genderController.selectedGenderVal =
                                    selectedGender.obs;
                                String? genderCode = genderController
                                    .getGenderId(selectedGender);
                                print(
                                  'Selected Gender: $selectedGender, Code: $genderCode',
                                );
                              }
                            },
                            selectedItem:
                                genderController.getGenderNameById(
                                  userController
                                          .userProfileList
                                          .first
                                          .personnel
                                          ?.employeeGender ??
                                      '',
                                ) ??
                                genderController.selectedGenderVal?.value,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _textFieldTitle("Service"),
                        const SizedBox(height: 5),
                        _buildShimmerDropdown(
                          isLoading: serviceController.isLoading.value,
                          child: DropdownSearch<String>(
                            popupProps: const PopupProps.menu(
                              showSelectedItems: true,
                              showSearchBox: true,
                              searchFieldProps: TextFieldProps(
                                decoration: InputDecoration(
                                  labelText: 'Search Service',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            items: serviceController.getServiceNames(),
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                hintText: "Select Service",
                                border: const OutlineInputBorder(),
                                errorText:
                                    serviceController
                                        .errorMessage
                                        .value
                                        .isNotEmpty
                                    ? serviceController.errorMessage.value
                                    : null,
                              ),
                            ),
                            onChanged: (String? selectedService) {
                              if (selectedService != null) {
                                serviceController.selectedServiceVal =
                                    selectedService.obs;
                                String? serviceCode = serviceController
                                    .getServiceId(selectedService);
                                print(
                                  'Selected Service: $selectedService, Code: $serviceCode',
                                );
                              }
                            },
                            selectedItem:
                                serviceController.getServiceNameById(
                                  userController
                                          .userProfileList
                                          .first
                                          .personnel
                                          ?.serviceCode ??
                                      '',
                                ) ??
                                serviceController.selectedServiceVal?.value ??
                                'Select Service',
                          ),
                        ),
                        const SizedBox(height: 10),
                        _textFieldTitle("Date of Birth"),
                        const SizedBox(height: 5),
                        TextFormField(
                          initialValue: formatDate(
                            userController
                                    .userProfileList
                                    .first
                                    .personnel
                                    ?.dateOfBirth
                                    ?.toString() ??
                                '',
                          ),
                          decoration: const InputDecoration(filled: true),
                          enabled: false,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _textFieldTitle("Total Service"),
                                  const SizedBox(height: 5),
                                  TextFormField(
                                    initialValue:
                                        userController
                                            .userProfileList
                                            .first
                                            .personnel
                                            ?.totalService ??
                                        '',
                                    decoration: const InputDecoration(
                                      filled: true,
                                    ),
                                    enabled: false,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _textFieldTitle("Date of Commission"),
                                  const SizedBox(height: 5),
                                  TextFormField(
                                    initialValue: formatDate(
                                      userController
                                              .userProfileList
                                              .first
                                              .personnel
                                              ?.dateOfCommissioning
                                              ?.toString() ??
                                          '',
                                    ),
                                    decoration: const InputDecoration(
                                      filled: true,
                                    ),
                                    enabled: false,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        _textFieldTitle("Last AME/PME carried out at"),
                        const SizedBox(height: 5),
                        _buildShimmerDropdown(
                          isLoading: allUnitController.isLoading.value,
                          child: DropdownSearch<String>(
                            popupProps: const PopupProps.menu(
                              showSelectedItems: true,
                              showSearchBox: true,
                              searchFieldProps: TextFieldProps(
                                decoration: InputDecoration(
                                  labelText: 'Search Unit',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            items: allUnitController.getUnitNames(),
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                hintText: "Select Unit",
                                border: const OutlineInputBorder(),
                                errorText:
                                    allUnitController
                                        .errorMessage
                                        .value
                                        .isNotEmpty
                                    ? allUnitController.errorMessage.value
                                    : null,
                              ),
                            ),
                            onChanged: (String? selectedUnit) {
                              if (selectedUnit != null) {
                                allUnitController.selectedUnitVal =
                                    selectedUnit.obs;
                                String? unitCode = allUnitController.getUnitId(
                                  selectedUnit,
                                );
                                print(
                                  'Selected Unit: $selectedUnit, Code: $unitCode',
                                );
                              }
                            },
                            selectedItem:
                                allUnitController.getUnitNameById(
                                  userController
                                          .userProfileList
                                          .first
                                          .personnel
                                          ?.unitCode ??
                                      '',
                                ) ??
                                allUnitController.selectedUnitVal?.value,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _textFieldTitle("Last Examination date"),
                        const SizedBox(height: 5),
                        TextFormField(
                          initialValue: formatDate(
                            userController
                                    .userProfileList
                                    .first
                                    .personnel
                                    ?.lastInvestigationDate
                                    ?.toString() ??
                                '',
                          ),
                          decoration: const InputDecoration(filled: true),
                          enabled: false,
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
                        _sectionTitle(
                          AppImages.heartbeatIcon,
                          "Medical Details",
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _textFieldTitle("Age"),
                                  const SizedBox(height: 5),
                                  TextFormField(
                                    initialValue:
                                        userController
                                            .userProfileList
                                            .first
                                            .personnel
                                            ?.age ??
                                        '',
                                    decoration: const InputDecoration(
                                      filled: true,
                                    ),
                                    enabled: false,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _textFieldTitle("W.E.F. Date"),
                                  const SizedBox(height: 5),
                                  TextFormField(
                                    initialValue: formatDate(
                                      userController
                                              .userProfileList
                                              .first
                                              .personnel
                                              ?.medicalCategoryWithEffectFrom
                                              ?.toString() ??
                                          '',
                                    ),
                                    decoration: const InputDecoration(
                                      filled: true,
                                    ),
                                    enabled: false,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        _textFieldTitle("Past Medical History"),
                        const SizedBox(height: 5),
                        TextFormField(
                          initialValue:
                              userController
                                  .userProfileList
                                  .first
                                  .personnel
                                  ?.pastMedicalHistory ??
                              '',
                          decoration: const InputDecoration(filled: true),
                          enabled: false,
                        ),
                        const SizedBox(height: 10),
                        _textFieldTitle("Present Medical Category"),
                        const SizedBox(height: 5),
                        _buildShimmerDropdown(
                          isLoading: medicalCategoryController.isLoading.value,
                          child: DropdownSearch<String>(
                            popupProps: const PopupProps.menu(
                              showSelectedItems: true,
                              showSearchBox: true,
                              searchFieldProps: TextFieldProps(
                                decoration: InputDecoration(
                                  labelText: 'Search Medical Category',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            items: medicalCategoryController.getMedicalNames(),
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                hintText: "Select Medical Category",
                                border: const OutlineInputBorder(),
                                errorText:
                                    medicalCategoryController
                                        .errorMessage
                                        .value
                                        .isNotEmpty
                                    ? medicalCategoryController
                                          .errorMessage
                                          .value
                                    : null,
                              ),
                            ),
                            onChanged: (String? selectedMedicalCategory) {
                              if (selectedMedicalCategory != null) {
                                medicalCategoryController.selectedMedicalVal =
                                    selectedMedicalCategory.obs;
                                String? medicalCategoryCode =
                                    medicalCategoryController.getMedicalId(
                                      selectedMedicalCategory,
                                    );
                                print(
                                  'Selected Medical Category: $selectedMedicalCategory, Code: $medicalCategoryCode',
                                );
                              }
                            },
                            selectedItem:
                                medicalCategoryController.getMedicalNameById(
                                  userController
                                          .userProfileList
                                          .first
                                          .personnel
                                          ?.currentMedicalCategory ??
                                      '',
                                ) ??
                                serviceController.selectedServiceVal?.value ??
                                'Select Medical Category',
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
                        _sectionTitle(
                          AppImages.calenderCheckBlueIcon,
                          "Appointment Details",
                        ),
                        const SizedBox(height: 10),
                        _textFieldTitle("Year Of AME/PME*"),
                        const SizedBox(height: 5),
                        _buildShimmerDropdown(
                          isLoading: financialYearController.isLoading.value,
                          child: DropdownSearch<String>(
                            popupProps: const PopupProps.menu(
                              showSelectedItems: true,
                              showSearchBox: true,
                              searchFieldProps: TextFieldProps(
                                decoration: InputDecoration(
                                  labelText: 'Search Financial Year',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            items: financialYearController
                                .getFinancialYearNames(),
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                hintText: "Select Appointment Year",
                                border: const OutlineInputBorder(),
                                errorText:
                                    financialYearController
                                        .errorMessage
                                        .value
                                        .isNotEmpty
                                    ? financialYearController.errorMessage.value
                                    : null,
                              ),
                            ),
                            onChanged: (String? selectedFinancialYear) async {
                              if (selectedFinancialYear != null) {
                                financialYearController
                                    .updateSelectedFinancialYear(
                                      selectedFinancialYear,
                                    );
                                String? financialYearId =
                                    financialYearController.getFinancialYearId(
                                      selectedFinancialYear,
                                    );
                                print(
                                  'Selected Financial Year: $selectedFinancialYear, ID: $financialYearId',
                                );

                                // Fetch due date based on selected year and rank
                                String rankCode =
                                    rankController.getRankId(
                                      rankController.selectedRankVal?.value ??
                                          userController
                                              .userProfileList
                                              .first
                                              .personnel
                                              ?.rankCode ??
                                          '',
                                    ) ??
                                    '';
                                if (rankCode.isNotEmpty &&
                                    financialYearId != null) {
                                  await scheduleDueDateController.getDueDate(
                                    context: context,
                                    rankCode: rankCode,
                                    ameYear: selectedFinancialYear,
                                  );
                                  // Update the scheduled due date in the controller
                                  if (scheduleDueDateController
                                      .dueDateData
                                      .isNotEmpty) {
                                    DateTime? dueDate =
                                        scheduleDueDateController
                                            .dueDateData
                                            .first
                                            .scheduledDueDate;
                                    if (dueDate != null) {
                                      controller.updateScheduledDueDate(
                                        dueDate,
                                      );
                                    }
                                  }
                                }
                              }
                            },
                            selectedItem: financialYearController
                                .selectedFinancialYearVal
                                ?.value,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _textFieldTitle("Preferred Date"),
                        const SizedBox(height: 5),
                        Obx(() {
                          return TextFormField(
                            controller: TextEditingController(
                              text: controller.preferredDate.value != null
                                  ? DateFormat(
                                      'dd/MM/yyyy',
                                    ).format(controller.preferredDate.value!)
                                  : '',
                            ),
                            decoration: InputDecoration(
                              suffixIcon: const Icon(Icons.calendar_today),
                              border: const OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.grey[200],
                            ),
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100),
                              );
                              if (pickedDate != null) {
                                controller.updatePreferredDate(pickedDate);
                              }
                            },
                          );
                        }),
                        const SizedBox(height: 10),
                        _textFieldTitle("Scheduled Due Date"),
                        const SizedBox(height: 5),
                        Obx(() {
                          // Check if due date is loading
                          if (scheduleDueDateController.isLoading.value) {
                            return _buildShimmerField();
                          }
                          // Check for error
                          if (scheduleDueDateController
                              .errorMessage
                              .value
                              .isNotEmpty) {
                            return TextFormField(
                              controller: TextEditingController(
                                text: 'Error loading due date',
                              ),
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                filled: true,
                                fillColor: Colors.grey[200],
                                errorText: scheduleDueDateController
                                    .errorMessage
                                    .value,
                              ),
                              readOnly: true,
                            );
                          }
                          // Display the due date
                          return TextFormField(
                            controller: TextEditingController(
                              text: controller.scheduledDueDate.value != null
                                  ? DateFormat(
                                      'dd/MM/yyyy',
                                    ).format(controller.scheduledDueDate.value!)
                                  : scheduleDueDateController
                                            .dueDateData
                                            .isNotEmpty &&
                                        scheduleDueDateController
                                                .dueDateData
                                                .first
                                                .scheduledDueDate !=
                                            null
                                  ? DateFormat('dd/MM/yyyy').format(
                                      scheduleDueDateController
                                          .dueDateData
                                          .first
                                          .scheduledDueDate!,
                                    )
                                  : '',
                            ),
                            decoration: InputDecoration(
                              suffixIcon: const Icon(Icons.calendar_today),
                              border: const OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.grey[200],
                            ),
                            readOnly: true,
                          );
                        }),
                        const SizedBox(height: 10),
                        _textFieldTitle("Mobile Number"),
                        const SizedBox(height: 5),
                        TextFormField(
                          initialValue:
                              userController
                                  .userProfileList
                                  .first
                                  .personnel
                                  ?.personalMobileNumber ??
                              '',
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          enabled: false,
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
                        _sectionTitle(
                          AppImages.uploadArrowIcon,
                          "Document Upload${controller.isDocumentUploadMandatory ? ' *' : ''}",
                        ),
                        const SizedBox(height: 10),
                        Obx(() {
                          return DottedBorder(
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(8),
                            color:
                                controller.isDocumentUploadMandatory &&
                                    controller.selectedFile.value == null
                                ? Colors.red
                                : Colors.grey,
                            strokeWidth: 1.0,
                            dashPattern: const [4, 4],
                            child: InkWell(
                              onTap: () async {
                                FilePickerResult? result = await FilePicker
                                    .platform
                                    .pickFiles(
                                      type: FileType.custom,
                                      allowedExtensions: [
                                        'pdf',
                                        'doc',
                                        'docx',
                                        'jpeg',
                                        'png',
                                      ],
                                      allowMultiple: false,
                                    );
                                if (result != null && result.files.isNotEmpty) {
                                  controller.updateSelectedFile(
                                    result.files.first,
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Selected file: ${result.files.first.name}',
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                height: 100,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(AppImages.uploadSkyIcon),
                                      const SizedBox(height: 10),
                                      Text(
                                        controller.selectedFile.value != null
                                            ? 'File selected: ${controller.selectedFile.value!.name}'
                                            : controller
                                                  .isDocumentUploadMandatory
                                            ? "Upload Mandatory Condonation Document"
                                            : "Upload Condonation Document (Optional)",
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              controller.selectedFile.value !=
                                                  null
                                              ? AppColors.defaultblack
                                              : Colors.grey,
                                        ),
                                      ),
                                      if (controller.selectedFile.value ==
                                          null) ...[
                                        const SizedBox(height: 5),
                                        Text(
                                          "Drag & drop a file here or click to browse",
                                          style: GoogleFonts.inter(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                        if (controller.isDocumentUploadMandatory &&
                            controller.selectedFile.value == null) ...[
                          const SizedBox(height: 5),
                          Text(
                            "Document upload is mandatory when the preferred date is after the scheduled due date.",
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: Colors.red,
                            ),
                          ),
                        ],
                        // Display selected file
                        if (controller.selectedFile.value != null) ...[
                          const SizedBox(height: 10),
                          Text(
                            "Selected File:",
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.defaultblack,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    controller.selectedFile.value!.name,
                                    style: GoogleFonts.inter(fontSize: 12),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    controller.clearSelectedFile();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
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
                            "I declare that I am not under any medication without the knowledge of Authorised Medical Attendant.",
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromRGBO(55, 60, 59, 1),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Obx(
                          () => Row(
                            children: [
                              Checkbox(
                                value: controller
                                    .appointment
                                    .value
                                    .declarationAgreed,
                                onChanged: (value) {
                                  controller.updateDeclarationAgreed(
                                    value ?? false,
                                  );
                                },
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
                        _sectionTitle(
                          AppImages.declarationIcon,
                          "Special Category",
                        ),
                        const SizedBox(height: 10),
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
                          contentPadding: const EdgeInsets.symmetric(
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
                          contentPadding: const EdgeInsets.symmetric(
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
                          contentPadding: const EdgeInsets.symmetric(
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
                          dense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 0,
                          ),
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
                          dense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: controller.reviewApplication,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
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
                const SizedBox(height: 20),
              ],
            ),
          );
        }),
        bottomNavigationBar: const CustomBottomBar(),
      ),
    );
  }

  String formatDate(String inputDate) {
    if (inputDate.isEmpty) return '';
    DateTime dateTime = DateTime.parse(inputDate);
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(dateTime);
  }

  Widget _buildShimmerScreen() {
    return SingleChildScrollView(
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
                  _sectionTitle(AppImages.personIcon, "Personal Details"),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(child: _buildShimmerField()),
                      const SizedBox(width: 10),
                      Expanded(child: _buildShimmerField()),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _buildShimmerField(),
                  const SizedBox(height: 10),
                  _buildShimmerField(),
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
                  _buildShimmerField(),
                  const SizedBox(height: 10),
                  _buildShimmerField(),
                  const SizedBox(height: 10),
                  _buildShimmerField(),
                  const SizedBox(height: 10),
                  _buildShimmerField(),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(child: _buildShimmerField()),
                      const SizedBox(width: 10),
                      Expanded(child: _buildShimmerField()),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _buildShimmerField(),
                  const SizedBox(height: 10),
                  _buildShimmerField(),
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
                  Row(
                    children: [
                      Expanded(child: _buildShimmerField()),
                      const SizedBox(width: 10),
                      Expanded(child: _buildShimmerField()),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _buildShimmerField(),
                  const SizedBox(height: 10),
                  _buildShimmerField(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerField() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildShimmerDropdown({
    required bool isLoading,
    required Widget child,
  }) {
    return isLoading
        ? Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          )
        : child;
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
