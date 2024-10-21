// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../utils/_local_storage.dart';
// import '../utils/_routes.dart';

// class AuthMiddleware extends GetMiddleware {
//   @override
//   RouteSettings? redirect(String? route) {
//     hasSessionToken().then((isLoggedIn) {
//       log(isLoggedIn.toString(), name: 'SAC');
//       if (isLoggedIn) {
//         return RouteSettings(name: Routes.getHomePage);
//       } else {
//         return RouteSettings(name: Routes.getLandingPage);
//       }
//     });
//     return null;
//   }
// }
