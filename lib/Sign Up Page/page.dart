import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:home_rent/Log%20in%20Page/page.dart';
import 'form.dart';
import '../helper.dart';
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}
class _RegisterPageState extends State<RegisterPage> {
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
    final double screenWidth=MediaQuery.of(context).size.width;
    final double screenHeight=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Root.card_bg_dark,
      body: LayoutBuilder(
        builder: (context,constraints) {
          return Container(
            width: screenWidth,
            height: screenHeight,
            padding: EdgeInsets.symmetric(
              horizontal: constraints.maxWidth*(40/screenWidth),
              vertical: constraints.maxHeight*(80/screenHeight)
            ),
            child: SingleChildScrollView(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Create an account",style: TextStyle(
                    fontSize: rem(context,1.8),
                    fontWeight: FontWeight.w600
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: constraints.maxHeight*(10/screenHeight)),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: rem(context, 0.9),fontWeight: FontWeight.w600),
                        children: [
                          const TextSpan(text: "Already have an account? ",style: TextStyle(
                              color: Root.text_secondary,
                            ),
                          ),
                          TextSpan(text: "Log in",
                            style: const TextStyle(
                              color: Root.primary_color_dark
                            ),
                            recognizer: TapGestureRecognizer()..onTap=(){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context)=>LoginPage(),
                                )
                              );
                            }
                          )
                        ]
                      )
                    )
                  ),
                RegisterForm(firstname_controller: fname,lastname_controller: lname,email_controller: email,password_controller: password,)
              ],
            ),
            ),
          );
        }
      )
    );
  }
}
