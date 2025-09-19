import 'package:get/get.dart';

import '../view/appoinment/appoinment_history_screen.dart';
import '../view/apppointment_type/apppointment_type_screen.dart';
import '../view/approving_authority/approved_appoinments/aprroved_appoinment/aprroved_appoinment_auth_screen.dart';
import '../view/approving_authority/pending_appoinments/pending_appoinment_autho_screen.dart';
import '../view/approving_authority/processed_appoinments/processed_appoinment_auth_screen.dart';
import '../view/forgot_password/enter_new_password_screen.dart';
import '../view/forgot_password/forgot_password_screen.dart';
import '../view/home/home_screen.dart';
import '../view/login/login_screen.dart';
import '../view/logout/logout_screen.dart';
import '../view/medical_officer/approved_appoinments/approved_appoinment_screen.dart';
import '../view/medical_officer/pending_appoinments/pending_appoinment_medical_screen.dart';
import '../view/medical_officer/processed_appoinments/proceessed_appoinmet_medical_screen.dart';
import '../view/my_report/my_report_screen.dart';
import '../view/notification/notification_screen.dart';
import '../view/otp/otp_verify_screen.dart';
import '../view/schedule_appoinment/schedule_appoinment_screen.dart';
import '../view/schedule_appoinment/token/token_screen.dart';
import '../view/schedule_appoinment_ame/confirmation_screen.dart';
import '../view/schedule_appoinment_ame/schedule_appoinment_ame_review_screen.dart';
import '../view/schedule_appoinment_ame/schedule_appoinment_ame_screen.dart';
import '../view/splash/splash_screen.dart';

import '../view/welcome/welcome_screen.dart' hide LoginScreen;

class AppRoutes {
  static const String splash = '/splash';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String forgotpassword = '/forgotpassword';
  static const String newspassword = '/newpassword';
  static const String home = '/home';
  static const String appoinmentType = '/appoinment-type';
  static const String scheduleAppinment = '/schedule-appinment';
  static const String scheduleAppinmentAME = '/schedule-appinment-AME';
  static const String scheduleAppinmentAMEReview =
      '/schedule-appinment-AME-Review';
  static const String tokenSuccess = '/token-success';
  static const String confirmtionScreen = '/confirmation-success';

  static const String appoinmentHistory = '/appoinment-history';
  static const String myReportlist = '/myReport-list';

  static const String notification = '/notification';
  static const String pendingAppoinmentMedical = '/pending-appoinment-medical';

  static const String proceessedAppoinmetMedical =
      '/proceessed-appoinmet-medical';
  static const String approvedAppoinmentMedical = '/approved-appoinmet-medical';
  static const String pendingAppoinmentAuth = '/pending-appoinment-auth';
  static const String proceessedAppoinmetAuth = '/proceessed-appoinmet-auth';
  static const String approvedAppoinmentAuth = '/approved-appoinmet-auth';

  static const String logout = '/log-out';
  static const String verifyOtp = '/verify-otp';
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
    GetPage(
      name: appoinmentType,
      page: () => ApppointmentTypeScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: scheduleAppinment,
      page: () => ScheduleAppointmentScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: scheduleAppinmentAME,
      page: () => ScheduleAppointmentAmeScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: scheduleAppinmentAMEReview,
      page: () => ScheduleAppointmentAmeReviewScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: tokenSuccess,
      page: () => TokenScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: confirmtionScreen,
      page: () => ConfirmationScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: appoinmentHistory,
      page: () => AppointmentHistoryScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: myReportlist,
      page: () => MyReportScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: notification,
      page: () => NotificationScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: pendingAppoinmentMedical,
      page: () => PendingAppoinmentMedicalScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: proceessedAppoinmetMedical,
      page: () => ProceessedAppoinmetMedicalScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: approvedAppoinmentMedical,
      page: () => ApprovedAppoinmentScreen(),
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: pendingAppoinmentAuth,
      page: () => PendingAppoinmentAuthoScreen(),
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: proceessedAppoinmetAuth,
      page: () => ProcessedAppoinmentAuthScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: approvedAppoinmentAuth,
      page: () => AprrovedAppoinmentAuthScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: logout,
      page: () => LogoutScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: verifyOtp,
      page: () => OtpVerificationScreen(),
      transition: Transition.fadeIn,
    ),
  ];
}
