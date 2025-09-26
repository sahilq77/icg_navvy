import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/network/exceptions.dart';
import '../../core/network/networkcall.dart';
import '../../core/urls.dart';
import '../../model/login/get_login_response.dart';
import '../../model/schedule_due_date/get_schedule_due_date_response.dart';
import '../../utility/app_colors.dart';
import '../../utility/app_routes.dart';
import '../../utility/app_utility.dart';

class ScheduleDueDateController extends GetxController {
  var dueDateData = <DueDateData>[].obs;
  var errorMessage = ''.obs;
  RxBool isLoading = true.obs;
  RxString imageLink = "".obs;
  RxString packageName = "".obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  // Method to set the selected user

  // Method to fetch user profile
  Future<void> getDueDate({
    required BuildContext context,
    bool isRefresh = false,
    required String rankCode,
    required String ameYear,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // final jsonBody = {
      //   "user_id": AppUtility.userID,
      //   "sector_id": AppUtility.sectorID,
      // };

      List<GetDueDateResponse>? response =
          (await Networkcall().getMethod(
                Networkutility.getScheduleDueDateApi,
                Networkutility.getScheduleDueDate +
                    "?rankCode=$rankCode&appointmentYear=$ameYear",

                Get.context!,
              ))
              as List<GetDueDateResponse>?;

      if (response != null && response.isNotEmpty) {
        if (response[0].status == "Success") {
          final users = response[0].data.first;
          dueDateData.value.clear();
          dueDateData.add(
            DueDateData(
              rankId: users.rankId,
              rankCode: users.rankCode,
              fromMonth: users.fromMonth,
              toMonth: users.toMonth,
              isActive: users.isActive,
              createdBy: users.createdBy,
              createdDate: users.createdDate,
              scheduledDueDate: users.scheduledDueDate,
            ),
          );
        } else {
          errorMessage.value =
              'Failed to load profile: ${response[0].status ?? 'Unknown error'}';
        }
      } else {
        errorMessage.value = 'No response from server';
      }
    } on NoInternetException catch (e) {
      errorMessage.value = e.message;
    } on TimeoutException catch (e) {
      errorMessage.value = e.message;
    } on HttpException catch (e) {
      errorMessage.value = '${e.message} (Code: ${e.statusCode})';
    } on ParseException catch (e) {
      errorMessage.value = e.message;
    } catch (e) {
      errorMessage.value = 'Unexpected error: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
