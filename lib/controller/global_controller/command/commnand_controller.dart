import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icg_navy/model/global_model/service_details/get_service_details_response.dart';
import 'package:icg_navy/utility/app_utility.dart';
import '../../../model/global_model/rank/get_rank_response.dart';
import '../../../core/network/exceptions.dart';
import '../../../core/network/networkcall.dart';
import '../../../core/urls.dart';
import '../../../utility/app_colors.dart';

class CommandController extends GetxController {
  RxList<Command> commandList = <Command>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  RxString? selectedCommandVal;

  static CommandController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    // Defer fetching until context is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Get.context != null) {
        fetchCommand(context: Get.context!);
      }
    });
  }

  Future<void> fetchCommand({
    required BuildContext context,
    bool forceFetch = false,
  }) async {
    log("Command API call");
    if (!forceFetch && commandList.isNotEmpty) return;

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
        'Fetch Commands Response: ${response?.isNotEmpty == true ? response![0].toJson() : 'null'}',
      );

      if (response != null && response.isNotEmpty) {
        if (response[0].status == "Success") {
          commandList.value = response[0].data!.first.command as List<Command>;
          log(
            'Command List Loaded: ${commandList.map((s) => "${s.commandCode}: ${s.commandName}").toList()}',
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
      log('Fetch Commands Exception: $e, stack: $stackTrace');
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

  List<String> getCommandNames() {
    return commandList.map((s) => s.commandName.toString()).toSet().toList();
  }

  String? getCommandId(String commandName) {
    return commandList
            .firstWhereOrNull(
              (state) => state.commandName.toString() == commandName,
            )
            ?.commandCode ??
        '';
  }

  String? getCommandNameById(String commandId) {
    return commandList
        .firstWhereOrNull((state) => state.commandCode == commandId)
        ?.commandName
        .toString();
  }
}
