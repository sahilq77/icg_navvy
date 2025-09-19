import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icg_navy/model/global_model/financial_year/get_financial_year_response.dart';
import 'package:icg_navy/utility/app_utility.dart';
import '../../../core/network/exceptions.dart';
import '../../../core/network/networkcall.dart';
import '../../../core/urls.dart';
import '../../../utility/app_colors.dart';

class FinancialYearController extends GetxController {
  RxList<FinancialYearData> financialYearList = <FinancialYearData>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  RxString? selectedFinancialYearVal;

  static FinancialYearController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    // Defer fetching until context is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Get.context != null) {
        fetchFinancialYear(context: Get.context!);
      }
    });
  }

  Future<void> fetchFinancialYear({
    required BuildContext context,
    bool forceFetch = false,
  }) async {
    log("FinancialYearData API call");
    if (!forceFetch && financialYearList.isNotEmpty) return;

    try {
      isLoading.value = true;
      errorMessage.value = '';

      List<GetFinancialYearResponse>? response =
          await Networkcall().getMethod(
                Networkutility.getFinancialYearApi,
                Networkutility.getFinancialYear + "?isActive=2",
                Get.context!,
              )
              as List<GetFinancialYearResponse>?;

      log(
        'Fetch FinancialYearData Response: ${response?.isNotEmpty == true ? response![0].toJson() : 'null'}',
      );

      if (response != null && response.isNotEmpty) {
        if (response[0].status == "Success") {
          financialYearList.value = response[0].data as List<FinancialYearData>;
          log(
            'FinancialYearData List Loaded: ${financialYearList.map((m) => "${m.financialYear}: ${m.financialDescription}").toList()}',
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
      log('Fetch FinancialYearData Exception: $e, stack: $stackTrace');
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

  List<String> getFinancialYearNames() {
    return financialYearList
        .map((m) => m.financialDescription.toString())
        .toSet()
        .toList();
  }

  String? getFinancialYearId(String financialDescription) {
    return financialYearList
            .firstWhereOrNull(
              (state) =>
                  state.financialDescription.toString() == financialDescription,
            )
            ?.financialYear
            .toString() ??
        '';
  }

  String? getFinancialYearNameById(String financialYearId) {
    return financialYearList
        .firstWhereOrNull(
          (state) => state.financialYear.toString() == financialYearId,
        )
        ?.financialDescription
        .toString();
  }

  void updateSelectedFinancialYear(String? financialDescription) {
    if (financialDescription != null) {
      selectedFinancialYearVal = financialDescription.obs;
    }
  }
}
