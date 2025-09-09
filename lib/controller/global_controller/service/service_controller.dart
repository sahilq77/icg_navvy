import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icg_navy/model/global_model/service/get_service_response.dart';
import 'package:icg_navy/model/global_model/service_details/get_service_details_response.dart';
import 'package:icg_navy/utility/app_utility.dart';
import '../../../core/network/exceptions.dart';
import '../../../core/network/networkcall.dart';
import '../../../core/urls.dart';
import '../../../utility/app_colors.dart';

class ServiceController extends GetxController {
  RxList<ServiceType> serviceList = <ServiceType>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  RxString? selectedServiceVal;

  static ServiceController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    // Defer fetching until context is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Get.context != null) {
        fetchService(context: Get.context!);
      }
    });
  }

  Future<void> fetchService({
    required BuildContext context,
    bool forceFetch = false,
  }) async {
    log("ServiceType API call");
    if (!forceFetch && serviceList.isNotEmpty) return;

    try {
      isLoading.value = true;
      errorMessage.value = '';

      List<GetServiceResponse>? response =
          await Networkcall().getMethod(
                Networkutility.getServiceApi,
                Networkutility.getService,
                Get.context!,
              )
              as List<GetServiceResponse>?;

      log(
        'Fetch ServiceType Response: ${response?.isNotEmpty == true ? response![0].toJson() : 'null'}',
      );

      if (response != null && response.isNotEmpty) {
        if (response[0].status == "Success") {
          serviceList.value =
              response[0].data!.first.serviceTypes as List<ServiceType>;
          log(
            'ServiceType List Loaded: ${serviceList.map((s) => "${s.code}: ${s.name}").toList()}',
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
      log('Fetch ServiceType Exception: $e, stack: $stackTrace');
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

  List<String> getServiceNames() {
    return serviceList.map((s) => s.name.toString()).toSet().toList();
  }

  String? getServiceId(String name) {
    return serviceList
            .firstWhereOrNull((state) => state.name.toString() == name)
            ?.code ??
        '';
  }

  String? getServiceNameById(String serviceId) {
    return serviceList
        .firstWhereOrNull((state) => state.code == serviceId)
        ?.name
        .toString();
  }
}
