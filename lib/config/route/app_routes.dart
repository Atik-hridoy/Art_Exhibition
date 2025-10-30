import 'package:get/get.dart';
import 'package:tasaned_project/features/another_screens/art_details/presentation/screens/art_details_screen.dart';
import 'package:tasaned_project/features/another_screens/art_details/presentation/screens/check_out_screen.dart';
import 'package:tasaned_project/features/another_screens/art_details/presentation/screens/payment_confirmation_screen.dart';
import 'package:tasaned_project/features/another_screens/art_details/presentation/screens/offer_submitted_screen.dart';
import 'package:tasaned_project/features/another_screens/artist_details/presentation/screens/artist_details_screen.dart';
import 'package:tasaned_project/features/another_screens/category/presentation/screens/category_Screen.dart';
import 'package:tasaned_project/features/another_screens/create_new_art/presentation/screens/create_art_work_screen.dart';
import 'package:tasaned_project/features/another_screens/create_new_event/presentation/screens/create_new_event_ticket_booking_screen.dart';
import 'package:tasaned_project/features/another_screens/create_new_exhibition/presentation/screens/create_new_exhibition_screen.dart';
import 'package:tasaned_project/features/another_screens/create_new_exhibition/presentation/screens/create_new_exhibition_gallery_screen.dart';
import 'package:tasaned_project/features/another_screens/create_new_exhibition/presentation/screens/create_new_exhibition_feature_artist_screen.dart';
import 'package:tasaned_project/features/another_screens/create_new_exhibition/presentation/screens/create_new_exhibition_ticket_booking_screen.dart';
import 'package:tasaned_project/features/another_screens/create_new_exhibition/presentation/screens/nasim/create_exibition_screen.dart';
import 'package:tasaned_project/features/another_screens/drawer_screens/presentation/screens/order_history_screen.dart';
import 'package:tasaned_project/features/another_screens/event_details/presentation/screens/event_details_screen.dart';
import 'package:tasaned_project/features/another_screens/my_collection/presentation/screens/my_collections_screen.dart';
import 'package:tasaned_project/features/another_screens/drawer_screens/presentation/screens/saved_screen.dart';
import 'package:tasaned_project/features/another_screens/drawer_screens/presentation/screens/followers_screen.dart';
import 'package:tasaned_project/features/another_screens/drawer_screens/presentation/screens/following_screen.dart';
import 'package:tasaned_project/features/another_screens/exhibition_details/presentation/screens/exhibition_details_screen.dart';
import 'package:tasaned_project/features/another_screens/learn_grow/presentation/screens/learn_and_grow_screen.dart';
import 'package:tasaned_project/features/another_screens/drawer_screens/presentation/screens/my_listing_screen.dart';
import 'package:tasaned_project/features/another_screens/learning_materials_details/presentation/screens/learnig_metarial_video_screen.dart';
import 'package:tasaned_project/features/another_screens/learning_materials_details/presentation/screens/learning_materials_details_screen.dart';
import 'package:tasaned_project/features/another_screens/my_courses/presentation/screens/my_courses_details_screen.dart';
import 'package:tasaned_project/features/another_screens/my_courses/presentation/screens/my_courses_screen.dart';
import 'package:tasaned_project/features/another_screens/my_courses/presentation/screens/my_courses_video_screen.dart';
import 'package:tasaned_project/features/another_screens/my_courses/presentation/screens/upload_new_lesson_screen.dart';
import 'package:tasaned_project/features/another_screens/my_event/presentation/screens/my_event_screen.dart';
import 'package:tasaned_project/features/another_screens/my_exhibitions/presentation/screens/my_exhibitions_screen.dart';
import 'package:tasaned_project/features/another_screens/my_listing_screen/presentation/screens/edit_art_work_screen.dart';
import 'package:tasaned_project/features/another_screens/my_listing_screen/presentation/screens/my_list_screen.dart';
import 'package:tasaned_project/features/another_screens/user_home/presentation/screens/feature_arts_screen.dart';
import 'package:tasaned_project/features/another_screens/user_home/presentation/screens/home_screen.dart';
import 'package:tasaned_project/features/another_screens/user_home/presentation/screens/popular_artist_screen.dart';
import 'package:tasaned_project/features/another_screens/user_home/presentation/screens/up_comming_event.dart';
import 'package:tasaned_project/features/another_screens/user_home/presentation/screens/upcomming_exhibition_screen.dart';
import 'package:tasaned_project/features/another_screens/user_home/presentation/screens/search_screen.dart';
import 'package:tasaned_project/features/another_screens/user_resel/presentation/screens/user_resel_screen.dart';
import 'package:tasaned_project/features/another_screens/visitor_order_history/presentations/screens/visitor_order_history_screen.dart';
import 'package:tasaned_project/features/profile/presentation/screen/transantion_screen.dart';
import '../../features/another_screens/nunny_booking/presentation/screens/nunny_booking_screen.dart';
import '../../features/another_screens/parent_booking/presentation/screens/parent_booking_screen.dart';
import '../../features/another_screens/user_home/presentation/screens/learning_metarial_screen.dart';
import '../../features/auth/change_password/presentation/screen/change_password_screen.dart';
import '../../features/auth/forgot password/presentation/screen/create_password.dart';
import '../../features/auth/forgot password/presentation/screen/forgot_password.dart';
import '../../features/auth/forgot password/presentation/screen/verify_screen.dart';
import '../../features/auth/sign in/presentation/screen/sign_in_screen.dart';
import '../../features/auth/sign up/presentation/screen/sign_up_screen.dart';
import '../../features/auth/sign up/presentation/screen/verify_user.dart';
import '../../features/auth/forgot password/presentation/screen/password_updated_screen.dart';
import '../../features/auth/sign up/presentation/screen/account_verified_screen.dart';
import '../../features/message/presentation/screen/chat_screen.dart';
import '../../features/message/presentation/screen/message_screen.dart';
import '../../features/notifications/presentation/screen/notifications_screen.dart';
import '../../features/onboarding_screen/screens/onboarding_screen.dart';
import '../../features/onboarding_screen/screens/welcome_screen.dart';
import '../../features/onboarding_screen/screens/choose_role_screen.dart';
import '../../features/profile/presentation/screen/edit_profile.dart';
import '../../features/profile/presentation/screen/notification_settings.dart';
import '../../features/profile/presentation/screen/profile_screen.dart';
import '../../features/setting/presentation/screen/about_us_screen.dart';
import '../../features/setting/presentation/screen/help_and_support_screen.dart';
import '../../features/setting/presentation/screen/privacy_policy_screen.dart';
import '../../features/setting/presentation/screen/setting_screen.dart';
import '../../features/setting/presentation/screen/terms_of_services_screen.dart';
import '../../features/splash/splash_screen.dart';
import 'package:tasaned_project/features/another_screens/create_new_event/presentation/screens/create_new_event_screen.dart';
import 'package:tasaned_project/features/another_screens/create_new_event/presentation/screens/create_new_event_gallery_screen.dart';

