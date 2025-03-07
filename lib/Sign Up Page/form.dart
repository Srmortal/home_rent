import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:home_rent/gradient.dart';
import 'package:home_rent/helper.dart';
import 'package:home_rent/password_bar.dart';
import '../text_field.dart';
import '../root.dart';
class RegisterForm extends StatefulWidget{
  // ignore: non_constant_identifier_names
  final TextEditingController email_controller,password_controller,firstname_controller,lastname_controller;
  // ignore: non_constant_identifier_names
  const RegisterForm({super.key,required this.email_controller,required this.firstname_controller,required this.lastname_controller,required this.password_controller});
  @override
  State<StatefulWidget> createState() => _RegisterFormState();
}
class _RegisterFormState extends State<RegisterForm>{
  bool isChecked=false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<Text_FieldState> _Email=GlobalKey();
  final GlobalKey<PasswordFieldState> _Password=GlobalKey();
  final GlobalKey<Text_FieldState> _FName=GlobalKey();
  final GlobalKey<Text_FieldState> _LName=GlobalKey();
  void _validateForm(){
    _Email.currentState?.validate();
    _Password.currentState?.validate();
    _FName.currentState?.validate();
    _LName.currentState?.validate();
  }
  void _openTermsAndConditions() {
    // Handle the hypertext click action
    print('Terms and Conditions clicked!');
    // You can navigate to a new screen or show a dialog here
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
      padding: EdgeInsets.symmetric(vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text_Field(
            label: "First Name",
            hintText: "Enter your first name",
            controller: widget.firstname_controller,
            key: _FName
          ),
          Text_Field(
            label: "Last Name",
            hintText: "Enter your last name",
            controller: widget.lastname_controller,
            key: _LName
          ),
          Text_Field(
            label: "Email/Username",
            hintText: "Enter your email address or username",
            controller: widget.email_controller,
            key: _Email
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PasswordField(
                controller: widget.password_controller,
                key: _Password
              ),
              SizedBox(height: 10,),
              PasswordBar(controller: widget.password_controller,)
            ],
          ),
          Row(
            children: [
              Checkbox(value: isChecked, onChanged: (bool? value){
                setState(() {
                  isChecked=value!;
                });
              }),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: rem(context, 0.9),fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                        text: 'I agree to the ',
                        style: TextStyle(color: Root.text_secondary)
                      ),
                      TextSpan(
                        text: 'Terms & Conditions',
                        style: TextStyle(color: Root.primary_color),
                        recognizer: TapGestureRecognizer()..onTap = _openTermsAndConditions
                      )
                    ]
                  )
                )
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 8),
            child: GradientButton(
              degrees: 0,
              colors: [Root.primary_color,Color(0xff2575fc)],
              minimumSize: Size(350,55),
              maximumSize: Size(650, 110),
              borderRadius: BorderRadius.circular(8),
              onPressed: (){
                _validateForm();
                if(widget.firstname_controller.text.isEmpty||
                  widget.lastname_controller.text.isEmpty||
                  widget.email_controller.text.isEmpty||
                  widget.password_controller.text.isEmpty){
                  return;
                }
              },
              shadowColor: Color.fromRGBO(106, 17, 203, 0.3),
              shadowOffset: Offset(0, 4),
              shadowBlurRadius: 15,
              child: const Text("Create Account"),
            )
          )
        ]
      ),
      )
    );
  }
}