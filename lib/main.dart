import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:home_rent/Sign%20Up%20Page/page.dart';
import 'package:home_rent/providers/auth_provider.dart';
import 'package:home_rent/providers/fav_provider.dart';
import 'package:home_rent/firebase_options.dart';
import 'package:home_rent/Home%20Page/home_screen.dart';
import 'package:home_rent/providers/appartment_provider.dart';
import 'package:home_rent/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'helper.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final authProvider=AuthProvider();
  await authProvider.loadToken();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => authProvider,
        ),
        ChangeNotifierProxyProvider<AuthProvider,UserProvider>(
          create: (BuildContext context) => UserProvider(authProvider), 
          update: (context,auth,user) => user!..updateAuth(auth)
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => AppartmentProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => FavoriteProvider(),
        )
      ],
      child: const MainApp()
    )
  );
}
class MainApp extends StatefulWidget {
  const MainApp({super.key});
  @override
  State<MainApp> createState() => _MainAppState();
}
class _MainAppState extends State<MainApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    final authProvider=Provider.of<AuthProvider>(context);
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Root.input_bg_dark,
          labelStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: rem(context, 0.9)),
          hintStyle: TextStyle(color: Root.text_secondary,fontSize: rem(context, 0.9)),
          errorStyle: TextStyle(color: Root.error_color,fontSize: rem(context, 0.7)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Root.broder_radius),
            borderSide: BorderSide(color: Root.input_border)
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Root.broder_radius),
            borderSide: BorderSide(color: Root.primary_color_dark,width: 2.5)
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Root.broder_radius),
            borderSide: BorderSide(color: Root.error_color,width: 2.5)
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Root.broder_radius),
            borderSide: BorderSide(color: Colors.red, width: 2.5), // Focused error border
          ),
        ),
        primaryColor: Root.primary_color_dark,
        fontFamily: 'sans-serif',
        cardColor: Root.card_bg_dark,
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            color: const Color.fromARGB(255, 255, 255, 255)
          ),
          bodyLarge: TextStyle(color: Root.text_secondary),
          bodySmall: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: rem(context, 0.9),
            color: Root.text_secondary
          )
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle: TextStyle(fontWeight: FontWeight.w600,fontSize: rem(context, 1),),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Root.broder_radius),
            ),
            foregroundColor: Colors.white,
            backgroundColor: Root.primary_color_dark
          )
        ),
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            foregroundColor: Colors.white54
          )
        )
      ),
      home: authProvider.isAuth? HomePage():RegisterPage()  
    );
  }
}
