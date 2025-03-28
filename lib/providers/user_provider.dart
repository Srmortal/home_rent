import 'package:flutter/material.dart';
import 'package:home_rent/helper.dart';
import 'package:home_rent/providers/auth_provider.dart';

class UserProvider extends ChangeNotifier {
  AuthProvider? _authProvider;
  String? _firstname,_lastname,_email,_userId;
  String? get userID=>_userId;
  String? get firstName=>_firstname;
  String? get lastName=>_lastname;
  String? get Email=>_email;
  UserProvider(this._authProvider){
    _authProvider?.addListener(_onAuthChange);
  }
  void updateAuth(AuthProvider? auth){
    if (_authProvider != auth) {
      _authProvider?.removeListener(_onAuthChange); // Remove old listener
      _authProvider = auth;
      _authProvider?.addListener(_onAuthChange);    // Add new listener
      notifyListeners();
    }
  }
  void setData(UserData data) {
    _firstname=data.firstname;
    _lastname=data.lastname;
    _email=data.email;
    _userId=data.userID;
    notifyListeners();
  }
  void _onAuthChange(){
    if(!_authProvider!.isAuth){
      _clearData();
    }
  }
  void _clearData(){
    _firstname=_lastname=_email=_userId=null;
    notifyListeners();
  }
  @override
  void dispose() {
    _authProvider?.removeListener(_onAuthChange);
    super.dispose();
  }
}