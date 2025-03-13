// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:home_rent/helper.dart';
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
  final EdgeInsets padding;
  final double? fontSize;
  const Text_Field({
    super.key,
    required this.label,
    this.hintText,
    this.type="Text",
    required this.controller, 
    this.padding=const EdgeInsets.symmetric(vertical: 10), 
    this.fontSize
  });
  @override
  State<StatefulWidget> createState() => Text_FieldState();
}
class Text_FieldState extends State<Text_Field>{
  final FocusNode _focusNode = FocusNode();
  String? _error;
  void validate(){
    if (_error != null) return;
    setState(() {
      _error=widget.controller.text.isEmpty? '${widget.label} is required':null;
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
  void updateError(String? error){
    setState(() {
      _error=error;
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
      padding: widget.padding,
      child: TextFormField(
        style: TextStyle(fontSize: widget.fontSize ?? rem(context, 0.9)),
        focusNode: _focusNode,
        controller: widget.controller,
        decoration: InputDecoration(
          label: Text(widget.label),
          hintText: widget.hintText,
          errorText: _error,
        ),
        keyboardType: type_getter(widget.type),
      ),
    );
  }
    
}
class PasswordField extends StatefulWidget{
  final TextEditingController controller;
  final EdgeInsets padding;
  final double? fontSize;
  const PasswordField({
    super.key,
    required this.controller,
    this.padding=const EdgeInsets.symmetric(vertical: 10), 
    this.fontSize
  });
  @override
  State<StatefulWidget> createState() => PasswordFieldState();
}
class PasswordFieldState extends State<PasswordField>{
  bool ishidden=true;
  final FocusNode _focusNode = FocusNode();
  String? _error;
  void togglevisibility(){
    setState(() {
      ishidden=!ishidden;
    });
  }
  void validate(){
    if (_error != null) return;
    setState(() {
      _error=widget.controller.text.isEmpty? 'Password is required' : null;
    });
  }
  void updateError(String? error){
    setState(() {
      _error=error;
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
      padding: widget.padding,
      child: TextFormField(
        style: TextStyle(fontSize: widget.fontSize ?? rem(context, 0.9)),
        focusNode: _focusNode,
        controller: widget.controller,
        obscureText: ishidden,
        decoration: InputDecoration(
          label: Text("Password"),
          hintText: "Enter your password",
          errorText: _error,
          suffixIcon: IconButton(
            onPressed: togglevisibility, 
            icon: Icon(ishidden? Icons.visibility: Icons.visibility_off,),
          ),
        ),
      ),
    );
  }
}