import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:home_rent/helper.dart';
import 'package:home_rent/appartment_card.dart';
import 'package:http/http.dart' as http;
class AppartmentProvider with ChangeNotifier {
  bool _isloading=false,_hasmore=true;
  int _pagenum=1,_pageSize=10;
  bool get isloading=>_isloading;
  bool get hasmore=>_hasmore;
  String? _token;
  set hasmore(bool value)=>_hasmore=value;
  set pagenum(int value)=>_pagenum=value;
  List<Appartment> appartmentDataList = [];
  Future<void> fetchAppartments() async{
    if (_isloading || !_hasmore) return;
    _isloading = true;
    notifyListeners();
    try {
      final uri=Uri.parse('https://home-rent.runasp.net/apartments?pageNumber=$_pagenum&pageSize=$_pageSize');
      final response=await http.get(
        uri,
        headers: await _getHeaders()
      );
      if (response.statusCode==200) {
        final data=jsonDecode(response.body);
        final List<Appartment> newAppartments=(data['items'] as List).map((item)=>Appartment.fromJson(item)).toList();
        setState((){
          appartmentDataList.addAll(newAppartments);
          _pagenum++;
          _hasmore=data['hasNextPage'];
        });
      }else{
        throw Exception('Failed to load appartments');
      }
    } on Exception catch (e) {
      print(e);
    }
    finally{
      _isloading=false;
      notifyListeners();
    }
  }
  Future<void> _initToken() async{
    if (_token==null) {
      final pref=await FlutterSecureStorage().read(key: 'auth_token');
      _token=pref;
    }
  }
  Future<Map<String,String>> _getHeaders() async{
    await _initToken();
    return{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_token',
    };
  }
  List<Widget> get cards => appartmentDataList.map((data) => AppartmentCard(data: data)).toList();
  Appartment? _selectedAppartmentData;
  Appartment? get selectedAppartmentData => _selectedAppartmentData;
  void selectAppartment(Appartment data) {
    _selectedAppartmentData = data;
    notifyListeners();
  }
  void setState(void Function() fn) {
    fn();
    notifyListeners();
  }
}