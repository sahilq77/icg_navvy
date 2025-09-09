import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/network/exceptions.dart';
import '../../core/network/networkcall.dart';
import '../../core/urls.dart';
import '../../model/login/get_login_response.dart';
import '../../utility/app_colors.dart';
import '../../utility/app_routes.dart';
import '../../utility/app_utility.dart';

class UserDetailsController extends GetxController {
  var userProfileList = <UserData>[].obs;
  var errorMessage = ''.obs;
  RxBool isLoading = true.obs;
  RxString imageLink = "".obs;
  RxString packageName = "".obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchUserProfile(
        context: Get.context!,
      ); // Fetch user profile on initialization
    });
  }

  // Method to set the selected user

  // Method to fetch user profile
  Future<void> fetchUserProfile({
    required BuildContext context,
    bool isRefresh = false,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      if (isRefresh) {
        userProfileList.clear(); // Clear existing data on refresh
      }

      // final jsonBody = {
      //   "user_id": AppUtility.userID,
      //   "sector_id": AppUtility.sectorID,
      // };

      List<GetLoginResponse>? response =
          (await Networkcall().getMethod(
                Networkutility.loginApi,
                Networkutility.login +
                    "/standards?personalNumber=${AppUtility.userID}&personalDetailsYn=1",

                Get.context!,
              ))
              as List<GetLoginResponse>?;

      if (response != null && response.isNotEmpty) {
        if (response[0].status == "Success") {
          final users = response[0].data;

          userProfileList.add(
            UserData(
              personnel: users!.first.personnel,
              documents: users!.first.documents,
              condonationDocument: users!.first.condonationDocument,
              finalObservation: users!.first.finalObservation,
              approverDetails: users!.first.approverDetails,
              peruserDetail: users!.first.peruserDetail,
              vaccineDetails: users!.first.vaccineDetails,
              petDetail: users!.first.petDetail,
              aviationObservationDetail: users!.first.aviationObservationDetail,
              marineObservationDetail: users!.first.marineObservationDetail,
              misc: users!.first.misc,
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
