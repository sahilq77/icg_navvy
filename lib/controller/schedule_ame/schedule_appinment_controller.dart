import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:icg_navy/controller/otp/send_and_verify_otp_controller.dart';
import 'package:icg_navy/core/urls.dart';
import 'package:icg_navy/model/submit_ame/get_submit_ame_response.dart';
import 'package:intl/intl.dart';
import '../../core/network/exceptions.dart';
import '../../core/network/networkcall.dart';
import '../../utility/app_colors.dart';
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
  var preferredDate = Rxn<DateTime>();
  var scheduledDueDate = Rxn<DateTime>();
  var declarationAgreed = false.obs;
  var appointment = Appointment().obs;
  var selectedFile = Rxn<PlatformFile>(); // Changed to single file

  RxBool isLoadingup = false.obs; // Initialize as false
  var errorMessageUp = ''.obs;
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

  final sendAndVerifyOtpController = Get.put(SendAndVerifyOtpController());

  bool get isDocumentUploadMandatory {
    if (preferredDate.value == null || scheduledDueDate.value == null) {
      return false;
    }
    return preferredDate.value!.isAfter(scheduledDueDate.value!);
  }

  void updatePreferredDate(DateTime? date) {
    preferredDate.value = date;
    update();
  }

  void updateScheduledDueDate(DateTime? date) {
    scheduledDueDate.value = date;
    update();
  }

  void updateSelectedFile(PlatformFile? file) {
    selectedFile.value = file;
    update();
  }

  void clearSelectedFile() {
    selectedFile.value = null;
    update();
  }

  void updateDeclarationAgreed(bool value) {
    print('Declaration Agreed: $value');
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

  Future<bool> uploadDocuments({
    required String uploadedBy,
    required String personalNumber,
    required String appointmentSerialNumber,
    String investigationType = 'Request',
    String investigationSubType = '',
    String parameter = '',
    String documentRemarks = '',
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          'https://aasha-demo.epps-erp.in/me/aasha/investigation/v1/documentDetail'
          '?uploadedBy=$uploadedBy'
          '&personalNumber=$personalNumber'
          '&appointmentSerialNumber=$appointmentSerialNumber'
          '&investigatioType=$investigationType'
          '&investigatioSubType=$investigationSubType'
          '&parameter=$parameter'
          '&documentRemarks=$documentRemarks',
        ),
      );

      // Add single file to the multipart request
      if (selectedFile.value != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'file', // Field name expected by the API
            selectedFile.value!.path!,
            filename: selectedFile.value!.name,
          ),
        );
      }

      // Send the request
      var response = await request.send();
      if (response.statusCode == 200) {
        print('File uploaded successfully');
        return true;
      } else {
        print('File upload failed: ${response.statusCode}');
        Get.snackbar(
          'Error',
          'Failed to upload document. Status code: ${response.statusCode}',
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColors.error,
          colorText: Colors.white,
        );
        return false;
      }
    } catch (e) {
      print('Error uploading file: $e');
      Get.snackbar(
        'Error',
        'An error occurred while uploading document: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
      return false;
    }
  }

  Future<void> reviewApplication() async {
    // Validate required fields
    if (!appointment.value.declarationAgreed) {
      Get.snackbar(
        'Error',
        'Please agree to the declaration before proceeding.',
        snackPosition: SnackPosition.TOP,
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
        snackPosition: SnackPosition.TOP,
      );
      return;
    }
    if (isDocumentUploadMandatory && selectedFile.value == null) {
      Get.snackbar(
        'Error',
        'Document upload is mandatory when the preferred date is after the scheduled due date.',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    // Populate Appointment model
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

    // Send OTP
    await sendAndVerifyOtpController.sendOTP(
      context: Get.context,
      username: appointment.value.personalNumber,
      mobileNumber: appointment.value.mobileNumber,
    );

    // Navigate to OTP verification screen
    final result = await Get.toNamed(
      AppRoutes.verifyOtp,
      arguments: {
        'username': appointment.value.personalNumber,
        'mobileNumber': appointment.value.mobileNumber,
      },
    );

    // Handle OTP verification result
    if (result == true) {
      // Submit AME data first
      await submitAme(context: Get.context);

      // Check if AME submission was successful
      if (isLoadingup.value == false && errorMessageUp.value.isEmpty) {
        // Upload document if selected
        if (selectedFile.value != null) {
          bool uploadSuccess = await uploadDocuments(
            uploadedBy: appointment.value.personalNumber ?? '75727-F',
            personalNumber: appointment.value.personalNumber ?? '75727-F',
            appointmentSerialNumber: '397', // Replace with actual serial number
            documentRemarks: 'Condonation Document',
          );

          if (!uploadSuccess) {
            return; // Stop if upload fails
          }
        }

        // Navigate to review screen only if submission and upload (if needed) are successful
        // Get.toNamed(AppRoutes.scheduleAppinmentAMEReview);
      }
      //  else {
      //   // Submission failed, error is already shown in submitAme
      //   return;
      // }
    }
    // else {
    //   Get.snackbar(
    //     'Error',
    //     'OTP verification failed. Please try again.',
    //     snackPosition: SnackPosition.TOP,
    //     backgroundColor: AppColors.error,
    //     colorText: Colors.white,
    //   );
    // }
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

  Future<void> submitAme({BuildContext? context}) async {
    try {
      isLoadingup.value = true;
      errorMessageUp.value = '';

      // -----------------------------------------------------------------
      //  All static values are now taken from the `appointment` model
      // -----------------------------------------------------------------
      final jsonBody = {
        "data": [
          {
            "companyCode": 1,
            "divisionCode": 4,
            "locationCode": 443,
            "personalSerialNumber": 168933,
            "appointmentStage": 10,
            "unitCode":
                unitController.getUnitId(appointment.value.unit ?? '') ??
                unitController.getUnitId(
                  userController.userProfileList.first.personnel?.unitCode ??
                      '',
                ) ??
                '',
            "appointmentStatus": 10,
            "createdBy": appointment.value.personalNumber ?? '',
            "personalNumber": appointment.value.personalNumber ?? '',
            "createdByName": appointment.value.name ?? '',
            "createdByUnitCode":
                unitController.getUnitId(appointment.value.unit ?? '') ??
                unitController.getUnitId(
                  userController.userProfileList.first.personnel?.unitCode ??
                      '',
                ) ??
                '',
            "createdDate":
                DateTime.now().toUtc().toIso8601String().substring(0, 23) + 'Z',
            "creatorRoleCode": 416,
            "createdByUnitName": appointment.value.unit ?? '',
            "personalMobileNumber": appointment.value.mobileNumber ?? '',
            "dueDate": appointment.value.scheduledDueDate != null
                ? DateFormat('yyyy-MM-dd').format(
                    DateFormat(
                      'dd/MM/yyyy',
                    ).parse(appointment.value.scheduledDueDate!),
                  )
                : '',
            "applyBeforeDate": "2024-03-31",
            "appointmentYear":
                int.tryParse(appointment.value.appointmentYear ?? '') ??
                DateTime.now().year,
            "personalPreferredDate":
                appointment.value.preferredDate != null &&
                    appointment.value.preferredDate!.isNotEmpty
                ? DateFormat('yyyy-MM-dd').format(
                    DateFormat(
                      'dd/MM/yyyy',
                    ).parse(appointment.value.preferredDate!),
                  )
                : '',
            "appointmentRemarks": "",
            "declaration":
                "I declare that I am not under any medication without the knowledge of Authorised Medical Attendant.",
            "diverYn": appointment.value.diver ? 1 : 0,
            "airCrewDiverYn": appointment.value.aviator ? 1 : 0,
            "aviatorYn": appointment.value.aviator ? 1 : 0,
            "reemployeedYn": 0,
            "sdOfficerYn": 0,
            "noneOfAboveYn": appointment.value.noneOfAbove ? 1 : 0,
            "medicalEffectFromDate":
                appointment.value.wefDate != null &&
                    appointment.value.wefDate!.isNotEmpty
                ? DateFormat('yyyy-MM-dd').format(
                    DateFormat('dd/MM/yyyy').parse(appointment.value.wefDate!),
                  )
                : '',
            "appointmentPersonDetail": {
              "rankCode":
                  rankController.getRankId(appointment.value.rank ?? '') ??
                  rankController.getRankId(
                    userController.userProfileList.first.personnel?.rankCode ??
                        '',
                  ) ??
                  '',
              "serviceCode":
                  serviceController.getServiceId(
                    appointment.value.service ?? '',
                  ) ??
                  serviceController.getServiceId(
                    userController
                            .userProfileList
                            .first
                            .personnel
                            ?.serviceCode ??
                        '',
                  ) ??
                  '',
              "dateOfBirth":
                  appointment.value.dateOfBirth != null &&
                      appointment.value.dateOfBirth!.isNotEmpty
                  ? DateFormat('yyyy-MM-dd').format(
                      DateFormat(
                        'dd/MM/yyyy',
                      ).parse(appointment.value.dateOfBirth!),
                    )
                  : '',
              "age": appointment.value.age ?? '',
              "commandCode":
                  commandController.getCommandId(
                    appointment.value.command ?? '',
                  ) ??
                  commandController.getCommandId(
                    userController
                            .userProfileList
                            .first
                            .personnel
                            ?.commandCode ??
                        '',
                  ) ??
                  '',
              "unitCode":
                  unitController.getUnitId(appointment.value.unit ?? '') ??
                  unitController.getUnitId(
                    userController.userProfileList.first.personnel?.unitCode ??
                        '',
                  ) ??
                  '',
              "branchCode":
                  branchController.getBranchId(
                    appointment.value.armCorpsBranchTrade ?? '',
                  ) ??
                  branchController.getBranchId(
                    userController
                            .userProfileList
                            .first
                            .personnel
                            ?.branchCode ??
                        '',
                  ) ??
                  '',
              "typeOfCommission": "PMT",
              "dateOfCommissioning":
                  appointment.value.dateOfCommission != null &&
                      appointment.value.dateOfCommission!.isNotEmpty
                  ? DateFormat('yyyy-MM-dd').format(
                      DateFormat(
                        'dd/MM/yyyy',
                      ).parse(appointment.value.dateOfCommission!),
                    )
                  : '',
              "employeeGender":
                  genderController.getGenderId(
                    appointment.value.gender ?? '',
                  ) ??
                  genderController.getGenderId(
                    userController
                            .userProfileList
                            .first
                            .personnel
                            ?.employeeGender ??
                        '',
                  ) ??
                  '',
              "lastInvestigationUnitCode":
                  allUnitController.getUnitId(
                    appointment.value.lastAmePmeLocation ?? '',
                  ) ??
                  allUnitController.getUnitId(
                    userController.userProfileList.first.personnel?.unitCode ??
                        '',
                  ) ??
                  '',
              "lastInvestigationDate":
                  appointment.value.lastExaminationDate != null &&
                      appointment.value.lastExaminationDate!.isNotEmpty
                  ? DateFormat('yyyy-MM-dd').format(
                      DateFormat(
                        'dd/MM/yyyy',
                      ).parse(appointment.value.lastExaminationDate!),
                    )
                  : '',
              "pastMedicalHistory": appointment.value.pastMedicalHistory ?? '',
              "currentMedicalCategory":
                  medicalCategoryController.getMedicalId(
                    appointment.value.presentMedicalCategory ?? '',
                  ) ??
                  medicalCategoryController.getMedicalId(
                    userController
                            .userProfileList
                            .first
                            .personnel
                            ?.currentMedicalCategory ??
                        '',
                  ) ??
                  '',
              "medicalEffectFromDate":
                  appointment.value.wefDate != null &&
                      appointment.value.wefDate!.isNotEmpty
                  ? DateFormat('yyyy-MM-dd').format(
                      DateFormat(
                        'dd/MM/yyyy',
                      ).parse(appointment.value.wefDate!),
                    )
                  : '',
              "bloodGroupCode":
                  bloodGroupController.getBloodGroupId(
                    appointment.value.bloodGroup ?? '',
                  ) ??
                  bloodGroupController.getBloodGroupId(
                    userController
                            .userProfileList
                            .first
                            .personnel
                            ?.bloodGroupCode ??
                        '',
                  ) ??
                  '',
            },
          },
        ],
      };

      log('JSON Body: ${jsonEncode(jsonBody)}'); // Debugging

      List<Object?>? list = await Networkcall().postMethod(
        Networkutility.submitAmeApi,
        Networkutility.submitAme,
        jsonEncode(jsonBody),
        context!,
      );

      // ... rest of the method unchanged ...

      print('Submit AME Response: $list'); // Debugging

      if (list != null && list.isNotEmpty) {
        List<GetSubmitAmeResponse> response = List.from(list);

        if (response[0].status == "true") {
          Get.snackbar(
            'Success',
            'Submitted Successfully',
            backgroundColor: AppColors.success,
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
          );

          Get.offNamed(AppRoutes.confirmtionScreen);
        } else {
          Get.snackbar(
            'Error',
            "Failed to submit application",
            backgroundColor: AppColors.error,
            colorText: Colors.white,
          );
        }
      } else {
        errorMessageUp.value = 'No response from server';
        Get.snackbar(
          'Error',
          'No response from server',
          backgroundColor: AppColors.error,
          colorText: Colors.white,
        );
      }
    } on NoInternetException catch (e) {
      errorMessageUp.value = e.message;
      Get.snackbar(
        'Error',
        e.message,
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
    } on TimeoutException catch (e) {
      errorMessageUp.value = e.message;
      Get.snackbar(
        'Error',
        e.message,
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
    } on HttpException catch (e) {
      errorMessageUp.value = '${e.message} (Code: ${e.statusCode})';
      Get.snackbar(
        'Error',
        '${e.message} (Code: ${e.statusCode})',
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
    } on ParseException catch (e) {
      errorMessageUp.value = e.message;
      Get.snackbar(
        'Error',
        e.message,
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
    } catch (e) {
      errorMessageUp.value = 'Unexpected error: $e';
      Get.snackbar(
        'Error',
        'Unexpected error: $e',
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
    } finally {
      isLoadingup.value = false;
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
