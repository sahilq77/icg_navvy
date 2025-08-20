import 'package:get/get.dart';


import '../view/forgot_password/enter_new_password_screen.dart';
import '../view/forgot_password/forgot_password_screen.dart';
import '../view/home/home_screen.dart';
import '../view/login/login_screen.dart';
import '../view/splash/splash_screen.dart';
import '../view/view_image/view_images_screen.dart';
import '../view/welcome/welcome_screen.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String forgotpassword = '/forgotpassword';
  static const String newspassword = '/newpassword';
  static const String home = '/home';
  static const String addinward = '/addinward';
  static const String inwardlist = '/inwardlist';
  static const String inwarddetail = '/inwarddetail';
  static const String inwardverification = '/inward_vrification';
  static const String addoutward = '/add_outward';
  static const String outwardList = '/outward_list';
  static const String outwarddetail = '/outward_detail';
  static const String pickedbyoutward = '/pickedby_outward';
  static const String pickedbyoutwarddetail = '/pickedby_outward_detail';
  static const String checkedbyoutward = '/checkedby_outward';
  static const String checkedbyoutwarddetail = '/checkedby_outward_detail';
  static const String receiptform = '/receipt_form';
  static const String packedbyoutward = '/packedby_outward';
  static const String packedbyoutwarddetail = '/packedby_outward_detail';
  static const String stockmovement = '/stock_movement';
  static const String outwardmovement = '/outward_movement_form';
  static const String completedorderlist = '/completed_order_list';
  static const String completedorderdetail = '/completed_order_detail';
  static const String noInternet = '/nointernet';
  static const String viewpdf = '/view_pdf';
  static const String editOutward = '/edit_outward';
  static const String viewImage = '/view_image';
  static const String viewNote = '/view_note';
  static const String pendingOverdue = '/pending_overdue';
  static const String overdueDetails = '/pending_overdue_details';
  static const String editInward = '/edit_inward';

  static final routes = [
    GetPage(
      name: splash,
      page: () => SplashScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: login,
      page: () => LoginScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: welcome,
      page: () => WelcomeScreen(),
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: forgotpassword,
      page: () => ForgotPasswordScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: newspassword,
      page: () => EnterNewPasswordScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: home,
      page: () => HomeScreen(),
      transition: Transition.fadeIn,
    ),
   
  ];
}
