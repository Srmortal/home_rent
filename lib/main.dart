import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:home_rent/Log%20in%20Page/page.dart';
import 'package:home_rent/Sign%20Up%20Page/form.dart';
import 'root.dart';
import 'helper.dart';
void main() {
  runApp(const MainApp());
}
class MainApp extends StatefulWidget {
  const MainApp({super.key});
  @override
  State<MainApp> createState() => _MainAppState();
}
class _MainAppState extends State<MainApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  late final TextEditingController email;
  late final TextEditingController password;
  late final TextEditingController fname;
  late final TextEditingController lname;

  @override
  void initState() {
    super.initState();
    // Initialize controllers once
    email = TextEditingController();
    password = TextEditingController();
    fname = TextEditingController();
    lname = TextEditingController();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    fname.dispose();
    lname.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: rem(context, 0.9)),
          hintStyle: TextStyle(color: Root.text_secondary,fontSize: rem(context, 0.9)),
          errorStyle: TextStyle(color: Root.error_color,fontSize: rem(context, 0.9)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Root.broder_radius),
            borderSide: BorderSide(color: Colors.white)
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Root.primary_color,width: 2.5)
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Root.error_color,width: 2.5)
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.5), // Focused error border
          ),
        ),
        primaryColor: Root.primary_color,
        fontFamily: 'sans-serif',
        cardColor: Root.card_bg,
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
          bodyLarge: TextStyle(color: Colors.white),
          bodySmall: TextStyle(color: Colors.white)
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle: TextStyle(fontWeight: FontWeight.w600,fontSize: rem(context, 1),),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Root.broder_radius),
            ),
            foregroundColor: Colors.white,
            backgroundColor: Root.primary_color
          )
        )
      ),
      home: Scaffold(
        backgroundColor: Root.card_bg,
        body: Container(
          width: 600,
          padding: EdgeInsets.symmetric(horizontal: 40,vertical: 80),
          child: DefaultTextStyle(
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: rem(context,0.9)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Create an account",style: TextStyle(
                    fontSize: rem(context,1.8),
                    fontWeight: FontWeight.w600
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: rem(context, 0.9),fontWeight: FontWeight.w600),
                        children: [
                          TextSpan(text: "Already have an account? ",style: TextStyle(
                              color: Root.text_secondary,
                            ),
                          ),
                          TextSpan(text: "Log in",
                            style: TextStyle(
                              color: Root.primary_color
                            ),
                            recognizer: TapGestureRecognizer()..onTap=(){
                              navigatorKey.currentState?.push(
                                MaterialPageRoute(
                                  builder: (context)=>LoginPage(),
                                )
                              );
                            }
                          )
                        ]
                      )
                    )
                  )
                ),
                RegisterForm(firstname_controller: fname,lastname_controller: lname,email_controller: email,password_controller: password,)
              ],
            ),
          ),
        )
        ),
      );
  }
}
