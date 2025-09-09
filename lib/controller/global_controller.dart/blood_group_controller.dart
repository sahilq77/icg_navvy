import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../model/global_model/blood_group/get_blood_group_response.dart';
import '../../../core/network/exceptions.dart';
import '../../../core/network/networkcall.dart';
import '../../../core/urls.dart';
import '../../../utility/app_colors.dart';

class BloodGroupController extends GetxController {
  RxList<BloodGroupData> bloodGroupList = <BloodGroupData>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  RxString? selectedBloodGroupVal; // Renamed from selectedCompanyVal

  static BloodGroupController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    // Defer fetching until context is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Get.context != null) {
        fetchBloodGroups(context: Get.context!);
      }
    });
  }

  Future<void> fetchBloodGroups({
    required BuildContext context,
    bool forceFetch = false,
  }) async {
    log("Blood group API call"); // Updated log message
    if (!forceFetch && bloodGroupList.isNotEmpty) return;

    try {
      isLoading.value = true;
      errorMessage.value = '';
      // final jsonBody = {"employee_id": AppUtility.userID.toString()};

      List<GetBloodGroupResponse>? response =
          await Networkcall().getMethod(
                Networkutility.getBloodGroupApi,
                Networkutility.getBloodGroup,
                Get.context!,
              ) as List<GetBloodGroupResponse>?;

      log(
        'Fetch Blood Groups Response: ${response?.isNotEmpty == true ? response![0].toJson() : 'null'}', // Updated log message
      );

      if (response != null && response.isNotEmpty) {
        if (response[0].status == "Success") {
          bloodGroupList.value = response[0].data as List<BloodGroupData>;
          log(
            'Blood Group List Loaded: ${bloodGroupList.map((s) => "${s.bloodGroupCode}: ${s.bloodGroupName}").toList()}', // Updated log message
          );
        } else {
          errorMessage.value = response[0].status.toString();
          Get.snackbar(
            'Error',
            response[0].status.toString(),
            backgroundColor: AppColors.error,
            colorText: Colors.white,
          );
        }
      } else {
        errorMessage.value = 'No response from server';
        Get.snackbar(
          'Error',
          'No response from server',
          backgroundColor: AppColors.error,
          colorText: Colors.white,
        );
      }
    } on NoInternetException catch (e) {
      errorMessage.value = e.message;
      Get.snackbar(
        'Error',
        e.message,
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
    } on TimeoutException catch (e) {
      errorMessage.value = e.message;
      Get.snackbar(
        'Error',
        e.message,
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
    } on HttpException catch (e) {
      errorMessage.value = '${e.message} (Code: ${e.statusCode})';
      Get.snackbar(
        'Error',
        '${e.message} (Code: ${e.statusCode})',
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
    } on ParseException catch (e) {
      errorMessage.value = e.message;
      Get.snackbar(
        'Error',
        e.message,
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
    } catch (e, stackTrace) {
      errorMessage.value = 'Unexpected error: $e';
      log('Fetch Blood Groups Exception: $e, stack: $stackTrace'); // Updated log message
      Get.snackbar(
        'Error',
        'Unexpected error: $e',
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  List<String> getBloodGroupNames() {
    return bloodGroupList
        .map((s) => s.bloodGroupName.toString())
        .toSet()
        .toList();
  }

  String? getBloodGroupId(String bloodGroupName) {
    return bloodGroupList
            .firstWhereOrNull(
              (state) => state.bloodGroupName.toString() == bloodGroupName,
            )
            ?.bloodGroupCode ??
        '';
  }

  String? getBloodGroupNameById(String bloodGroupId) {
    return bloodGroupList
        .firstWhereOrNull((state) => state.bloodGroupCode == bloodGroupId)
        ?.bloodGroupName
        .toString();
  }
}