import 'package:flutter/material.dart';
import 'package:home_rent/Home%20Page/details_screen.dart';
import 'package:home_rent/providers/fav_provider.dart';
import 'package:home_rent/helper.dart';
import 'package:home_rent/providers/appartment_provider.dart';
import 'package:provider/provider.dart';

class AppartmentCard extends StatefulWidget {
  final Appartment data;
  const AppartmentCard({
    super.key, 
    required this.data, 
  });
  @override
  State<StatefulWidget> createState() => AppartmentCardState();
}
class AppartmentCardState extends State<AppartmentCard> {
  bool is_hovered=false,fav_hover=false;
  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<AppartmentProvider>(context, listen: false);
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final isFav=favoriteProvider.is_fav(widget.data);
    final screenHeight=MediaQuery.of(context).size.height;
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          is_hovered=true;
        });
      },
      onExit: (event) {
        setState(() {
          is_hovered=false;
        });
      },
      cursor: is_hovered? SystemMouseCursors.click:MouseCursor.defer,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              offset: Offset(0,Root.card_shadow_dark.offset.dy-12),
              blurRadius: 12,
              color: const Color.fromRGBO(0, 0, 0, 0.059)
            )
          ]
        ),
        padding: const EdgeInsets.only(bottom: 10),
        child: GestureDetector(
          onTap: () async{
            homeProvider.selectAppartment(widget.data);
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context)=>DetailsScreen()
              )
            );
          },
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: is_hovered ? -8 : 0),
            duration: const Duration(milliseconds: 200),
            builder: (context, double translation, child) {
              return Transform.translate(
                offset: Offset(0, translation),
                child: Card(
                  color: Root.input_bg_dark,
                  elevation: is_hovered? 8:4,
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.data.image!=null? ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                          child: Container(
                            width: double.infinity,
                            constraints: BoxConstraints(
                              maxHeight: screenHeight * 0.075
                            ),
                            child: Image(
                              image: widget.data.image!.image,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ):SizedBox(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.data.priceTag,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    widget.data.address,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Root.card_shadow_dark.color,
                                      spreadRadius: -2.5,
                                      blurRadius: 3,
                                      blurStyle: BlurStyle.solid
                                    )
                                  ]
                                ),
                                child: IconButton(
                                  onHover: (value) {
                                    setState(() {
                                      fav_hover=value;
                                    });
                                  },
                                  style: IconButton.styleFrom(
                                    foregroundColor: isFav||fav_hover? Colors.red : Colors.white54,
                                    backgroundColor: Root.card_bg_dark,
                                    hoverColor: Colors.red.withOpacity(0.1),
                                    shadowColor: Root.card_shadow_dark.color,
                                    elevation: 3
                                  ),
                                  onPressed: (){
                                    favoriteProvider.toggleCard(widget.data);
                                  }, 
                                  icon: Icon(
                                    isFav? Icons.favorite:Icons.favorite_border_outlined
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.bed_rounded,
                                color: Colors.deepPurple,
                              ),
                              SizedBox(width: 4.25,),
                              Text(
                                '${widget.data.bedCount}',
                                style: TextStyle(
                                  fontSize: 14
                                ),
                              ),
                              SizedBox(width: 8.5,),
                              Icon(
                                Icons.bathroom_rounded,
                                color: Colors.deepPurple,
                              ),
                              SizedBox(width: 4.25,),
                              Text(
                                '${widget.data.bathCount}',
                                style: TextStyle(
                                  fontSize: 14
                                ),
                              ),
                              SizedBox(width: 8.5,),
                              Icon(
                                Icons.grid_on,
                                color: Colors.deepPurple,
                              ),
                              SizedBox(width: 4.25,),
                              Text(
                                widget.data.space,
                                style: TextStyle(
                                  fontSize: 14
                                ),
                              ),
                              SizedBox(width: 8.5,),
                            ],
                          ),
                        ),
                        Expanded(child: Container())
                    ],
                  ),
                  ),
                ),
              );
            }
          ),
        )
      ),
    );
  }
}