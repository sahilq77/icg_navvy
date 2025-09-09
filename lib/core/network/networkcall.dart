import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:icg_navy/core/network/exceptions.dart';
import '../../model/global_model/blood_group/get_blood_group_response.dart';
import '../../model/global_model/branch/get_branch_response.dart';
import '../../model/global_model/medical_category/get_medical_category_response.dart';
import '../../model/global_model/rank/get_rank_response.dart';
import '../../model/global_model/service/get_service_response.dart';
import '../../model/global_model/service_details/get_service_details_response.dart';
import '../../model/global_model/unit/get_unit_response.dart';
import '../../model/inward_list/get_delete_inward_response.dart';
import '../../model/inward_list/get_view_notes_response.dart';
import '../../model/login/get_login_response.dart';
import '../../model/inward_list/get_inward_list_response.dart';

import '../../utility/app_routes.dart';
import '../../utility/customdesign/connctivityservice.dart';

class Networkcall {
  final ConnectivityService _connectivityService =
      Get.find<ConnectivityService>();
  static GetSnackBar? _slowInternetSnackBar;
  static const int _minResponseTimeMs =
      3000; // Threshold for slow internet (3s)
  static bool _isNavigatingToNoInternet = false; // Prevent multiple navigations

  Future<List<Object?>?> postMethod(
    int requestCode,
    String url,
    String body,
    BuildContext context,
  ) async {
    try {
      // Check connectivity with retries
      final isConnected = await _connectivityService.checkConnectivity();
      if (!isConnected) {
        await _navigateToNoInternet();
        return null;
      }

      // Start measuring response time
      final stopwatch = Stopwatch()..start();

      // Make POST request with timeout
      var response = await http
          .post(
            Uri.parse(url),
            headers: {'Content-Type': 'application/json'},
            body: body.isEmpty ? null : body,
          )
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              throw TimeoutException('Request timed out. Please try again.');
            },
          );

      // Stop measuring response time
      stopwatch.stop();
      final responseTimeMs = stopwatch.elapsedMilliseconds;

      // Handle slow internet
      _handleSlowInternet(responseTimeMs);

