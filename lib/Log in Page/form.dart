import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:home_rent/gradient.dart';
import 'package:home_rent/main.dart';
import 'package:home_rent/root.dart';
import '../text_field.dart';
import 'package:http/http.dart' as http;
class LoginForm extends StatefulWidget{
  final TextEditingController email_controller,password_controller;
  const LoginForm({super.key,required this.email_controller,required this.password_controller});
  @override
  State<StatefulWidget> createState() => _LoginFormState();
}
class _LoginFormState extends State<LoginForm>{
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  final GlobalKey<Text_FieldState> _Email=GlobalKey();
  final GlobalKey<PasswordFieldState> _Password=GlobalKey();
  void _validateForm(){
    _Email.currentState?.validate();
    _Password.currentState?.validate();
  }
  Future<Map<String,String?>> login() async{
    final url = Uri.parse('https://home-rent.runasp.net/auth/sign-in');
    final response = await http.post(
      url,
      headers: {"content-type":"application/json"},
      body: jsonEncode({'email': widget.email_controller.text,'password': widget.password_controller.text})
    );
    if (response.statusCode == 200) {
      print('login success');
      return {};
    } else {
      return {'email':"Invalid Email or Password.","password":"Invalid Email or Password."};
    }
  }
  @override
  Widget build(BuildContext context) {
    final double screenWidth=MediaQuery.of(context).size.width;
    final double screenHeight=MediaQuery.of(context).size.height;
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: screenHeight*0.04),
        child: Column(
          children: [
            Text_Field(
              key: _Email,
              label: "Email/Username",
              hintText: "Enter your email address/username",
              controller: widget.email_controller,
            ),
            PasswordField(
              key: _Password,
              controller: widget.password_controller,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0,vertical: screenHeight*0.01),
              child: Column(
                children: [
                  GradientButton(
                    degrees: 0,
                    colors: [Root.primary_color_dark,Color(0xff2575fc)],
                    borderRadius: BorderRadius.circular(8),
                    minimumSize: Size(screenWidth,screenHeight*0.07),
                    maximumSize: Size(screenWidth, screenHeight*0.12),
                    onPressed: () async{
                      _validateForm();
                      if(widget.email_controller.text.isEmpty||
                        widget.password_controller.text.isEmpty){
                        return;
                      }
                      var errors=await login();
                      setState(() {
                        _Email.currentState?.updateError(errors.containsKey('email') ? errors['email'] : null);
                        _Password.currentState?.updateError(errors.containsKey('password') ? errors['password'] : null);
                      });
                      if(errors.isEmpty){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Login Successful'))
                        );
                      }
                    },
                    shadowColor: Color.fromRGBO(106, 17, 203, 0.3),
                    shadowOffset: Offset(0, 4),
                    shadowBlurRadius: 15,
                    child: const Text('Log In'),
                  ),
                  SizedBox(height: screenHeight*0.01,),
                  GradientButton(
                    colors: [Colors.black26,Colors.black12], 
                    degrees: 0, 
                    borderRadius: BorderRadius.circular(8),
                    shadowColor: Color.fromRGBO(106, 17, 203, 0.3),
                    shadowOffset: Offset(0, 4),
                    shadowBlurRadius: 15,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context)=>MainApp()
                        )
                      );
                    },
                    minimumSize: Size(screenWidth,screenHeight*0.07),
                    maximumSize: Size(screenWidth, screenHeight*0.12),
                    child: const Text('Sign Up')
                  ),
                ],
              )
            )
          ],
        ),
      )
    );
  }
}