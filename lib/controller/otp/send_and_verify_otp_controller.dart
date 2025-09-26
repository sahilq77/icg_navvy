import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icg_navy/model/otp/get_send_otp_response.dart';
import 'package:icg_navy/model/otp/get_verify_otp_response.dart';
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
    required String? username, // personalNumber
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
          Get.toNamed(
            AppRoutes.verifyOtp,
            arguments: {'username': username, 'mobileNumber': mobileNumber},
          );
        } else if (response[0].status == "Failed") {
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
    required String? username, // personalNumber
    required String? mobileNumber,
    required String? otp,
  }) async {
    try {
      final jsonBody = {
        "data": [
          {
            "userId": username,
            "mobileNo": mobileNumber,
            "serialNumber": 1234, // Adjust as per your API requirements
            "otp": otp,
          },
        ],
      };

      isLoadingV.value = true;
      List<Object?>? list = await Networkcall().postMethod(
        Networkutility.verifyOtpApi,
        "https://aasha-demo.epps-erp.in/me/aasha/appointment/otp/verify/v1",
        jsonEncode(jsonBody),
        context!,
      );

      if (list != null && list.isNotEmpty) {
        List<GetVerifyOtpResponse> response = List.from(list);
        if (response[0].status == "Success") {
          Get.snackbar(
            'Success',
            'OTP verified successfully',
            backgroundColor: AppColors.success,
            colorText: Colors.white,
          );
          Get.toNamed(AppRoutes.scheduleAppinmentAMEReview);
        } else if (response[0].status == "Failed") {
          Get.snackbar(
            'Failed',
            'Incorrect OTP, Please try again.',
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
      isLoadingV.value = false;
    }
  }

  // Future<bool> handleOtpVerification({
  //   required String otp,
  //   required String? username,
  //   required String? mobileNumber,
  // }) async {
  //  if (otp.length==6) {

  //     try {
  //       final jsonBody = {
  //         "data": [
  //           {
  //             "userId": username,
  //             "mobileNo": mobileNumber,
  //             "serialNumber": 1234, // Adjust as per your API requirements
  //             "otp": otp,
  //           },
  //         ],
  //       };

  //       isLoading.value = true;
  //       List<Object?>? list = await Networkcall().postMethod(
  //         Networkutility.verifyOtpApi,
  //         "https://aasha-demo.epps-erp.in/me/aasha/appointment/otp/verify/v1",
  //         jsonEncode(jsonBody),
  //         Get.context!,
  //       );

  //       if (list != null && list.isNotEmpty) {
  //         List<GetVerifyOtpResponse> response = List.from(list);
  //         if (response[0].status == "Success") {

  //           Get.snackbar(
  //             'Success',
  //             'OTP Verified Successfully!',
  //             backgroundColor: AppColors.success,
  //             colorText: Colors.white,
  //           );

  //           return true; // Indicate successful verification

  //         } else {
  //           Get.snackbar(
  //             'Error',
  //             'Invalid OTP. Please try again.',
  //             backgroundColor: AppColors.error,
  //             colorText: Colors.white,
  //           );
  //           return false; // Indicate failed verification
  //         }
  //       } else {
  //         Get.snackbar(
  //           'Error',
  //           'No response from server',
  //           backgroundColor: AppColors.error,
  //           colorText: Colors.white,
  //         );
  //         return false;
  //       }
  //     } on NoInternetException catch (e) {
  //       Get.snackbar(
  //         'Error',
  //         e.message,
  //         backgroundColor: AppColors.error,
  //         colorText: Colors.white,
  //       );
  //       return false;
  //     } on TimeoutException catch (e) {
  //       Get.snackbar(
  //         'Error',
  //         e.message,
  //         backgroundColor: AppColors.error,
  //         colorText: Colors.white,
  //       );
  //       return false;
  //     } on HttpException catch (e) {
  //       Get.snackbar(
  //         'Error',
  //         '${e.message} (Code: ${e.statusCode})',
  //         backgroundColor: AppColors.error,
  //         colorText: Colors.white,
  //       );
  //       return false;
  //     } on ParseException catch (e) {
  //       Get.snackbar(
  //         'Error',
  //         e.message,
  //         backgroundColor: AppColors.error,
  //         colorText: Colors.white,
  //       );
  //       return false;
  //     } catch (e) {
  //       Get.snackbar(
  //         'Error',
  //         'Unexpected error: $e',
  //         backgroundColor: AppColors.error,
  //         colorText: Colors.white,
  //       );
  //       return false;
  //     } finally {
  //       isLoading.value = false;
  //     }
  //   } else {
  //     Get.snackbar(
  //       'Error',
  //       'Invalid OTP. Please enter a 6-digit OTP.',
  //       backgroundColor: AppColors.error,
  //       colorText: Colors.white,
  //     );
  //     return false;
  //   }
  // }
}
