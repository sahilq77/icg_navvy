import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icg_navy/utility/app_utility.dart';
import '../../../core/network/exceptions.dart';
import '../../../core/network/networkcall.dart';
import '../../../core/urls.dart';

import '../../../model/global_model/medical_category/get_medical_category_response.dart';
import '../../../utility/app_colors.dart';

class MedicalCategoryController extends GetxController {
  RxList<Medical> medicalList = <Medical>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  RxString? selectedMedicalVal;

  static MedicalCategoryController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    // Defer fetching until context is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Get.context != null) {
        //  fetchMedicalCategory(context: Get.context!);
      }
    });
  }

  Future<void> fetchMedicalCategory({
    required BuildContext context,
    bool forceFetch = false,
  }) async {
    log("Medical API call");
    if (!forceFetch && medicalList.isNotEmpty) return;

    try {
      isLoading.value = true;
      errorMessage.value = '';

      List<GetMedicalCategoryResponse>? response =
          await Networkcall().getMethod(
                Networkutility.getMedicalCategoryApi,
                Networkutility.getMedicalCategory,
                Get.context!,
              )
              as List<GetMedicalCategoryResponse>?;

      log(
        'Fetch Medical Response: ${response?.isNotEmpty == true ? response![0].toJson() : 'null'}',
      );

      if (response != null && response.isNotEmpty) {
        if (response[0].status == "Success") {
          medicalList.value = response[0].data.first.medical as List<Medical>;
          log(
            'Medical List Loaded: ${medicalList.map((m) => "${m.mediCode}: ${m.mediName}").toList()}',
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
      log('Fetch Medical Exception: $e, stack: $stackTrace');
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

  List<String> getMedicalNames() {
    return medicalList.map((m) => m.mediName.toString()).toSet().toList();
  }

  String? getMedicalId(String mediName) {
    return medicalList
            .firstWhereOrNull((state) => state.mediName.toString() == mediName)
            ?.mediCode ??
        '';
  }

  String? getMedicalNameById(String medicalId) {
    return medicalList
        .firstWhereOrNull((state) => state.mediCode == medicalId)
        ?.mediName
        .toString();
  }
}
