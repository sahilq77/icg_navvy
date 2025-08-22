import 'package:get/get.dart';
import 'package:icg_navy/utility/app_utility.dart';

import '../../utility/app_routes.dart';

class BottomNavigationController extends GetxController {
  RxInt selectedIndex = 0.obs;

  // Single declaration of routes, initialized based on userType
  late final List<String> routes;

  @override
  void onInit() {
    super.onInit();
    // Initialize routes based on userType
    routes = _getRoutesForUserType(AppUtility.userType);
    // Sync initial index with current route
    syncIndexWithRoute(Get.currentRoute);
    // Listen for route changes
    ever(Rx<String?>(Get.routing.current), (route) {
      if (route != null) {
        syncIndexWithRoute(route);
      }
    });
  }

  // Determine routes based on userType
  List<String> _getRoutesForUserType(String? userType) {
    switch (userType) {
      case "0":
        return [
          AppRoutes.home,
          AppRoutes.scheduleAppinmentAME,
          AppRoutes.scheduleAppinment,
          AppRoutes.myReportlist,
        ];
      case "1":
        return [
          AppRoutes.home,
          AppRoutes.pendingAppoinmentMedical,
          AppRoutes.notification,
          AppRoutes.logout,
        ];
      case "2":
        return [
          AppRoutes.home,
          AppRoutes.pendingAppoinmentAuth,
          AppRoutes.notification,
          AppRoutes.logout,
        ];
      default:
        // Fallback routes in case userType is invalid
        print('Invalid userType: $userType, defaulting to userType 0 routes');
        return [
          AppRoutes.home,
          AppRoutes.scheduleAppinmentAME,
          AppRoutes.scheduleAppinment,
          AppRoutes.myReportlist,
        ];
    }
  }

  void syncIndexWithRoute(String? route) {
    if (route == null) {
      print('Route is null, keeping current index: ${selectedIndex.value}');
      return;
    }
    final index = routes.indexOf(route);
    if (index != -1) {
      selectedIndex.value = index;
    } else {
      print(
        'Route $route not found in routes, keeping current index: ${selectedIndex.value}',
      );
    }
  }

  void changeTab(int index) {
    if (index < 0 || index >= routes.length) {
      print('Invalid index: $index');
      return;
    }
    if (index == 0) {
      selectedIndex.value = 0;
      Get.offAllNamed(routes[0]);
    } else if (selectedIndex.value != index) {
      selectedIndex.value = index;
      Get.offAllNamed(routes[index]);
    }
  }

  void goToHome() {
    selectedIndex.value = 0;
    Get.offAllNamed(AppRoutes.home);
  }

  Future<bool> onWillPop() async {
    if (Get.nestedKey(1)?.currentState?.canPop() ?? false) {
      Get.back(id: 1); // Pop within the current tab's stack
      return false; // Prevent app exit
    }
    if (selectedIndex.value != 0) {
      goToHome(); // Go to Home tab if not already there
      return false; // Prevent app exit
    }
    return true; // Allow app exit if on Home tab with no stack
  }
}
