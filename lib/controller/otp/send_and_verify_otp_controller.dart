import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icg_navy/model/otp/get_send_otp_response.dart';

import '../../../core/network/exceptions.dart';
import '../../../core/network/networkcall.dart';
import '../../../core/urls.dart';
import '../../../utility/app_colors.dart';
import '../../../utility/app_routes.dart';

class SendAndVerifyOtpController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isLoadingV = true.obs;
  Future<void> sendOTP({
    required BuildContext? context,
    required String? username, //personalNumber
    required String? mobileNumber,
  }) async {
    try {
      final jsonBody = {
        "data": [
          {"userId": username, "mobileNo": mobileNumber},
        ],
      };

      isLoading.value = true;
      List<Object?>? list = await Networkcall().postMethod(
        Networkutility.genrateOtpApi,
        "https://aasha-demo.epps-erp.in/me/aasha/appointment/otp/genrate/v1",
        jsonEncode(jsonBody),
        Get.context!,
      );

      if (list != null && list.isNotEmpty) {
        List<GetSendOtpResponse> response = List.from(list);
        if (response[0].status == "Success") {
          Get.snackbar(
            'Success',
            'OTP sent successfully',
            backgroundColor: AppColors.success,
            colorText: Colors.white,
          );
          Get.toNamed(AppRoutes.verifyOtp);
          // Get.toNamed(
          //   fromRegistration ? AppRoutes.registerotp : AppRoutes.otp,
          //   arguments: fromRegistration ? argu : mobileNumber,
          // );
        } else if (response[0].status == "Failed") {
          // if (response[0].message.contains("Invalid mobile number format")) {

          // }
          Get.snackbar(
            'Error',
            'The mobile number format is incorrect,\nPlease try again.',
            backgroundColor: AppColors.error,
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          'Error',
          'No response from server',
          backgroundColor: AppColors.error,
          colorText: Colors.white,
        );
      }
    } on NoInternetException catch (e) {
      Get.snackbar(
        'Error',
        e.message,
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
    } on TimeoutException catch (e) {
      Get.snackbar(
        'Error',
        e.message,
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
    } on HttpException catch (e) {
      Get.snackbar(
        'Error',
        '${e.message} (Code: ${e.statusCode})',
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
    } on ParseException catch (e) {
      Get.snackbar(
        'Error',
        e.message,
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
    } catch (e) {
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

  Future<void> verifyOTP({
    required BuildContext? context,
    required String? username, //personalNumber
    required String? mobileNumber,
    required String? otp,
  }) async {
    try {
      final jsonBody = {
        "data": [
          {
            "userId": username,
            "mobileNo": "123456789",
            "serialNumber": 1234,
            "otp": otp,
          },
        ],
      };

      isLoading.value = true;
      List<Object?>? list = await Networkcall().postMethod(
        Networkutility.verifyOtpApi,
        "https://aasha-demo.epps-erp.in/me/aasha/appointment/otp/verify/v1",
        jsonEncode(jsonBody),
        Get.context!,
      );

      if (list != null && list.isNotEmpty) {
        List<GetSendOtpResponse> response = List.from(list);
        if (response[0].status == "Success") {
          Get.snackbar(
            'Success',
            'OTP sent successfully',
            backgroundColor: AppColors.success,
            colorText: Colors.white,
          );
        } else if (response[0].status == "Failed") {
          // if (response[0].message.contains("Invalid mobile number format")) {

          // }
          Get.snackbar(
            'Failed',
            'Incorrect OTP,\nPlease try again.',
            backgroundColor: AppColors.error,
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          'Error',
          'No response from server',
          backgroundColor: AppColors.error,
          colorText: Colors.white,
        );
      }
    } on NoInternetException catch (e) {
      Get.snackbar(
        'Error',
        e.message,
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
    } on TimeoutException catch (e) {
      Get.snackbar(
        'Error',
        e.message,
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
    } on HttpException catch (e) {
      Get.snackbar(
        'Error',
        '${e.message} (Code: ${e.statusCode})',
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
    } on ParseException catch (e) {
      Get.snackbar(
        'Error',
        e.message,
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
    } catch (e) {
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
}
