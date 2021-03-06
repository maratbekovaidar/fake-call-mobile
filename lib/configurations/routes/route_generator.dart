
import 'package:fake_call_mobile/features/views/auth/screens/login_page.dart';
import 'package:fake_call_mobile/features/views/auth/screens/registration_page.dart';
import 'package:fake_call_mobile/features/views/call/screens/calling_page.dart';
import 'package:fake_call_mobile/features/views/main/screens/main_page.dart';
import 'package:flutter/material.dart';

class RouteGenerator {

  static const callingPage = '/calling_page';

  static Route<dynamic> generateRoute(RouteSettings settings) {

    // ignore: unused_local_variable
    final args = settings.arguments;

    switch (settings.name) {
      case MainPage.route:
        return MaterialPageRoute(builder: (_) => const MainPage(), settings: settings);
      case LoginPage.route:
        return MaterialPageRoute(builder: (_) => const LoginPage(), settings: settings);
      case RegistrationPage.route:
        return MaterialPageRoute(builder: (_) => const RegistrationPage(), settings: settings);
      // case callingPage:
      //   Map<String, dynamic> params = settings.arguments as Map<String, dynamic>;
      //   return MaterialPageRoute(
      //       builder: (_) => CallingPage(
      //         callerAvatar: params['callerAvatar'] ?? "Err",
      //         callerName: params['callerName'] ?? "Err",
      //         phone: params['phoneNumber'] ?? "err",
      //         voice: params['voice'] ?? "err",
      //       ), settings: settings);
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
