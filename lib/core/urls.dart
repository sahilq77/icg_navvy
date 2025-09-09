class Networkutility {
  static String baseUrl =
      "https://aasha-demo.epps-erp.in/me/aasha/"; // base url first
  static String baseUrl2 = "https://icg.net.in/me/aasha/"; // base url second
  static String login = "${baseUrl + "investigation/v1/personal"}";
  static int loginApi = 1;
  static String getBloodGroup = "${baseUrl2 + "bloodGroup/v1"}";
  static int getBloodGroupApi = 2;
}
