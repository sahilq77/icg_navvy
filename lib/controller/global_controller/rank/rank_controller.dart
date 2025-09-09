import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icg_navy/utility/app_utility.dart';
import '../../../model/global_model/rank/get_rank_response.dart';
import '../../../core/network/exceptions.dart';
import '../../../core/network/networkcall.dart';
import '../../../core/urls.dart';
import '../../../utility/app_colors.dart';

class RankController extends GetxController {
  RxList<Rank> rankList = <Rank>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  RxString? selectedRankVal;

  static RankController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    // Defer fetching until context is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Get.context != null) {
        fetchRank(context: Get.context!);
      }
    });
  }

  Future<void> fetchRank({
    required BuildContext context,
    bool forceFetch = false,
  }) async {
    log("Rank API call");
    if (!forceFetch && rankList.isNotEmpty) return;

    try {
      isLoading.value = true;
      errorMessage.value = '';

      List<GetRankResponse>? response =
          await Networkcall().getMethod(
                Networkutility.getRankApi,
                Networkutility.getRank +
                    "filter?personalNumber=${AppUtility.userID}&dataKey=RANK",
                Get.context!,
              )
              as List<GetRankResponse>?;

      log(
        'Fetch Ranks Response: ${response?.isNotEmpty == true ? response![0].toJson() : 'null'}',
      );

      if (response != null && response.isNotEmpty) {
        if (response[0].status == "Success") {
          rankList.value = response[0].data!.first.rank as List<Rank>;
          log(
            'Rank List Loaded: ${rankList.map((s) => "${s.rankCode}: ${s.rankName}").toList()}',
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
      log('Fetch Ranks Exception: $e, stack: $stackTrace');
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

  List<String> getRankNames() {
    return rankList.map((s) => s.rankName.toString()).toSet().toList();
  }

  String? getRankId(String rankName) {
    return rankList
            .firstWhereOrNull((state) => state.rankName.toString() == rankName)
            ?.rankCode ??
        '';
  }

  String? getRankNameById(String rankId) {
    return rankList
        .firstWhereOrNull((state) => state.rankCode == rankId)
        ?.rankName
        .toString();
  }
}
