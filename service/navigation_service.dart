import 'package:injectable/injectable.dart';

import 'package:flutter/material.dart';

@lazySingleton
class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<Object?>? navigateTo({
    required String routeName,
    Object? argument,
  }) {
    return navigatorKey.currentState?.pushNamed(routeName, arguments: argument);
  }

  Future<Object?>? pushReplacement({
    required String routeName,
    Object? argument,
  }) {
    return navigatorKey.currentState
        ?.pushReplacementNamed(routeName, arguments: argument);
  }

  Future<Object?>? clearAllAndNavigatorTo({
    required String routeName,
    Object? argument,
    predicate = false,
  }) {
    return navigatorKey.currentState?.pushNamedAndRemoveUntil(
        routeName,
        (_) =>
            predicate, //predicate  => Push the route with the given name onto the navigator, and then remove all the previous routes until the predicate returns true.
        arguments: argument);
  }

  void pop([Object? result]) {
    return navigatorKey.currentState?.pop(result);
  }

  bool canPop() {
    return navigatorKey.currentState?.canPop() ?? false;
  }

  Future<void> showMyDialog({
    required String title,
    String? description,
    EdgeInsets padding = const EdgeInsets.symmetric(
      vertical: 24,
      horizontal: 24,
    ),
  }) {
    return showDialog(
      // barrierColor: Palette.grey.withOpacity(0.3),
      context: navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        contentPadding: padding,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
        title: Text(title),
        content: Text(description ?? ""),
        actions: [
          TextButton(
            onPressed: () => pop(),
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  Future<void> showMyDialogWithNavigation({
    required String title,
    required String description,
    required String route,
  }) {
    return showDialog(
      barrierDismissible: false,
      context: navigatorKey.currentContext!,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(title),
        content: Text(description),
        actions: [
          TextButton(
            onPressed: () {
              // setToken("");
              clearAllAndNavigatorTo(
                routeName: route,
              );
            },
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  Future<void> showMyDialogWithNavigationArg({
    required String title,
    required String description,
    required String route,
    required Object arguments,
    isAdditionalFunction = false,
    Function? additionalFunction,
  }) {
    return showDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(title),
        content: Text(description),
        actions: [
          TextButton(
            onPressed: () {
              if (isAdditionalFunction) {
                additionalFunction?.call();
                pop();
                navigateTo(
                  routeName: route,
                  argument: arguments,
                );
              } else {
                pop();
                navigateTo(
                  routeName: route,
                  argument: arguments,
                );
              }
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
