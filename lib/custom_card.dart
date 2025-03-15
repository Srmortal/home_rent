import 'package:flutter/material.dart';
import 'package:home_rent/helper.dart';
import 'package:home_rent/root.dart';

class CustomCard extends StatefulWidget {
  final Image image;
  final String priceTag,address;
  final int bedCount,bathCount;
  final String space;
  const CustomCard({
    super.key, 
    required this.image, 
    required this.priceTag, 
    required this.address, 
    required this.bedCount, 
    required this.bathCount, 
    required this.space
  });
  @override
  State<StatefulWidget> createState() => CustomCardState();
}
class CustomCardState extends State<CustomCard> {
  bool is_hovered=false;
  bool favorite_clicked=false;
  @override
  Widget build(BuildContext context) {
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
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Root.card_bg_dark,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              offset: Root.card_shadow_dark.offset,
              blurRadius: 12,
              color: Color.fromRGBO(0, 0, 0, 0.147)
            )
          ]
        ),
        child: GestureDetector(
          onTap: () {
            print('card clicked');
          },
          child: Card(
            color: Root.input_bg_dark,
            elevation: is_hovered? 8:5,
            child: IntrinsicHeight(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                    child: Container(
                      width: double.infinity,
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.075
                      ),
                      child: Image(
                        image: widget.image.image,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.priceTag,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.address,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.bed_rounded,
                                    color: Colors.deepPurple,
                                  ),
                                  SizedBox(width: 4.25,),
                                  Text(
                                    '${widget.bedCount}',
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
                                    '${widget.bathCount}',
                                    style: TextStyle(
                                      fontSize: 14
                                    ),
                                  ),
                                  SizedBox(width: 8.5,),
                                  Icon(
                                    Icons.area_chart_rounded,
                                    color: Colors.deepPurple,
                                  ),
                                  SizedBox(width: 4.25,),
                                  Text(
                                    widget.space,
                                    style: TextStyle(
                                      fontSize: 14
                                    ),
                                  ),
                                  SizedBox(width: 8.5,),
                                ],
                              ),
                            )
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
                            style: IconButton.styleFrom(
                              foregroundColor: favorite_clicked? Colors.red : Colors.white54,
                              backgroundColor: Root.card_bg_dark,
                              hoverColor: Colors.red.withOpacity(0.2)
                            ),
                            onPressed: (){
                              setState(() {
                                favorite_clicked=!favorite_clicked;
                              });
                            }, 
                            icon: Icon(
                              favorite_clicked? Icons.favorite:Icons.favorite_border_outlined
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(child: Container(height: 10,))
              ],
            ),
            ),
          ),
        )
      ),
    );
  }
}
/* 
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Icon(
      Icons.bed_rounded
    ),
    Text(
      '${widget.bedCount}',
      style: TextStyle(
        fontSize: 14
      ),
    ),
    Icon(
      Icons.bathroom
    ),
    Text(
      '${widget.bathCount}',
      style: TextStyle(
        fontSize: 14
      ),
    ),
    Icon(
      Icons.area_chart_rounded
    ),
    Text(
      '${widget.bedCount}',
      style: TextStyle(
        fontSize: 14
      ),
    )
  ],
)
*/