import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:icg_navy/controller/otp/send_and_verify_otp_controller.dart';
import 'package:intl/intl.dart';
import '../../utility/app_routes.dart';
import '../global_controller/all_unit/all_unit_controller.dart';
import '../global_controller/blood_group/blood_group_controller.dart';
import '../global_controller/branch/branch_controller.dart';
import '../global_controller/command/commnand_controller.dart';
import '../global_controller/financial_year/financial_year_controller.dart';
import '../global_controller/gender/gender_controller.dart';
import '../global_controller/medical_category/medical_category_controller.dart';
import '../global_controller/rank/rank_controller.dart';
import '../global_controller/service/service_controller.dart';
import '../global_controller/unit/unit_controller.dart';
import '../user_details/user_details_controller.dart';

class ScheduleAppointmentController extends GetxController {
  var preferredDate = Rxn<DateTime>(); // Store preferred date
  var scheduledDueDate = Rxn<DateTime>(); // Store scheduled due date
  var declarationAgreed = false.obs;
  var appointment = Appointment().obs; // Appointment model
  var selectedFile = Rxn<PlatformFile>(); // Store selected file

  final sendAndVerifyOtpController = Get.put(SendAndVerifyOtpController());

  // Check if document upload is mandatory
  bool get isDocumentUploadMandatory {
    if (preferredDate.value == null || scheduledDueDate.value == null) {
      return false;
    }
    return preferredDate.value!.isAfter(scheduledDueDate.value!);
  }

  void updatePreferredDate(DateTime? date) {
    preferredDate.value = date;
    // Trigger update to reflect mandatory status in UI
    update();
  }

  void updateScheduledDueDate(DateTime? date) {
    scheduledDueDate.value = date;
    // Trigger update to reflect mandatory status in UI
    update();
  }

  void updateSelectedFile(PlatformFile? file) {
    selectedFile.value = file;
    update();
  }

