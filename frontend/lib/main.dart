import 'package:emerald/api/api_service.dart';
import 'package:emerald/api/userInfo.dart';
import 'package:emerald/component/currentUser.dart';
import 'package:emerald/register/signin.dart';
import 'package:emerald/register/signup.dart';
import 'package:emerald/tabbar/fifth/fifth.dart';
import 'package:emerald/tabbar/first/first.dart';
import 'package:emerald/tabbar/mainPage.dart';
import 'package:emerald/tabbar/profile/profile';
import 'package:emerald/tabbar/profile/profile.dart';
import 'package:emerald/tabbar/second/second.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();

  // admob flutter area start
  MobileAds.instance.initialize();

  runApp(const Emerald());
}

class Emerald extends StatefulWidget {
  const Emerald({super.key});

  @override
  State<Emerald> createState() => _EmeraldState();
}

class _EmeraldState extends State<Emerald> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const Login(),
        '/signup': (context) => const SignUp(),
        // '/mainpage': (context) => MainPage(),
      },

      // home: const MainPage(),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() async {
    // TODO: implement dispose
    super.dispose();
  }
}
