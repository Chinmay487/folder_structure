import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";
import "package:get_it/get_it.dart";

import "service/navigation_service.dart";
import "service/navigator.dart";
import "service/shared_pref.dart";
import "utils/navigator_routes.dart";

// This is global ServiceLocator
GetIt locator = GetIt.instance;

void setupLocator() {
  GetIt.instance
      .registerLazySingleton<NavigationService>(() => NavigationService());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sharedPrefInit();
  setupLocator();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: NavigatorRoutes.initialRoute,
          navigatorKey: locator<NavigationService>().navigatorKey,
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child!,
            );
          },
          onGenerateRoute: RouteGenerator.generateRoute,
        );
      },
      // child: ,
    );
  }
}
