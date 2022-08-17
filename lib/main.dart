import 'package:dart_g2_stores/features/admin/screens/admin_screen.dart';
import 'package:dart_g2_stores/features/auth/screens/auth_screen.dart';
import 'package:dart_g2_stores/features/auth/services/auth_services.dart';
import 'package:dart_g2_stores/features/bottom_nav/bottom_nav_bar.dart';
import 'package:dart_g2_stores/features/splash/screens/splash_screen.dart';
import 'package:dart_g2_stores/provider/user_provider.dart';
import 'package:dart_g2_stores/router.dart';
import 'package:dart_g2_stores/shared/app%20elements/app_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUSerData(context);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(392.73, 834.91),
        minTextAdapt: true,
        splitScreenMode: false,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppTexts.appName,
            theme: ThemeData(
              textTheme: GoogleFonts.poppinsTextTheme(),
              primarySwatch: Colors.blue,
            ),
            onGenerateRoute: (settings) => generateRoute(settings),
            home: Provider.of<UserProvider>(context).user.token.isNotEmpty
                ? Provider.of<UserProvider>(context).user.type == 'user'
                    ? const BottomNavBar()
                    : const AdminScreen()
                : const SplashScreen(),
          );
        });
  }
}
