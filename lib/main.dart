import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_blog/presentation/screens/add_comments_screen/add_comments_screen.dart';
import 'package:medical_blog/presentation/screens/add_post_screen/add_post_screen.dart';
import 'package:medical_blog/presentation/screens/dashboard_screen/dashboard_screen.dart';
import 'package:medical_blog/presentation/screens/filters_screen/filters_screen.dart';
import 'package:medical_blog/presentation/screens/posts_screen/posts_screen.dart';
import 'package:medical_blog/presentation/screens/profile_screen/profile_screen.dart';
import 'package:medical_blog/presentation/screens/saved_screen/saved_screen.dart';
import 'package:medical_blog/presentation/widgets/transitions/slide_up_transition.dart';
import 'package:medical_blog/utils/constants/routes.dart';
import 'package:medical_blog/utils/constants/themes.dart';
import 'package:medical_blog/utils/network/auth_service.dart';
import 'package:medical_blog/utils/network/firestore_service.dart';
import 'package:medical_blog/utils/user_preferences.dart';

import 'presentation/screens/login_screen/login_screen.dart';
import 'presentation/screens/register/register_screen.dart';
import 'presentation/screens/splashscreen/splashscreen.dart';
import 'presentation/screens/tutorial/tutorial_page_view.dart';
import 'utils/constants/routes.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await Get.putAsync(() => SecureStorageServices().init());
  await Get.putAsync(() => FirebaseAuthService().init());
  await Get.putAsync(() => FirebaseFirestoreService().init());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      home: SplashScreen(),
      theme: kEnrollmentTheme,
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: kTutorialRoute,
          page: () => TutorialPageView(),
        ),
        GetPage(
          name: kLoginRoute,
          page: () => LoginScreen(),
        ),
        GetPage(
          name: kRegisterRoute,
          page: () => RegisterScreen(),
        ),
        GetPage(
          name: kDashboardRoute,
          page: () => DashboardScreen(),
          transition: Transition.noTransition,
        ),
        GetPage(
          name: kPostsRoute,
          page: () => PostsScreen(),
          transition: Transition.noTransition,
        ),
        GetPage(
          name: kSavedRoute,
          page: () => SavedScreen(),
          transition: Transition.noTransition,
        ),
        GetPage(
          name: kProfileRoute,
          page: () => ProfileScreen(),
          transition: Transition.noTransition,
        ),
        GetPage(
          name: kAddPostRoute,
          page: () => AddPostScreen(),
          customTransition: SlideUpTransition(),
        ),
        GetPage(
          name: kAddCommentsRoute,
          page: () => AddCommentsScreen(),
        ),
        GetPage(
          name: kFiltersScreenRoute,
          page: () => FiltersScreen(),
        ),
      ],
    );
  }
}

class SecureStorageServices extends GetxService {
  Future<PreferencesUtils> init() async {
    return PreferencesUtils.init();
  }
}

class FirebaseAuthService extends GetxService {
  Future<AuthService> init() async {
    return AuthService.init();
  }
}

class FirebaseFirestoreService extends GetxService {
  Future<FirestoreService> init() async {
    return FirestoreService.init();
  }
}
