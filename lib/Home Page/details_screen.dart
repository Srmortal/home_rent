import 'package:flutter/material.dart';
import 'package:home_rent/custom_icon_button.dart';
import 'package:home_rent/helper.dart';
import 'package:home_rent/providers/fav_provider.dart';
import 'package:home_rent/providers/appartment_provider.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<StatefulWidget> createState() => DetailsScreenState();
}
class DetailsScreenState extends State<DetailsScreen> {
  bool is_hovered=false;
  @override
  Widget build(BuildContext context) {
    final homeProvider=Provider.of<AppartmentProvider>(context);
    final favoriteProvider=Provider.of<FavoriteProvider>(context);
    final isFav=favoriteProvider.is_fav(homeProvider.selectedAppartmentData!);
    return Scaffold(
      backgroundColor: Root.card_bg_dark,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Root.card_bg_dark,
        actions: [
          iconButton(
            iconData: Icons.arrow_back, 
            onPressed: (){
              Navigator.pop(context);
            }
          ),
          Spacer(),
          iconButton(
            iconData: Icons.more_horiz, 
            onPressed: () {},
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(2), 
          child: Divider(
            height: 2,
            thickness: 1,
            color: Color.fromARGB(255, 22, 12, 213),
          ),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          homeProvider.selectedAppartmentData!.image!=null? homeProvider.selectedAppartmentData!.image!:Text(''),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 1,vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(20),
                        right: Radius.circular(20),
                      ),
                      color: is_hovered? const Color.fromARGB(40, 54, 26, 216):Colors.transparent
                    ),
                    child: IconButton(
                      onPressed: (){
                        favoriteProvider.toggleCard(homeProvider.selectedAppartmentData!);
                      },
                      onHover: (value)=>setState(() {
                        is_hovered=value;
                      }),
                      icon: Icon(
                        isFav? Icons.favorite:Icons.favorite_border,
                        color: is_hovered? const Color.fromARGB(255, 54, 26, 216):
                          isFav? Colors.red:Colors.white54,
                      )
                    ),
                  ),
                  iconButton(
                    iconData: Icons.share, 
                    onPressed: (){
                      print('share');
                    }
                  )
                ],
              ),
              Divider(
                color: const Color.fromARGB(255, 22, 12, 213),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      homeProvider.selectedAppartmentData!.priceTag,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  const Spacer(),
                  homeProvider.selectedAppartmentData!.priceCut!=null? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color.fromARGB(55, 244, 67, 54)
                      ),
                      child: Text(
                        'Price Cut: ${homeProvider.selectedAppartmentData!.priceCut}',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ):Text('')
                ],
              ),
              Divider(
                color: const Color.fromARGB(255, 22, 12, 213),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.bed_rounded,
                      color: Colors.deepPurple,
                    ),
                    const SizedBox(width: 6,),
                    Text(
                      '${homeProvider.selectedAppartmentData!.bedCount} beds',
                      style: const TextStyle(
                        fontSize: 14
                      ),
                    ),
                    const SizedBox(width: 10,),
                    const Icon(
                      Icons.bathroom_rounded,
                      color: Colors.deepPurple,
                    ),
                    const SizedBox(width: 7,),
                    Text(
                      '${homeProvider.selectedAppartmentData!.bathCount} baths',
                      style: const TextStyle(
                        fontSize: 14
                      ),
                    ),
                    const SizedBox(width: 10,),
                    const Icon(
                      Icons.directions_car,
                      color: Colors.deepPurple,
                    ),
                    const SizedBox(width: 7,),
                    Text(
                      '${homeProvider.selectedAppartmentData!.carCount!=null? homeProvider.selectedAppartmentData!.carCount!:0} cars',
                      style: const TextStyle(
                        fontSize: 14
                      ),
                    ),
                    const SizedBox(width: 10,),
                    const Icon(
                      Icons.grid_on,
                      color: Colors.deepPurple,
                    ),
                    const SizedBox(width: 7,),
                    Text(
                      homeProvider.selectedAppartmentData!.space,
                      style: const TextStyle(
                        fontSize: 14
                      ),
                    ),
                    const SizedBox(width: 10,),
                  ],
                ),
              )
            ],
          ),
          Divider(
            color: const Color.fromARGB(255, 22, 12, 213),
          ),
          homeProvider.selectedAppartmentData!.description!=null? 
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    homeProvider.selectedAppartmentData!.description!,
                    style: TextStyle(
                      fontSize: 14
                    ),
                  ),
                ),
                Divider(
                  color: const Color.fromARGB(255, 22, 12, 213),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          fixedSize: Size(MediaQuery.of(context).size.width*0.35,MediaQuery.of(context).size.height*0.05),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              width: 1.5,
                              color: Colors.white38
                            ),
                            borderRadius: BorderRadius.circular(50)
                          )
                        ),
                        onPressed: (){
                          print('contact');
                        }, 
                        child: const Text(
                          'Contact',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16
                          ),
                        )
                      ),
                      Spacer(),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(MediaQuery.of(context).size.width*0.6,MediaQuery.of(context).size.height*0.05),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)
                          )
                        ),
                        onPressed: (){
                          print('requested');
                        }, 
                        child: const Text(
                          'Request a tour',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                          ),
                        )
                      )
                    ],
                  ),
                )
              ],
            ):
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Root.card_bg_dark,
                      elevation: 0,
                      fixedSize: Size(MediaQuery.of(context).size.width*0.35,MediaQuery.of(context).size.height*0.05),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1.5,
                          color: Colors.white38
                        ),
                        borderRadius: BorderRadius.circular(50)
                      )
                    ),
                    onPressed: (){
                      print('contact');
                    }, 
                    child: const Text(
                      'Contact',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16
                      ),
                    )
                  ),
                  Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width*0.6,MediaQuery.of(context).size.height*0.05),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)
                      )
                    ),
                    onPressed: (){
                      print('requested');
                    }, 
                    child: const Text(
                      'Request a tour',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                      ),
                    )
                  )
                ],
              ),
            )
        ],
      )
    );
  }
}