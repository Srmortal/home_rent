import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:home_rent/gradient.dart';
import 'package:home_rent/helper.dart';
import 'package:home_rent/password_bar.dart';
import 'package:http/http.dart' as http;
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
  Future<Map<String,String?>> signup() async{
    final url = Uri.parse('https://home-rent.runasp.net/auth/sign-up');
    final response = await http.post(
      url,
      headers: {"content-type":"application/json"},
      body: jsonEncode({
        'firstname': widget.firstname_controller.text,
        'lastname': widget.lastname_controller.text,
        'email': widget.email_controller.text,
        'password': widget.password_controller.text
      })
    );
    if (response.statusCode == 200) {
      print('creation success');
      return {};
    } else {
      final responseData=jsonDecode(response.body);
      Map<String, String?> extractedErrors = {};
      if (responseData is Map<String, dynamic> && responseData.containsKey('errors')) {
        final errors = responseData['errors'];
        if (errors is Map<String, dynamic>) {
          errors.forEach((key, value) {
            if (value is List && value.isNotEmpty) {
              extractedErrors[key] = value.join(", ");
            }
          });
        } else if (errors is List) {
          String combinedErrors = errors.join("\n");
          if (combinedErrors.contains("email")) {
            
          } else {
            extractedErrors['general'] = combinedErrors;
          }
        }
      }
      print("Extracted errors: $extractedErrors");
      return extractedErrors;
    }
  }
  void _openTermsAndConditions() {
    // Handle the hypertext click action
    print('Terms and Conditions clicked!');
    // You can navigate to a new screen or show a dialog here
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
              PasswordBar(controller: widget.password_controller,),
              SizedBox(height: screenHeight*0.01,),
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
                        style: TextStyle(color: Root.primary_color_dark),
                        recognizer: TapGestureRecognizer()..onTap = _openTermsAndConditions
                      )
                    ]
                  )
                )
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0,vertical: screenHeight*0.01),
            child: GradientButton(
              degrees: 0,
              colors: [Root.primary_color_dark,Color(0xff2575fc)],
              minimumSize: Size(screenWidth,screenHeight*0.07),
              maximumSize: Size(screenWidth, screenHeight*0.12),
              borderRadius: BorderRadius.circular(8),
              onPressed: () async{
                _validateForm();
                if(widget.firstname_controller.text.isEmpty||
                  widget.lastname_controller.text.isEmpty||
                  widget.email_controller.text.isEmpty||
                  widget.password_controller.text.isEmpty){
                  return;
                }
                var errors=await signup();
                setState(() {
                  _FName.currentState?.updateError(errors.containsKey('FirstName') ? 'First Name is short' : null);
                  _LName.currentState?.updateError(errors.containsKey('LastName') ? 'Last Name is short' : null);
                  _Email.currentState?.updateError(errors.containsKey('Email') ? 'Invalid Email' : null);
                  _Password.currentState?.updateError(errors.containsKey('Password') ? 'Invalid Password' : null);
                });
                if(errors.isEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Sign Up success'))
                  );
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