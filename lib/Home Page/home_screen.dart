import 'package:flutter/material.dart';
import 'package:home_rent/Home%20Page/home_tab.dart';
import 'package:home_rent/Sign%20Up%20Page/page.dart';
import 'package:home_rent/custom_icon_button.dart';
import 'package:home_rent/providers/auth_provider.dart';
import 'package:home_rent/providers/fav_provider.dart';
import 'package:home_rent/helper.dart';
import 'package:provider/provider.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import '../providers/user_provider.dart' show UserProvider;

class HomePage extends StatefulWidget{
  const HomePage({super.key});
  @override
  State<StatefulWidget> createState() => HomePageState();
}
class HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  int _hovered_index=-1;
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  Widget _buildNavItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index
  }){
    final bool isSelected = _tabController.index == index; // Check if item is selected
    final bool isHovered = _hovered_index == index;
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          _hovered_index=index;
        });
      },
      onExit: (event) {
        setState(() {
          _hovered_index=-1;
        });
      },
      child: GestureDetector(
        onTap: (){
          setState(() {
            _tabController.index=index;
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isSelected? activeIcon:icon,
                color: isSelected||isHovered? Root.primary_color_dark:Colors.white54,
              ),
              SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isHovered||isSelected? Root.primary_color_dark:Colors.white54
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final userProvider=Provider.of<UserProvider>(context);
    final double screenWidth=MediaQuery.of(context).size.width;
    final double screenHeight=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Root.card_bg_dark,
      appBar: AppBar(
        backgroundColor: Root.card_bg_dark,
        actions: [
          iconButton(iconData: Icons.search, onPressed: (){}),
          iconButton(iconData: Icons.notifications, onPressed: (){}),
        ],
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: userProvider.profileImage==null? 
          CircleAvatar(
            radius: 20,
            backgroundColor: getRandomColor(userProvider.Email),
            child: Icon(Icons.person,color: Colors.white,),
          ):
          ProfilePicture(
            name: userProvider.firstName!, 
            radius: 20, 
            fontsize: 16,
            img: userProvider.profileImage,
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(2), 
          child: Divider(
            height: 2,
            thickness: 1,
            color: Color.fromARGB(255, 22, 12, 213),
          ),
        ),
      ),
      body: Container(
        width: screenWidth,
        height: screenHeight,
        padding: EdgeInsets.symmetric(horizontal: screenWidth*0.05,vertical: screenHeight*0.01),
        child: IndexedStack(
          index: _tabController.index,
          children: [
            const HomeTab(),
            const Center(child: Text('Book Tab is in works')),
            favoriteProvider.fav_list.isNotEmpty? SizedBox(
              height: screenHeight*0.8,
              child: ListView.builder(
                itemCount: favoriteProvider.fav_list.length,
                itemBuilder: (context, index){
                  return favoriteProvider.fav_list[index];
                }
              ),
            ):const Center(child: Text('No home in wishlist'),),
            Center(child: TextButton(
              onPressed: () async{
                await authProvider.clearAll();
                await Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context)=>RegisterPage()
                  )
                );
              },
              child: Text('Account Tab is in works')
              )
            ),
          ]
        ),
      ),
      bottomNavigationBar: Container(
        height: screenHeight*0.1,
        decoration: BoxDecoration(
          color: Root.card_bg_dark,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, -4),
              blurRadius: 12,
              color: Color.fromRGBO(0, 0, 0, 0.147)
            )
          ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              icon: Icons.home_outlined, 
              activeIcon: Icons.home, 
              label: "Home", 
              index: 0
            ),
            _buildNavItem(
              icon: Icons.calendar_today, 
              activeIcon: Icons.calendar_month, 
              label: "Book", 
              index: 1
            ),
            _buildNavItem(
              icon: Icons.favorite_border, 
              activeIcon: Icons.favorite, 
              label: "Wishlist", 
              index: 2
            ),
            _buildNavItem(
              icon: Icons.person_outlined, 
              activeIcon: Icons.person, 
              label: "Account", 
              index: 3
            )
          ],
        ),
      ),
    );
  }
}