class AppRoutes {
  static const String test = "/test_screen.dart";
  static const String splash = "/splash_screen.dart";
  static const String onboarding = "/onboarding_screen.dart";
  static const String welcome = "/welcome_screen.dart";
  static const String chooseRole = "/choose_role_screen.dart";
  static const String signUp = "/sign_up_screen.dart";
  static const String verifyUser = "/verify_user.dart";
  static const String signIn = "/sign_in_screen.dart";
  static const String forgotPassword = "/forgot_password.dart";
  static const String verifyEmail = "/verify_screen.dart";
  static const String createPassword = "/create_password.dart";
  static const String passwordUpdated = "/password_updated.dart";
  static const String changePassword = "/change_password_screen.dart";
  static const String notifications = "/notifications_screen.dart";
  static const String chat = "/chat_screen.dart";
  static const String message = "/message_screen.dart";
  static const String profile = "/profile_screen.dart";
  static const String editProfile = "/edit_profile.dart";
  static const String privacyPolicy = "/privacy_policy_screen.dart";
  static const String termsOfServices = "/terms_of_services_screen.dart";
  static const String setting = "/setting_screen.dart";
  static const String onboardingTwoScreen = "/onboardingTwoScreen.dart";
  static const String onboardingThreeScreen = "/onboardingThreeScreen.dart";
  static const String mamaCareScreen = "/mamaCareScreen.dart";
  static const String accountVerifiedScreen = "/account_verified_screen.dart";
  static const String addPhotoScreen = "/add_photo_screen.dart";
  static const String parentHomeScreen = "/parent_home.dart";
  static const String parentBookingScreen = "/parentBookingScreen.dart";
  static const String savedScreen = "/savedScreen.dart";
  static const String children = "/children.dart";
  static const String nunnySeeAllScreen = "/nunnySeeAllScreen.dart";
  static const String nunnyDetailsScreen = "/nunnyDetailsScreen.dart";
  static const String requestBookingScreen = "/requestBookingScreen.dart";
  static const String addChildrenScreen = "/addChildrenScreen.dart";
  static const String editChildrenScreen = "/editChildrenScreen.dart";
  static const String notificationSettings = "/notificationSettings.dart";
  static const String helpAndSupportScreen = "/helpAndSupportScreen.dart";
  static const String aboutUsScreen = "/aboutUsScreen.dart";
  static const String nunnyBookingScreen = "/nunnyBookingScreen.dart";
  static const String nunnHomeScreen = "/nunnHomeScreen.dart";
  static const String onGoingScreen = "/onGoingScreen.dart";
  static const String upCommingScreen = "/upCommingScreen.dart";
  static const String galleryScreen = "/galleryScreen.dart";
  static const String addPhotoGallery = "/addPhotoGallery.dart";
  static const String nunnyBookingDetailsScreen = "/NunnyBookingDetailsScreen.dart";
  static const String certificationsExperienceScreen =
      "/certificationsExperienceScreen.dart";
  static const String preferenceScreen = "/preferenceScreen";
  static const String serviceRateScreen = "/ServiceRateScreen";
  static const String availabilityScreen = "/availabilityScreen";
  static const String rescheduleBooking = "/rescheduleBooking";
  static const String eventDetailsScreen = "/eventDetailsScreen";
  static const String createArtWorkScreen = "/createArtWorkScreen";
  static const String createNewExhibitionScreen = "/createNewExhibitionScreen";
  static const String createNewExhibitionGalleryScreen =
      "/createNewExhibitionGalleryScreen";
  static const String createNewExhibitionFeatureArtistScreen =
      "/createNewExhibitionFeatureArtistScreen";
  static const String createNewExhibitionTicketBookingScreen =
      "/createNewExhibitionTicketBookingScreen";
  static const String createNewEventScreen = "/createNewEventScreen";
  static const String createNewEventGalleryScreen = "/createNewEventGalleryScreen";
  static const String createNewEventTicketBookingScreen =
      "/createNewEventTicketBookingScreen";
  static const String uploadNewLessonScreen = "/uploadNewLessonScreen";

