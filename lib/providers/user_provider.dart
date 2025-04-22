import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:io' show Platform;
import 'package:home_rent/helper.dart';
import 'package:home_rent/providers/auth_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_android/shared_preferences_android.dart';

class UserProvider extends ChangeNotifier {
  AuthProvider? _authProvider;
  final ImageUploader _imageUploader=ImageUploader();
  final FlutterSecureStorage _secureStorage=FlutterSecureStorage();
  SharedPreferences? _prefs;
  String? _firstname,_lastname,_email,_userId,_firebaseImgUrl,_localImgPath;
  String? get userID=>_userId;
  String? get firstName=>_firstname;
  String? get lastName=>_lastname;
  String? get Email=>_email;
  String? get profileImage=>_firebaseImgUrl??_localImgPath;
  UserProvider(this._authProvider){
    scheduleMicrotask(()=>init());
    _authProvider?.addListener(_onAuthChange);
  }
  Future<void> init() async{
    if(Platform.isAndroid){
      SharedPreferencesAndroid.registerWith();
    }
    _prefs=await SharedPreferences.getInstance();
    await _loadData();
    notifyListeners();
  }
  Future<void> uploadProfileImage(ImageSource img) async{
    try {
      final file=await _imageUploader.pickImage(source: img);
      if(file==null) return;
      final downloadurl=await _imageUploader.uploadImage(
        ImageFile: file, 
        ID: _userId!, 
        UploadType: 'profile_pics'
      );
      if(downloadurl!=null){
        _firebaseImgUrl=downloadurl;
        _localImgPath=file.path;
      }
    } on Exception catch (e) {
      throw Exception('Profile failed to update error: ${e.toString()}');
    }
    notifyListeners();
  }
  void updateAuth(AuthProvider? auth) async{
    if (_authProvider != auth) {
      _authProvider?.removeListener(_onAuthChange); // Remove old listener
      _authProvider = auth;
      _authProvider?.addListener(_onAuthChange);    // Add new listener
      await _loadData();
      notifyListeners();
    }
  }
  Future<void> setData(UserData data) async{
    if(_prefs==null){
      await init();
    }
    await _prefs?.setString("first_name", data.firstname);
    await _prefs?.setString("last_name", data.lastname);
    await _prefs?.setString("email", data.email);
    await _secureStorage.write(key: "UserID", value: data.userID);
    _firstname=data.firstname;
    _lastname=data.lastname;
    _email=data.email;
    _userId=data.userID;
    notifyListeners();
  }
  Future<void> _loadData() async{
    _firstname=_prefs?.getString("first_name");
    _lastname=_prefs?.getString("last_name");
    _email=_prefs?.getString("email");
    _userId=await _secureStorage.read(key: "UserID");
    notifyListeners();
  }
  void _onAuthChange() async{
    if(!_authProvider!.isAuth){
      await _clearData();
      notifyListeners();
    }
  }
  Future<void> _clearData() async{
    _firstname=_lastname=_email=_userId=null;
    notifyListeners();
  }
  @override
  void dispose() {
    _authProvider?.removeListener(_onAuthChange);
    super.dispose();
  }
}