  void updateDeclarationAgreed(bool value) {
    print('Declaration Agreed: $value'); // Debugging
    appointment.update((val) {
      val?.declarationAgreed = value;
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

  void reviewApplication() {
    // Validate required fields
    if (!appointment.value.declarationAgreed) {
      Get.snackbar(
        'Error',
        'Please agree to the declaration before proceeding.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (preferredDate.value == null ||
        scheduledDueDate.value == null ||
        Get.find<FinancialYearController>().selectedFinancialYearVal?.value ==
            null) {
      Get.snackbar(
        'Error',
        'Please fill in all required fields (Preferred Date, Scheduled Due Date, Year of AME/PME).',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    // Validate document upload if mandatory
    if (isDocumentUploadMandatory && selectedFile.value == null) {
      Get.snackbar(
        'Error',
        'Document upload is mandatory when the preferred date is after the scheduled due date.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Populate Appointment model with data from other controllers
    final userController = Get.find<UserDetailsController>();
    final bloodGroupController = Get.find<BloodGroupController>();
    final rankController = Get.find<RankController>();
    final commandController = Get.find<CommandController>();
    final genderController = Get.find<GenderController>();
    final unitController = Get.find<UnitController>();
    final allUnitController = Get.find<AllUnitController>();
    final branchController = Get.find<BranchController>();
    final serviceController = Get.find<ServiceController>();
    final medicalCategoryController = Get.find<MedicalCategoryController>();
    final financialYearController = Get.find<FinancialYearController>();

    appointment.update((val) {
      val?.personalNumber =
          userController.userProfileList.first.personnel?.personalNumber ??
          'N/A';
      val?.rank =
          rankController.selectedRankVal?.value ??
          rankController.getRankNameById(
            userController.userProfileList.first.personnel?.rankCode ?? '',
          ) ??
          'N/A';
      val?.name =
          userController.userProfileList.first.personnel?.fullName ?? 'N/A';
      val?.bloodGroup =
          bloodGroupController.selectedBloodGroupVal?.value ??
          bloodGroupController.getBloodGroupNameById(
            userController.userProfileList.first.personnel?.bloodGroupCode ??
                '',
          ) ??
          'N/A';
      val?.command =
          commandController.selectedCommandVal?.value ??
          commandController.getCommandNameById(
            userController.userProfileList.first.personnel?.commandCode ?? '',
          ) ??
          'N/A';
      val?.unit =
          unitController.selectedUnitVal?.value ??
          unitController.getUnitNameById(
            userController.userProfileList.first.personnel?.unitCode ?? '',
          ) ??
          'N/A';
      val?.armCorpsBranchTrade =
          branchController.selectedBranchVal?.value ??
          branchController.getBranchNameById(
            userController.userProfileList.first.personnel?.branchCode ?? '',
          ) ??
          'N/A';
      val?.gender =
          genderController.selectedGenderVal?.value ??
          genderController.getGenderNameById(
            userController.userProfileList.first.personnel?.employeeGender ??
                '',
          ) ??
          'N/A';
      val?.service =
          serviceController.selectedServiceVal?.value ??
          serviceController.getServiceNameById(
            userController.userProfileList.first.personnel?.serviceCode ?? '',
          ) ??
          'N/A';
      val?.dateOfBirth = formatDate(
        userController.userProfileList.first.personnel?.dateOfBirth
                ?.toString() ??
            '',
      );
      val?.totalService =
          userController.userProfileList.first.personnel?.totalService ?? 'N/A';
      val?.dateOfCommission = formatDate(
        userController.userProfileList.first.personnel?.dateOfCommissioning
                ?.toString() ??
            '',
      );
      val?.lastAmePmeLocation =
          allUnitController.selectedUnitVal?.value ??
          allUnitController.getUnitNameById(
            userController.userProfileList.first.personnel?.unitCode ?? '',
          ) ??
          'N/A';
      val?.lastExaminationDate = formatDate(
        userController.userProfileList.first.personnel?.lastInvestigationDate
                ?.toString() ??
            '',
      );
      val?.age = userController.userProfileList.first.personnel?.age ?? 'N/A';
      val?.wefDate = formatDate(
        userController
                .userProfileList
                .first
                .personnel
                ?.medicalCategoryWithEffectFrom
                ?.toString() ??
            '',
      );
      val?.pastMedicalHistory =
          userController.userProfileList.first.personnel?.pastMedicalHistory ??
          'N/A';
      val?.presentMedicalCategory =
          medicalCategoryController.selectedMedicalVal?.value ??
          medicalCategoryController.getMedicalNameById(
            userController
                    .userProfileList
                    .first
                    .personnel
                    ?.currentMedicalCategory ??
                '',
          ) ??
          'N/A';
      val?.appointmentYear =
          financialYearController.selectedFinancialYearVal?.value ?? 'N/A';
      val?.preferredDate = preferredDate.value != null
          ? DateFormat('dd/MM/yyyy').format(preferredDate.value!)
          : 'N/A';
      val?.scheduledDueDate = scheduledDueDate.value != null
          ? DateFormat('dd/MM/yyyy').format(scheduledDueDate.value!)
          : 'N/A';
      val?.mobileNumber =
          userController
              .userProfileList
              .first
              .personnel
              ?.personalMobileNumber ??
          'N/A';
    });

    Get.toNamed(AppRoutes.scheduleAppinmentAMEReview);
  }

  String formatDate(String inputDate) {
    if (inputDate.isEmpty) return 'N/A';
    try {
      DateTime dateTime = DateTime.parse(inputDate);
      DateFormat formatter = DateFormat('dd/MM/yyyy');
      return formatter.format(dateTime);
    } catch (e) {
      return 'N/A';
    }
  }
}

class Appointment {
  bool declarationAgreed = false;
  bool diver = false;
  bool submariner = false;
  bool marco = false;
  bool aviator = false;
  bool noneOfAbove = false;

  // Fields for review screen
  String? personalNumber;
  String? rank;
  String? name;
  String? bloodGroup;
  String? command;
  String? unit;
  String? armCorpsBranchTrade;
  String? gender;
  String? service;
  String? dateOfBirth;
  String? totalService;
  String? dateOfCommission;
  String? lastAmePmeLocation;
  String? lastExaminationDate;
  String? age;
  String? wefDate;
  String? pastMedicalHistory;
  String? presentMedicalCategory;
  String? appointmentYear;
  String? preferredDate;
  String? scheduledDueDate;
  String? mobileNumber;

  Appointment({
    this.declarationAgreed = false,
    this.diver = false,
    this.submariner = false,
    this.marco = false,
    this.aviator = false,
    this.noneOfAbove = false,
    this.personalNumber,
    this.rank,
    this.name,
    this.bloodGroup,
    this.command,
    this.unit,
    this.armCorpsBranchTrade,
    this.gender,
    this.service,
    this.dateOfBirth,
    this.totalService,
    this.dateOfCommission,
    this.lastAmePmeLocation,
    this.lastExaminationDate,
    this.age,
    this.wefDate,
    this.pastMedicalHistory,
    this.presentMedicalCategory,
    this.appointmentYear,
    this.preferredDate,
    this.scheduledDueDate,
    this.mobileNumber,
  });
}
