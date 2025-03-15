import 'package:flutter/material.dart';
import 'package:home_rent/custom_card.dart';
import 'package:home_rent/helper.dart';
import 'package:home_rent/root.dart';

class HomeTab extends StatefulWidget{
  const HomeTab({super.key});

  @override
  State<StatefulWidget> createState() => HomeTabState();
}
class HomeTabState extends State<HomeTab>{
  @override
  Widget build(BuildContext context) {
    final double screenWidth=MediaQuery.of(context).size.width;
    final double screenHeight=MediaQuery.of(context).size.height;
    return LayoutBuilder(
      builder: (context,constraints) {
        print(constraints);
        return Container(
          width: screenWidth,
          height: screenHeight*0.5,
          padding: EdgeInsets.all((constraints.maxHeight*constraints.maxWidth)*(8/(screenWidth*screenHeight))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Explore Nearby', style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: screenHeight*0.01,),
              Text('See recommended properties based on your location.'),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth*(14/screenWidth),
                  vertical: constraints.maxHeight*(24/screenHeight)
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    fixedSize: Size(constraints.maxWidth, screenHeight*0.01),
                    textStyle: TextStyle(fontSize: 16)
                  ),
                  onPressed: (){
                    print('turn on location button pressed');
                  }, 
                  child: const Text('Turn on Location')
                ),
              ),
              SizedBox(height: screenHeight*0.01,),
              Text('Discover all listings and rental properties.',style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: screenHeight*0.01,),
              Text('Find a place that are spaces houses or apartments for rent and local insights in that area for right for you.',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    CustomCard(
                      image: Image.network('https://c4.wallpaperflare.com/wallpaper/213/429/111/5bd31f6711946-wallpaper-preview.jpg'), 
                      priceTag: "hs", 
                      address: "76", 
                      bedCount: 0, 
                      bathCount: 0, 
                      space: '0'
                    )
                  ],
                ),
              )
            ],
          ),
        );
      }
    );
  }
}