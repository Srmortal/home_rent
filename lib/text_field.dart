// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
TextInputType type_getter(String type){
  if (type == "email") return TextInputType.emailAddress;
  if (type == "number") return TextInputType.number;
  return TextInputType.text;
}

class Text_Field extends StatefulWidget{
  final String? hintText;
  final String label,type;
  final TextEditingController controller;
  const Text_Field({super.key,required this.label,this.hintText,this.type="Text",required this.controller});
  @override
  State<StatefulWidget> createState() => Text_FieldState();
}
class Text_FieldState extends State<Text_Field>{
  final FocusNode _focusNode = FocusNode();
  bool _hasError = false;
  void validate(){
    setState(() {
      _hasError=widget.controller.text.isEmpty;
    });
  }
  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        validate();
      }
    });
  }
  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        focusNode: _focusNode,
        controller: widget.controller,
        decoration: InputDecoration(
          label: Text(widget.label),
          hintText: widget.hintText,
          errorText: _hasError ? '${widget.label} is required' : null,
        ),
        keyboardType: type_getter(widget.type),
      ),
    );
  }
    
}
class PasswordField extends StatefulWidget{
  final TextEditingController controller;
  const PasswordField({super.key,required this.controller});
  @override
  State<StatefulWidget> createState() => PasswordFieldState();
}
class PasswordFieldState extends State<PasswordField>{
  bool ishidden=true;
  final FocusNode _focusNode = FocusNode();
  bool _hasError = false;
  void togglevisibility(){
    setState(() {
      ishidden=!ishidden;
    });
  }
  void validate(){
    setState(() {
      _hasError=widget.controller.text.isEmpty;
    });
  }
  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        validate();
      }
    });
  }
  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        focusNode: _focusNode,
        controller: widget.controller,
        obscureText: ishidden,
        decoration: InputDecoration(
          label: Text("Password"),
          hintText: "Enter your password",
          errorText: _hasError ? 'Password is required' : null,
          suffixIcon: IconButton(
            onPressed: togglevisibility, 
            icon: Icon(ishidden? Icons.visibility: Icons.visibility_off,),
          ),
        ),
      ),
    );
  }
}