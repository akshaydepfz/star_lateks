import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:star_lateks/view/auth/providers/login_provider.dart';
import 'package:star_lateks/view/auth/screens/login_screen.dart';
import 'package:star_lateks/view/customer/services/customer_provider.dart';
import 'package:star_lateks/view/employees/services/employe_service.dart';
import 'package:star_lateks/view/home/screens/landing_screen.dart.dart';
import 'package:star_lateks/view/sales/providers/sales_provider.dart';
import 'package:star_lateks/view/shop/services/shop_services.dart';
import 'package:star_lateks/view/weight_list/providers/stock_provider.dart';
import 'package:star_lateks/view/weight_list/providers/weight_list_provider.dart';
import 'view/home/provider/home_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyBUnXKZVA01sy1gvBVQcmBGYAtuxJXlvD8',
      appId: '1:627781880665:android:16491df44504f68e9b5a48',
      messagingSenderId: '627781880665',
      projectId: 'star-lateks',
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the `root` of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => WeightListProvider()),
        ChangeNotifierProvider(create: (_) => CustomerProvider()),
        ChangeNotifierProvider(create: (_) => ShopServices()),
        ChangeNotifierProvider(create: (_) => SalesProvider()),
        ChangeNotifierProvider(create: (_) => EmployeeService()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => StockProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Star Lateks',
        // routes: AppRouting.routes,
        theme: ThemeData(
          textTheme: GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, userSnp) {
            if (userSnp.hasData) {
              return const LandingScreen();
            }
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
