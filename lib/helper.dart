import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
double rem(BuildContext context, double remValue, {double baseSize = 16}) {
  double scale = MediaQuery.of(context).size.width / 360; // 360 is a common Android width
  return remValue * baseSize * scale;
}
Alignment getAlignmentFromDegrees(double degrees) {
  double radians = degrees * (pi / 180);
  double x = cos(radians);
  double y = sin(radians);
  return Alignment(-x, y);
}
class Root{
  static const Color primary_color_dark=Color(0xff6a11cb),
  primary_hover_dark=Color(0xff5211a8),
  error_color=Color(0xffff4d4d),input_bg_dark=Color(0xff333344);
  static const double broder_radius=8;
  static const text_secondary=Color(0xffcccccc),
  input_border=Color(0xff444455),
  card_bg_dark=Color(0xff2a2a3a);
  static const BoxShadow card_shadow_dark= BoxShadow(
    offset: Offset(0, 8),
    blurRadius: 20,
    color: Color.fromRGBO(80, 27, 107, 0.858)
  );
  static const BoxShadow card_shadow_hover=BoxShadow(
    offset: Offset(0, 12),
    blurRadius: 24,
    color: Color.fromRGBO(0, 0, 0, 0.1)
  );
}
class Appartment {
  final String id;
  final Image? image;
  final String priceTag,address;
  final int bedCount,bathCount;
  final int? carCount;
  final String space;
  final String? priceCut,description;
  const Appartment(this.id, 
  {
    this.priceCut,
    this.carCount,
    this.description,
    this.image, 
    required this.priceTag, 
    required this.address, 
    this.bedCount=0, 
    this.bathCount=0, 
    this.space='0 sqft'
  });
  factory Appartment.fromJson(Map<String,dynamic> json){
    return Appartment(
      json['id'], 
      priceTag: "\$${json['price']}", 
      address: json['location'],
      description: json['description']
    );
  }
}
class UserData {
  String userID,firstname,lastname,email,token,refreshtoken;
  DateTime refreshtokenexpiration;
  int expireIn;
  UserData({
    required this.userID,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.token,
    required this.refreshtoken,
    required this.refreshtokenexpiration,
    required this.expireIn
  });
  factory UserData.fromJson(Map<String,dynamic> json){
    return UserData(
      userID: json['id'], 
      firstname: json['firstName'], 
      lastname: json['lastName'], 
      email: json['email'], 
      token: json['token'], 
      refreshtoken: json['refeshToken'], 
      refreshtokenexpiration: DateTime.parse(json['refreshTokenExpirations']), 
      expireIn: json['expireIn']
    );
  }
}
class ImageUploader{
  final FirebaseStorage _storage=FirebaseStorage.instance;
  Future<File?> pickImage({required ImageSource source}) async{
    try {
      final ImagePicker picker=ImagePicker();
      final XFile? pickedfile=await picker.pickImage(source: source);
      if(pickedfile==null) return null;
      if(kIsWeb){
        final byte=await pickedfile.readAsBytes();
        return File.fromRawPath(byte);
      }
      return File(pickedfile.path);
    }
    on PlatformException catch(e){
      throw Exception('Failed to pick image: ${e.message}');
    } 
    on Exception catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
  Future<String?> uploadImage(File ImageFile,String userId) async{
    try {
      String filename='${DateTime.now().microsecondsSinceEpoch}.jpg';
      Reference storageref=_storage.ref().child('user_images/$userId/$filename');
      UploadTask uploadTask;
      if(kIsWeb){
        Uint8List bytes=await ImageFile.readAsBytes();
        uploadTask= storageref.putData(bytes);
      }
      else {
        uploadTask=storageref.putFile(ImageFile);
      }
      TaskSnapshot snapshot=await uploadTask;
      if(snapshot.state==TaskState.success){
        String downloadUrl=await storageref.getDownloadURL();
        return downloadUrl;
      }
    } on Exception catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
    return null;
  }
}