  //============================
  static const String userHomeScreen = "/userHomeScreen";
  static const String categoryScreen = "/categoryScreen";
  static const String learnAndGrowScreen = "/learnAndGrowScreen";
  static const String featureArtsScreen = "/featureArtsScreen";
  static const String popularArtistScreen = "/popularArtistScreen";
  static const String upComingExhibitionScreen = "/upComingExhibitionScreen";
  static const String searchScreen = "/searchScreen";
  static const String artDetailsScreen = "/artDetailsScreen";
  static const String checkOutScreen = "/checkOutScreen";
  static const String grandleGallery = "/grandleGallery";
  static const String artistDetailsScreen = "/artistDetailsScreen";
  static const String paymentConfirmationScreen = "/paymentConfirmationScreen";
  static const String offerSubmittedScreen = "/offerSubmittedScreen";
  static const String exhibitionScreen = "/exhibitionScreen";
  static const String exhibitionDetailsScreen = "/exhibitionDetailsScreen";
  static const String myListingScreen = "/myListingScreen";
  static const String purchaseHistory = "/purchaseHistory";
  static const String transactionHistory = "/transactionHistory";
  static const String upComingEventScreen = "/upComingEventScreen";
  static const String userReselScreen = "/UserReselScreen";
  static const String learningMeterials = "/learningMeterials";
  static const String learningMaterialVideoScreen = "/LearningMaterialVideoScreen";
  static const String learningMaterialsDetailsScreen = "/learningMaterialsDetailsScreen";
  static const String followersScreen = "/followersScreen";
  static const String followingScreen = "/followingScreen";
  static const String myCollectionsScreen = "/myCollectionsScreen";
  static const String myListScreen = "/myListScreen";
  static const String editArtWorkScreen = "/editArtWorkScreen";
  static const String myEventScreen = "/myEventScreen";
  static const String myExhibitionsScreen = "/myExhibitionsScreen";
  static const String visitorOrderHistoryScreen = "/visitorOrderHistoryScreen";
  static const String myCourses = "/myCoursesItem";
  static const String myCoursesDetailsScreen = "/myCoursesDetailsScreen";
  static const String myCoursesVideoScreen = "/myCoursesVideoScreen";

