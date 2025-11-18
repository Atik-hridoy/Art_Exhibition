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
  static const events = 'events';
  static const following = 'following';
  static const unFollowing = 'following/unfollow';
  static const saveToggle = 'save/toggle';
  static const users = 'users';
  static const myList = 'art-collection';


//  ==================================== hridoy ==================================

  // profile 

  static const getProfile = 'users/profile';

  // get all users. using on the populer artist view 

  static const getAllUsers = 'users';




  //  learning matrials 


  static const  getLearningMatrials = 'learning';
  static const  getLearningDetails = 'learning';
  static const postLearningMatrials = 'lessons';

  static const  addCourse = 'learning';

  static const String uoloadVideo = 'upload';
  


}
