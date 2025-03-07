import 'package:flutter/material.dart';
import 'package:home_rent/gradient.dart';
import 'package:home_rent/main.dart';
import 'package:home_rent/root.dart';
import '../text_field.dart';
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
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 60),
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
              padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 8),
              child: Column(
                children: [
                  GradientButton(
                    degrees: 0,
                    colors: [Root.primary_color,Color(0xff2575fc)],
                    borderRadius: BorderRadius.circular(8),
                    maximumSize: Size(650, 110),
                    minimumSize: Size(350,55),
                    onPressed: (){
                      _validateForm();
                      if(widget.email_controller.text.isEmpty||
                        widget.password_controller.text.isEmpty){
                        return;
                      }
                    },
                    shadowColor: Color.fromRGBO(106, 17, 203, 0.3),
                    shadowOffset: Offset(0, 4),
                    shadowBlurRadius: 15,
                    child: const Text('Log In'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        maximumSize: Size(650, 110),
                        minimumSize: Size(350,55),
                      ),
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context)=>MainApp()
                          )
                        );
                      }, 
                      child: const Text('Sign Up')
                    ),
                  )
                ],
              )
            )
          ],
        ),
      )
    );
  }
}