      var data = response.body;
      if (response.statusCode == 200) {
        log("url : $url \n Request body : $body \n Response : $data");

        // Wrap response in [] for consistency
        String str = "[${response.body}]";

        switch (requestCode) {
          case 1:
            final login = getLoginResponseFromJson(str);
            return login;
          case 2:
            final forgotPassword = getLoginResponseFromJson(str);
            return forgotPassword;
          // case 3:
          //   final getCompany = getCompanyResponseFromJson(str);
          //   return getCompany;
          // case 4:
          //   final getDivision = getDivisonResponseFromJson(str);
          //   return getDivision;
          // case 5:
          //   final getTransport = getAllTrasnsportResponseFromJson(str);
          //   return getTransport;
          // case 6:
          //   final getCustomers = getCustomersResponseFromJson(str);
          //   return getCustomers;

          default:
            log("Invalid request code: $requestCode");
            throw ParseException('Unhandled request code: $requestCode');
        }
      } else {
        log("url : $url \n Request body : $data");
        throw HttpException(
          'Server error: ${response.statusCode}',
          response.statusCode,
        );
      }
    } on NoInternetException catch (e) {
      log("url : $url \n Request body : $body \n Response : $e");
      await _navigateToNoInternet();
      return null;
    } on TimeoutException catch (e) {
      log("url : $url \n Request body : $body \n Response : $e");
      Get.snackbar(
        'Request Timed Out',
        'The server took too long to respond. Please try again.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      return null;
    } on HttpException catch (e) {
      log("url : $url \n Request body : $body \n Response : $e");
      return null;
    } on SocketException catch (e) {
      log("url : $url \n Request body : $body \n Response : $e");
      await _navigateToNoInternet();
      return null;
    } catch (e) {
      log("url : $url \n Request body : $body \n Response : $e");
      return null;
    }
  }

  Future<List<Object?>?> postFormDataMethod(
    int requestCode,
    String url,
    Map<String, String> formData,
    BuildContext context,
  ) async {
    try {
      // Check connectivity with retries
      final isConnected = await _connectivityService.checkConnectivity();
      if (!isConnected) {
        await _navigateToNoInternet();
        return null;
      }

      // Start measuring response time
      final stopwatch = Stopwatch()..start();

      // Create FormData
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers['Content-Type'] = 'multipart/form-data';
      formData.forEach((key, value) {
        request.fields[key] = value;
      });

      // Make POST request with timeout
      var streamedResponse = await request.send().timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw TimeoutException('Request timed out. Please try again.');
        },
      );

      var response = await http.Response.fromStream(streamedResponse);

      // Stop measuring response time
      stopwatch.stop();
      final responseTimeMs = stopwatch.elapsedMilliseconds;

      // Handle slow internet
      _handleSlowInternet(responseTimeMs);

      var data = response.body;
      if (response.statusCode == 200) {
        log("url : $url \n Request body : $formData \n Response : $data");

        // Wrap response in [] for consistency
        String str = "[${response.body}]";

        switch (requestCode) {
          // case 9:
          //   final addInward = getAddInwardResponseFromJson(str);
          //   return addInward;

          default:
            log("Invalid request code: $requestCode");
            throw ParseException('Unhandled request code: $requestCode');
        }
      } else {
        log("url : $url \n Request body : $formData \n Response : $data");
        throw HttpException(
          'Server error: ${response.statusCode}',
          response.statusCode,
        );
      }
    } on NoInternetException catch (e) {
      log("url : $url \n Request body : $formData \n Response : $e");
      await _navigateToNoInternet();
      return null;
    } on TimeoutException catch (e) {
      log("url : $url \n Request body : $formData \n Response : $e");
      Get.snackbar(
        'Request Timed Out',
        'The server took too long to respond. Please try again.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      return null;
    } on HttpException catch (e) {
      log("url : $url \n Request body : $formData \n Response : $e");
      return null;
    } on SocketException catch (e) {
      log("url : $url \n Request body : $formData \n Response : $e");
      await _navigateToNoInternet();
      return null;
    } catch (e) {
      log("url : $url \n Request body : $formData \n Response : $e");
      return null;
    }
  }

  Future<List<Object?>?> getMethod(
    int requestCode,
    String url,
    BuildContext context,
  ) async {
    try {
      // Check connectivity with retries
      final isConnected = await _connectivityService.checkConnectivity();
      if (!isConnected) {
        await _navigateToNoInternet();
        return null;
      }

      // Start measuring response time
      final stopwatch = Stopwatch()..start();

      // Make GET request with timeout
      var response = await http
          .get(Uri.parse(url))
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              throw TimeoutException('Request timed out. Please try again.');
            },
          );

      // Stop measuring response time
      stopwatch.stop();
      final responseTimeMs = stopwatch.elapsedMilliseconds;

      // Handle slow internet
      _handleSlowInternet(responseTimeMs);

      var data = response.body;
      log(url);
      if (response.statusCode == 200) {
        log("url : $url \n Response : $data");
        String str = "[${response.body}]";
        switch (requestCode) {
          case 1:
            final login = getLoginResponseFromJson(str);
            return login;
          case 2:
            final getBloodGroup = getBloodGroupResponseFromJson(str);
            return getBloodGroup;
          case 3:
            final getRank = getRankResponseFromJson(str);
            return getRank;
          case 4:
            final getServiceDetails = getServiceDetailsResponseFromJson(str);
            return getServiceDetails;
          case 5:
            final getUnit = getUnitResponseFromJson(str);
            return getUnit;
          case 6:
            final getBranch = getBranchResponseFromJson(str);
            return getBranch;
          case 7:
            final getService = getServiceResponseFromJson(str);
            return getService;
          case 8:
            final getMedicalCategory = getMedicalCategoryResponseFromJson(str);
            return getMedicalCategory;

          default:
            log("Invalid request code: $requestCode");
            throw ParseException('Unhandled request code: $requestCode');
        }
      } else {
        log("url : $url \n Response : $data");
        throw HttpException(
          'Server error: ${response.statusCode}',
          response.statusCode,
        );
      }
    } on NoInternetException catch (e) {
      log("url : $url \n Response : $e");
      await _navigateToNoInternet();
      return null;
    } on TimeoutException catch (e) {
      log("url : $url \n Response : $e");
      Get.snackbar(
        'Request Timed Out',
        'The server took too long to respond. Please try again.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      return null;
    } on HttpException catch (e) {
      log("url : $url \n Response : $e");
      return null;
    } on SocketException catch (e) {
      log("url : $url \n Response : $e");
      await _navigateToNoInternet();
      return null;
    } catch (e) {
      log("url : $url \n Response : $e");
      return null;
    }
  }

  Future<void> _navigateToNoInternet() async {
    if (!_isNavigatingToNoInternet &&
        Get.currentRoute != AppRoutes.noInternet) {
      _isNavigatingToNoInternet = true;
      // Double-check connectivity before navigating
      final isConnected = await _connectivityService.checkConnectivity();
      if (!isConnected) {
        await Get.offNamed(AppRoutes.noInternet);
      }
      // Reset flag after a delay
      await Future.delayed(const Duration(milliseconds: 500));
      _isNavigatingToNoInternet = false;
    }
  }

  void _handleSlowInternet(int responseTimeMs) {
    if (responseTimeMs > _minResponseTimeMs) {
      // Show slow internet snackbar if not already shown
      if (_slowInternetSnackBar == null || !Get.isSnackbarOpen) {
        _slowInternetSnackBar = const GetSnackBar(
          message:
              'Slow internet connection detected. Please check your network.',
          duration: Duration(days: 1), // Persistent until closed
          backgroundColor: Colors.orange,
          snackPosition: SnackPosition.TOP,
          isDismissible: false,
          margin: EdgeInsets.all(10),
          borderRadius: 8,
        );
        Get.showSnackbar(_slowInternetSnackBar!);
      }
    } else {
      // Close slow internet snackbar if connection improves
      if (_slowInternetSnackBar != null && Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
        _slowInternetSnackBar = null;
      }
    }
  }
}
