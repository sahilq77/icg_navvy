import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icg_navy/model/global_model/service_details/get_service_details_response.dart';
import 'package:icg_navy/model/global_model/unit/get_unit_response.dart';
import 'package:icg_navy/utility/app_utility.dart';
import '../../../core/network/exceptions.dart';
import '../../../core/network/networkcall.dart';
import '../../../core/urls.dart';
import '../../../utility/app_colors.dart';

class AllUnitController extends GetxController {
  RxList<Unit> unitList = <Unit>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  RxString? selectedUnitVal;

  static AllUnitController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    // Defer fetching until context is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Get.context != null) {
        fetchUnit(context: Get.context!);
      }
    });
  }

  Future<void> fetchUnit({
    required BuildContext context,
    bool forceFetch = false,
  }) async {
    log("Unit API call");
    if (!forceFetch && unitList.isNotEmpty) return;

    try {
      isLoading.value = true;
      errorMessage.value = '';

      List<GetUnitResponse>? response =
          await Networkcall().getMethod(
                Networkutility.getUnitApi,

                "https://aasha-demo.epps-erp.in/me/aasha/v1/idName/filter?personalNumber=75727-F&roleCode=410&dataKey=UNIT",
                Get.context!,
              )
              as List<GetUnitResponse>?;

      log(
        'Fetch Unit Response: ${response?.isNotEmpty == true ? response![0].toJson() : 'null'}',
      );

      if (response != null && response.isNotEmpty) {
        if (response[0].status == "Success") {
          unitList.value = response[0].data!.first.unit as List<Unit>;
          log(
            'Unit List Loaded: ${unitList.map((s) => "${s.unitCode}: ${s.unitName}").toList()}',
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
      log('Fetch Unit Exception: $e, stack: $stackTrace');
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

  List<String> getUnitNames() {
    return unitList.map((s) => s.unitName.toString()).toSet().toList();
  }

  String? getUnitId(String unitName) {
    return unitList
            .firstWhereOrNull((state) => state.unitName.toString() == unitName)
            ?.unitCode ??
        '';
  }

  String? getUnitNameById(String unitId) {
    return unitList
        .firstWhereOrNull((state) => state.unitCode == unitId)
        ?.unitName
        .toString();
  }
}
