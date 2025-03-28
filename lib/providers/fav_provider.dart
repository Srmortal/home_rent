import 'package:flutter/material.dart';
import 'package:home_rent/helper.dart';
import 'package:home_rent/appartment_card.dart';

class FavoriteProvider with ChangeNotifier {
  List<Appartment> fav_list_data=[];
  void toggleCard(Appartment card){
    if (fav_list_data.contains(card)) {
      fav_list_data.remove(card);
    }else{
      fav_list_data.add(card);
    }
    notifyListeners();
  }
  bool is_fav(Appartment card){
    return fav_list_data.contains(card);
  }
  List<Widget> get fav_list => fav_list_data.map((data) => AppartmentCard(data: data)).toList();
}