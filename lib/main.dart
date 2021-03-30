import 'package:flutter/material.dart';
import 'package:medical_blog/presentation/router/app_router.dart';
import 'package:medical_blog/utils/constants/routes.dart';
import 'package:medical_blog/utils/constants/themes.dart';
import 'package:get/get.dart';
import 'package:medical_blog/utils/network/auth_service.dart';
import 'package:medical_blog/utils/network/firestore_service.dart';
import 'package:medical_blog/utils/user_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Get.putAsync(() => SecureStorageServices().init());
  await Get.putAsync(() => FirebaseAuthService().init());
  await Get.putAsync(() => FirebaseFirestoreServie().init());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      onGenerateRoute: _appRouter.onGenerateRoute,
      initialRoute: homeRoute,
      theme: kEnrollmentTheme,
      debugShowCheckedModeBanner: false,
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

class FirebaseFirestoreServie extends GetxService {
  Future<FirestoreService> init() async {
    return FirestoreService.init();
  }
}
