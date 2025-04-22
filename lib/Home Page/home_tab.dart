import 'package:flutter/material.dart';
import 'package:home_rent/providers/appartment_provider.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget{
  const HomeTab({super.key});

  @override
  State<StatefulWidget> createState() => HomeTabState();
}
class HomeTabState extends State<HomeTab>{
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final homeProvider = Provider.of<AppartmentProvider>(context, listen: false);
      homeProvider.fetchAppartments();
    });
  }
  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<AppartmentProvider>(context);
    final double screenWidth=MediaQuery.of(context).size.width;
    final double screenHeight=MediaQuery.of(context).size.height;
    return LayoutBuilder(
      builder: (context,constraints) {
        return Container(
          width: screenWidth,
          height: screenHeight*0.8,
          padding: EdgeInsets.all((constraints.maxHeight*constraints.maxWidth)*(8/(screenWidth*screenHeight))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Explore Nearby', style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: screenHeight*0.01,),
              const Text('See recommended properties based on your location.'),
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
                    textStyle: const TextStyle(fontSize: 16)
                  ),
                  onPressed: (){
                    print('turn on location button pressed');
                  }, 
                  child: const Text('Turn on Location')
                ),
              ),
              SizedBox(height: screenHeight*0.01,),
              const Text('Discover all listings and rental properties.',style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: screenHeight*0.01,),
              const Text('Find a place that are spaces houses or apartments for rent and local insights in that area for right for you.',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5
                ),
              ),
              Expanded(
                child: homeProvider.isloading && homeProvider.appartmentDataList.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : homeProvider.appartmentDataList.isEmpty
                        ? Center(child: Text('No Home to rent'))
                        : SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ...homeProvider.cards,
                                if (homeProvider.hasmore)
                                  Center(child: CircularProgressIndicator()),
                              ],
                            ),
                          ),
              ),
            ],
          ),
        );
      }
    );
  }
}