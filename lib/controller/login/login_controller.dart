import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/network/exceptions.dart';
import '../../core/network/networkcall.dart';

import '../../core/urls.dart';
import '../../model/login/get_login_response.dart';

import '../../utility/app_colors.dart';
import '../../utility/app_routes.dart';
import '../../utility/app_utility.dart';

class LoginController extends GetxController {
  // final emailController = TextEditingController();
  // final passwordController = TextEditingController();
  var isPasswordVisible = false.obs;
  var isRememberMe = false.obs;

  RxBool isLoading = true.obs;

  Future<void> login({
    BuildContext? context,
    required String? username,
    // required String? password,
    // required String? token,
  }) async {
    try {
      final jsonBody = {
        // "user_name": emailController.text.toString(),
        // "password": passwordController.text.toString(),
      };

      isLoading.value = true;
      // ProgressDialog.showProgressDialog(context);
      // final jsonBody = Createjson().createJsonForLogin(
      //   mobileNumber.value,
      //   'dummy_push_token', // Replace with actual push token
      //   'dummy_device_id', // Replace with actual device ID
      //   password.value,
      // );
      List<Object?>? list = await Networkcall().getMethod(
        Networkutility.loginApi,
        Networkutility.login +
            "/standards?personalNumber=$username&personalDetailsYn=1",

        Get.context!,
      );

      if (list != null && list.isNotEmpty) {
        List<GetLoginResponse> response = List.from(list);
        log(response[0].data!.first.personnel!.fullName.toString());
        if (response[0].status == "Success") {
          final user = response[0].data!.first.personnel;
          // bool isAdmin = user!.loginType == "1";

          await AppUtility.setUserInfo(
            user!.fullName.toString(),
            "",
            "0",
            user.personalNumber.toString(),
            true,
          );
          // Fetch privileges for non-admin users

          Get.snackbar(
            'Success',
            'Login successful!',
            backgroundColor: AppColors.green,
            colorText: Colors.white,
          );
          Get.offNamed(AppRoutes.home);
          // Get.offNamed('/dashboard');
        } else if (response[0].status == "false") {
          Get.snackbar(
            'Failed',
            "Your user name or password is incorrect.\nPlease try again.",
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
      Get.back();
      Get.snackbar(
        'Error',
        e.message,
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
    } on TimeoutException catch (e) {
      Get.back();
      Get.snackbar(
        'Error',
        e.message,
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
    } on HttpException catch (e) {
      Get.back();
      Get.snackbar(
        'Error',
        '${e.message} (Code: ${e.statusCode})',
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
    } on ParseException catch (e) {
      Get.back();
      Get.snackbar(
        'Error',
        e.message,
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.back();
      Get.snackbar(
        'Error',
        'Unexpected errorColor: $e',
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
