import 'package:flutter/material.dart';

import '../modules/dashboard_module/dashboard_screen.dart';
import '../modules/error/error_page.dart';
import '../utils/navigator_routes.dart';
import 'logger_service.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments as Map?;
    printLog(
      className: settings.name,
      message: (args).toString(),
      logType: 'e',
    );
    switch (settings.name) {
      case NavigatorRoutes.initialRoute:
        return MaterialPageRoute(
          builder: (context) {
            return const DashboardScreen();
          },
        );

      default:
        return MaterialPageRoute(
          builder: (context) {
            return const ErrorPage();
          },
        );
    }
  }

  static goToPage(RouteSettings settings, Widget pageName) {
    //
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => pageName,
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return child;
      },
    );
  }
}
