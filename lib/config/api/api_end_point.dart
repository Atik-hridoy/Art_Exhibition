class ApiEndPoint {
  static const baseUrl = "http://10.10.7.102:5009/api/v1/";
  static const imageUrl = "http://10.10.7.102:5009";
  static const socketUrl = "http://10.10.7.102:5009";

  static const signUp = "/users"; // Saved ny Nasim
  static const verifyEmail = "auth/verify-email"; // Saved ny Nasim
  static const signIn = "auth/login"; // Saved ny Nasim
  static const forgotPassword = "auth/forget-password"; // Saved ny Nasim
  // static const verifyOtp = "users/verify-otp";
  static const resendOtp = "/auth/resend-otp"; // Saved ny Nasim
  static const resetPassword = "auth/reset-password"; // Saved ny Nasim
  static const changePassword = "users/change-password";
  static const user = "users";
  static const notifications = "Notifications";
  static const privacyPolicies = "privacy-policies";
  static const termsOfServices = "terms-and-conditions";
  static const chats = "chats";
  static const messages = "messages";

  //////////////  Art //////////////////
  static const featuresArt = 'arts';
  static const recommendedArt = 'arts/recommended';
  static const savedItem = 'save';
  static const category = 'category';
  static const exhibition = 'exhibition';
}
