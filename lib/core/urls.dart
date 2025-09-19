class Networkutility {
  static String baseUrl =
      "https://aasha-demo.epps-erp.in/me/aasha/"; // base url first
  static String baseUrl2 = "https://icg.net.in/me/aasha/"; // base url second
  static String login = "${baseUrl + "investigation/v1/personal"}";
  static int loginApi = 1;
  static String getBloodGroup = "${baseUrl2 + "bloodGroup/v1"}";
  static int getBloodGroupApi = 2;
  static String getRank = "${baseUrl2 + "v1/idName/"}";
  static int getRankApi = 3;
  static String getServiceDetails = "${baseUrl2 + "v1/idName"}";
  static int getServiceDetailsApi = 4;
  static String getUnit = "${baseUrl + "v1/idName"}";
  static int getUnitApi = 5;
  static String getBranch = "${baseUrl + "appointment/v1/branches"}";
  static int getBranchApi = 6;
  static String getService = "${baseUrl + "v1/idName?serviceTypeYn=1"}";
  static int getServiceApi = 7;
  static String getMedicalCategory =
      "${baseUrl2 + "v1/idName/filter?dataKey=MEDCAT"}";
  static int getMedicalCategoryApi = 8;
  static String getFinancialYear = "${baseUrl + "financial/year/v1"}";
  static int getFinancialYearApi = 9;
  static String loginUsingOtp = "${baseUrl + "appointment/otp/genrate/v1"}";
  static int loginUsingOtpApi = 10;
}
