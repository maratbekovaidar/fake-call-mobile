import 'package:fake_call_mobile/configurations/routes/route_generator.dart';
import 'package:fake_call_mobile/configurations/themes/app_theme.dart';
import 'package:fake_call_mobile/features/views/main/screens/main_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meow',
      theme: AppTheme.basic,
      debugShowCheckedModeBanner: false,
      initialRoute: MainPage.route,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
