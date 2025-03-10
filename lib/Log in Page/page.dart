import 'package:flutter/material.dart';
import 'package:home_rent/Log%20in%20Page/form.dart';
import '../root.dart';
import '../helper.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  late final TextEditingController email;
  late final TextEditingController password;

  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final double screenWidth=MediaQuery.of(context).size.width;
    final double screenHeight=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Root.card_bg,
      body: LayoutBuilder(
        builder: (context,constraints) {
          return Container(
            width: screenWidth,
            height: screenHeight,
            padding: EdgeInsets.symmetric(
                horizontal: constraints.maxWidth*(40/screenWidth),
                vertical: constraints.maxHeight*(80/screenHeight)
            ),
            child: DefaultTextStyle(
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: rem(context,0.9)
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Log into your account",style: TextStyle(
                        fontSize: rem(context,1.8),
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    LoginForm(email_controller: email,password_controller: password,)
                  ],
                ),
              )
            ),
          );
        }
      ),
    );
  }
  
}