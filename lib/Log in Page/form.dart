import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:home_rent/Home%20Page/home_screen.dart';
import 'package:home_rent/gradient.dart';
import 'package:home_rent/main.dart';
import 'package:home_rent/helper.dart';
import 'package:home_rent/providers/auth_provider.dart';
import 'package:home_rent/providers/user_provider.dart';
import 'package:provider/provider.dart';
//import '../text_field.dart';
import 'package:http/http.dart' as http;
class LoginForm extends StatefulWidget{
  final TextEditingController email_controller,password_controller;
  const LoginForm({super.key,required this.email_controller,required this.password_controller});
  @override
  State<StatefulWidget> createState() => _LoginFormState();
}
class _LoginFormState extends State<LoginForm>{
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  // final GlobalKey<Text_FieldState> _Email=GlobalKey();
  // final GlobalKey<Text_FieldState> _Password=GlobalKey();
  late FocusNode _emailFocusNode,_passwordFocusNode;
  String? _emailError,_passwordError;
  bool hidden=true;
  @override
  void initState(){
    super.initState();
    _emailFocusNode=FocusNode();
    _passwordFocusNode=FocusNode();
    _emailFocusNode.addListener((){
      if (!_emailFocusNode.hasFocus) {
        _validateEmail();
      }
    });
    _passwordFocusNode.addListener((){
      if(!_passwordFocusNode.hasFocus){
        _validatePassword();
      }
    });
  }
  bool isValidEmail(String text){
    String expr=r'[A-Za-z0-9]+@[A-Za-z]+.[A-Za-z]+';
    RegExp regex=RegExp(expr);
    return regex.hasMatch(text);
  }
  bool isValidPassword(String text){
    return text.length>=8;
  }
  void _validateEmail() {
    if (widget.email_controller.text.isEmpty) {
      setState(() {
        _emailError = 'Email is required';
      });
    } else if (!isValidEmail(widget.email_controller.text)) {
      setState(() {
        _emailError = 'Invalid Email';
      });
    } else {
      setState(() {
        _emailError = null;
      });
    }
  }
  void _validatePassword() {
    if (widget.password_controller.text.isEmpty) {
      setState(() {
        _passwordError = 'Password is required';
      });
    } else if (!isValidPassword(widget.password_controller.text)) {
      setState(() {
        _passwordError = 'Invalid Password';
      });
    } else {
      setState(() {
        _passwordError = null;
      });
    }
  }
   @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
  void _validateForm(){
    _validateEmail();
    _validatePassword();
    // _Email.currentState?.validate();
    // _Password.currentState?.validate();
  }
  Future<Map<String,String?>> login() async{
    final url = Uri.parse('https://home-rent.runasp.net/auth/sign-in');
    final response = await http.post(
      url,
      headers: {"content-type":"application/json"},
      body: jsonEncode({'email': widget.email_controller.text,'password': widget.password_controller.text})
    );
    final responseData=jsonDecode(response.body);
    if (response.statusCode == 200) {
      final userData=UserData.fromJson(responseData);
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final userProvider = Provider.of<UserProvider>(context,listen: false);
      await userProvider.setData(userData);
      await authProvider.setToken(userData);
      return {};
    } 
    else if(response.statusCode==423){
      return {'locked':'try again later...'};
    }
    else {
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
            TextFormField(
              focusNode: _emailFocusNode,
              decoration: InputDecoration(
                labelText: "Email",
                hintText: "Enter your email address",
                errorText: _emailError,
              ),
              keyboardType: TextInputType.emailAddress,
              controller: widget.email_controller,
            ),
            SizedBox(height: screenHeight*0.015,),
            TextFormField(
              focusNode: _passwordFocusNode,
              decoration: InputDecoration(
                labelText: "Password",
                hintText: "Enter your password",
                errorText: _passwordError,
                suffixIcon: IconButton(
                  onPressed: (){
                    setState(() {
                      hidden=!hidden;
                    });
                  }, 
                  icon: Icon(hidden? Icons.visibility: Icons.visibility_off,)
                )
              ),
              controller: widget.password_controller,
              obscureText: hidden,
            ),
            SizedBox(height: screenHeight*0.01,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0,vertical: screenHeight*0.01),
              child: Column(
                children: [
                  GradientButton(
                    degrees: 0,
                    colors: [Root.primary_color_dark,const Color(0xff2575fc)],
                    borderRadius: BorderRadius.circular(8),
                    minimumSize: Size(screenWidth,screenHeight*0.07),
                    maximumSize: Size(screenWidth, screenHeight*0.12),
                    onPressed: () async{
                      _validateForm();
                      if((widget.email_controller.text.isEmpty||
                        widget.password_controller.text.isEmpty)||
                        (!isValidEmail(widget.email_controller.text)||
                        !isValidPassword(widget.password_controller.text))){
                        return;
                      }
                      var errors=await login();
                      if(errors.containsKey('locked')){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(errors['locked']!))
                        );
                      }
                      else{
                        setState(() {
                          _emailError=errors.containsKey('email')?errors['email']:null;
                          _passwordError=errors.containsKey('password') ? errors['password'] : null;
                          // _Email.currentState?.updateError(errors.containsKey('email') ? errors['email'] : null);
                          // _Password.currentState?.updateError(errors.containsKey('password') ? errors['password'] : null);
                        });
                      }
                      if(errors.isEmpty){
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Login Success'))
                        );
                        Navigator.pushReplacement(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => HomePage()
                          )
                        );
                      }
                    },
                    shadowColor:const Color.fromRGBO(106, 17, 203, 0.3),
                    shadowOffset: const Offset(0, 4),
                    shadowBlurRadius: 15,
                    child: const Text('Log In'),
                  ),
                  SizedBox(height: screenHeight*0.01,),
                  GradientButton(
                    colors: [Colors.black26,Colors.black12], 
                    degrees: 0, 
                    borderRadius: BorderRadius.circular(8),
                    shadowColor: const Color.fromRGBO(106, 17, 203, 0.3),
                    shadowOffset: const Offset(0, 4),
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