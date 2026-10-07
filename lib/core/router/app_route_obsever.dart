import 'package:flutter/material.dart';

class AppRouteObsever  extends NavigatorObserver{

@override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    // TODO: implement didPush
    super.didPush(route, previousRoute);
    final routeName = route.settings.name ?? "unknow name";
    debugPrint("route name is a $routeName"); 
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    // TODO: implement didPop
    super.didPop(route, previousRoute);

  final currentRoute = route.settings.name ?? "unknow name";
  final backRoute  = previousRoute?.settings.name ?? "unknow name";
  
  debugPrint("current route is a $currentRoute and back route is a $backRoute");

  
  }

}