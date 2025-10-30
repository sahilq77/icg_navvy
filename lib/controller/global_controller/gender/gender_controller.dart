import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icg_navy/model/global_model/service_details/get_service_details_response.dart';
import 'package:icg_navy/utility/app_utility.dart';
import '../../../core/network/exceptions.dart';
import '../../../core/network/networkcall.dart';
import '../../../core/urls.dart';
import '../../../utility/app_colors.dart';

class GenderController extends GetxController {
  RxList<Gender> genderList = <Gender>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  RxString? selectedGenderVal;

  static GenderController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    // Defer fetching until context is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Get.context != null) {
        fetchGender(context: Get.context!);
      }
    });
  }

  Future<void> fetchGender({
    required BuildContext context,
    bool forceFetch = false,
  }) async {
    log("Gender API call");
    if (!forceFetch && genderList.isNotEmpty) return;

    try {
      isLoading.value = true;
      errorMessage.value = '';

      List<GetServiceDetailsResponse>? response =
          await Networkcall().getMethod(
                Networkutility.getServiceDetailsApi,
                Networkutility.getServiceDetails +
                    "?personalNumber=${AppUtility.userID}&roleCode=undefined&genderYn=1&userTypeYn=1&commandYn=1&appointmentStatusYn=1&investigationStatusYn=1&miRoomYn=1&amaYn=1&medicalYn=1",
                Get.context!,
              )
              as List<GetServiceDetailsResponse>?;

      log(
        'Fetch Gender Response: ${response?.isNotEmpty == true ? response![0].toJson() : 'null'}',
      );

      if (response != null && response.isNotEmpty) {
        if (response[0].status == "Success") {
          genderList.value = response[0].data!.first.gender as List<Gender>;
          log(
            'Gender List Loaded: ${genderList.map((s) => "${s.genderName}: ${s.genderCode}").toList()}',
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
      log('Fetch Gender Exception: $e, stack: $stackTrace');
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

  List<String> getGenderNames() {
    return genderList.map((s) => s.genderName.toString()).toSet().toList();
  }

  // FIXED: Now returns genderCode, not genderName
  String? getGenderId(String genderName) {
    return genderList
        .firstWhereOrNull((state) => state.genderName.toString() == genderName)
        ?.genderCode; // ← Correct: Returns the code (e.g., "M", "F")
  }

  String? getGenderNameById(String genderId) {
    return genderList
        .firstWhereOrNull((state) => state.genderCode == genderId)
        ?.genderName
        .toString();
  }
}
