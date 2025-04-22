
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:home_rent/helper.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  String? _auth_token,_refresh_token;
  DateTime? _refresh_token_expiration;
  final FlutterSecureStorage _storage=FlutterSecureStorage();
  String? get auth_token=>_auth_token;
  String? get refresh_auth_token=>_refresh_token;
  bool get isAuth=>_auth_token!=null&&_refresh_token!=null;
  Future<void> setToken(UserData data) async{
    _auth_token=data.token;
    _refresh_token=data.refreshtoken;
    _refresh_token_expiration=data.refreshtokenexpiration;
    await _storage.write(key: 'auth_token', value: _auth_token);
    await _storage.write(key: 'auth_refresh_token', value: _refresh_token);
    await _storage.write(key: 'auth_refresh_token_expiration', value: _refresh_token_expiration?.toIso8601String());
    notifyListeners();
  }
  Future<void> loadToken() async{
    _auth_token = await _storage.read(key: 'auth_token');
    _refresh_token=await _storage.read(key: 'auth_refresh_token');
    final refresh_expiration=await _storage.read(key: 'auth_refresh_token_expiration');
    _refresh_token_expiration=refresh_expiration!=null? DateTime.parse(refresh_expiration):null;
    if(_refresh_token_expiration != null && DateTime.now().isAfter(_refresh_token_expiration!)){
      if(_auth_token!=null){
        await clear();
        await RefreshToken();
      }else{
        await clearAll();
      }
    }
    notifyListeners();
  }
  Future<void> RefreshToken() async{
    final token = await _storage.read(key: 'auth_token');
    final refresh_token=await _storage.read(key: 'auth_refresh_token');
    final response = await http.post(
      Uri.parse('https://home-rent.runasp.net/auth/refresh'),
      headers: {'Content-Type':'application/json'},
      body: {
        'token':token!,
        'RefreshToken':refresh_token!
      }
    );
    final responseData=jsonDecode(response.body);
    if (response.statusCode==200) {
      final authData=UserData.fromJson(responseData);
      setToken(authData);
    }else{
      throw Exception('no token found');
    }
  }
  Future<void> clear() async{
    _refresh_token=null;
    _refresh_token_expiration=null;
    await _storage.delete(key: 'auth_token_expire_in');
    await _storage.delete(key: 'auth_token_expiration_time');
    await _storage.delete(key: 'auth_refresh_token_expiration');
    notifyListeners();
  }
  Future<void> clearAll() async{
    _auth_token=null;
    _refresh_token=null;
    _refresh_token_expiration=null;
    await _storage.delete(key: 'auth_token');
    await _storage.delete(key: 'auth_token_expire_in');
    await _storage.delete(key: 'auth_token_expiration_time');
    await _storage.delete(key: 'auth_refresh_token');
    await _storage.delete(key: 'auth_refresh_token_expiration');
    notifyListeners();
  }
}