  static List<GetPage> routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: welcome, page: () => const WelcomeScreen()),
    GetPage(name: chooseRole, page: () => const ChooseRoleScreen()),
    GetPage(name: onboarding, page: () => OnboardingScreen()),
    GetPage(name: signUp, page: () => SignUpScreen()),
    GetPage(name: verifyUser, page: () => const VerifyUser()),
    GetPage(name: accountVerifiedScreen, page: () => const AccountVerifiedScreen()),
    GetPage(name: signIn, page: () => SignInScreen()),
    GetPage(name: forgotPassword, page: () => ForgotPasswordScreen()),
    GetPage(name: verifyEmail, page: () => const VerifyScreen()),
    GetPage(name: createPassword, page: () => CreatePassword()),
    GetPage(name: passwordUpdated, page: () => const PasswordUpdatedScreen()),
    GetPage(name: changePassword, page: () => ChangePasswordScreen()),
    GetPage(name: notifications, page: () => const NotificationScreen()),
    GetPage(name: chat, page: () => const ChatListScreen()),
    GetPage(name: message, page: () => const MessageScreen()),
    GetPage(name: profile, page: () => const ProfileScreen()),
    GetPage(name: editProfile, page: () => EditProfile()),
    GetPage(name: privacyPolicy, page: () => const PrivacyPolicyScreen()),
    GetPage(name: termsOfServices, page: () => const TermsOfServicesScreen()),
    GetPage(name: setting, page: () => const SettingScreen()),

    GetPage(name: parentBookingScreen, page: () => ParentBookingScreen()),
    GetPage(name: notificationSettings, page: () => NotificationSettings()),
    GetPage(name: helpAndSupportScreen, page: () => HelpAndSupportScreen()),
    GetPage(name: aboutUsScreen, page: () => AboutUsScreen()),
    GetPage(name: nunnyBookingScreen, page: () => NunnyBookingScreen()),

    //================ user home screen
    GetPage(name: userHomeScreen, page: () => UserHomeScreen()),
    GetPage(name: categoryScreen, page: () => CategoryScreen()),
    GetPage(name: learnAndGrowScreen, page: () => LearnAndGrowScreen()),
    GetPage(name: featureArtsScreen, page: () => FeatureArtsScreen()),
    GetPage(name: popularArtistScreen, page: () => PopularArtistScreen()),
    GetPage(name: upComingExhibitionScreen, page: () => UpComingExhibitionScreen()),
    GetPage(name: searchScreen, page: () => SearchScreen()),
    GetPage(name: artDetailsScreen, page: () => ArtDetailsScreen()),
    GetPage(name: checkOutScreen, page: () => CheckOutScreen()),
    GetPage(name: paymentConfirmationScreen, page: () => PaymentConfirmationScreen()),
    GetPage(name: offerSubmittedScreen, page: () => const OfferSubmittedScreen()),
    // TODO: GetPage(name: grandleGallery, page: () => GrandleGallery()),
    GetPage(name: artistDetailsScreen, page: () => ArtistDetailsScreen()),
    //TODO:  GetPage(name: exhibitionScreen, page: () => ExhibitionScreen()),
    GetPage(name: exhibitionDetailsScreen, page: () => ExhibitionDetailsScreen()),
    GetPage(name: createArtWorkScreen, page: () => CreateArtWorkScreen()),
    // TODO: ucommented for testing
    GetPage(name: createNewExhibitionScreen, page: () => CreateExhibitionScreen()),
    // GetPage(name: createNewExhibitionScreen, page: () => CreateNewExhibitionScreen()),
    // GetPage(
    //   name: createNewExhibitionGalleryScreen,
    //   page: () => CreateNewExhibitionGalleryScreen(),
    // ),
    // GetPage(
    //   name: createNewExhibitionFeatureArtistScreen,
    //   page: () => CreateNewExhibitionFeatureArtistScreen(),
    // ),
    // GetPage(
    //   name: createNewExhibitionTicketBookingScreen,
    //   page: () => CreateNewExhibitionTicketBookingScreen(),
    // ),
    GetPage(name: createNewEventScreen, page: () => CreateNewEventScreen()),
    GetPage(name: createNewEventGalleryScreen, page: () => CreateNewEventGalleryScreen()),
    GetPage(
      name: createNewEventTicketBookingScreen,
      page: () => CreateNewEventTicketBookingScreen(),
    ),
    GetPage(name: myListingScreen, page: () => MyListingScreen()),
    GetPage(name: purchaseHistory, page: () => OrderHistoryScreen()),
    GetPage(name: transactionHistory, page: () => TransactionScreen()),
    GetPage(name: savedScreen, page: () => SavedScreen()),
    GetPage(name: followersScreen, page: () => FollowersScreen()),
    GetPage(name: followingScreen, page: () => FollowingScreen()),
    GetPage(name: upComingEventScreen, page: () => UpComingEventScreen()),
    GetPage(name: myCollectionsScreen, page: () => const MyCollectionsScreen()),
    GetPage(name: learningMeterials, page: () => LearningMetarialScreen()),
    GetPage(name: userReselScreen, page: () => UserReselScreen()),
    GetPage(name: learningMaterialVideoScreen, page: () => LearningMaterialVideoScreen()),
    GetPage(
      name: learningMaterialsDetailsScreen,
      page: () => LearningMaterialsDetailsScreen(),
    ),
    GetPage(name: eventDetailsScreen, page: () => EventDetailsScreen()),
    GetPage(name: myListScreen, page: () => MyListScreen()),
    GetPage(name: editArtWorkScreen, page: () => EditArtWorkScreen()),
    GetPage(name: myEventScreen, page: () => MyEventScreen()),
    GetPage(name: myExhibitionsScreen, page: () => MyExhibitionsScreen()),
    GetPage(name: visitorOrderHistoryScreen, page: () => VisitorOrderHistoryScreen()),
    GetPage(name: myCourses, page: () => MyCoursesScreen()),
    GetPage(name: myCoursesDetailsScreen, page: () => MyCoursesDetailsScreen()),
    GetPage(name: myCoursesVideoScreen, page: () => MyCoursesVideoScreen()),
    GetPage(name: uploadNewLessonScreen, page: () => UploadNewLessonScreen()),
  ];
}
