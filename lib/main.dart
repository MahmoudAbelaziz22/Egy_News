import 'package:flutter/material.dart';
import 'package:news_app/app_router.dart';
import 'package:news_app/constants.dart';
import 'package:news_app/presentstion/screens/select_country_screen/select_country_screen.dart';

void main() {
  runApp(
    MyApp(
      appRouter: AppRouter(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({Key? key, required this.appRouter}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NewsApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
