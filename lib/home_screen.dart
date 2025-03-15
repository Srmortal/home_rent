import 'package:flutter/material.dart';
import 'package:home_rent/Home%20Page%20Tabs/home_tab.dart';
import 'package:home_rent/root.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => HomePageState();
  
}
class HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  int _hovered_index=-1;
  bool is_hovered1=false,is_hovered2=false;
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this); // Number of tabs
  }
  @override
  void dispose() {
    _tabController.dispose(); // Dispose the controller
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
    final double screenWidth=MediaQuery.of(context).size.width;
    final double screenHeight=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Root.card_bg_dark,
      appBar: AppBar(
        backgroundColor: Root.card_bg_dark,
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 1,vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(20),
                right: Radius.circular(20),
              ),
              color: is_hovered1? const Color.fromARGB(40, 54, 26, 216):Colors.transparent
            ),
            child: IconButton(
              onPressed: (){}, 
              onHover: (value)=>setState(() {
                is_hovered1=value;
              }),
              icon: Icon(
                Icons.search,
                color: is_hovered1? const Color.fromARGB(255, 54, 26, 216): Colors.white54,
              )
            ),
          ),
          Container(
            padding:  EdgeInsets.symmetric(horizontal: 1,vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(20),
                right: Radius.circular(20),
              ),
              color: is_hovered2? const Color.fromARGB(40, 54, 26, 216):Colors.transparent
            ),
            child: IconButton(
              onPressed: (){},
              onHover: (value)=>setState(() {
                is_hovered2=value;
              }),
              icon: Icon(
                Icons.notifications,
                color: is_hovered2? const Color.fromARGB(255, 54, 26, 216): Colors.white54,
              )
            ),
          ),
        ],
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage('https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&w=600'),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(2), 
          child: Divider(
            height: 2,
            thickness: 1,
            color: const Color.fromARGB(255, 22, 12, 213),
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
            HomeTab(),
            //Center(child: Text('Home Tab is in works')),
            Center(child: Text('Book Tab is in works')),
            Center(child: Text('Wishlist Tab is in works')),
            Center(child: Text('Account Tab is in works')),
          ]
        ),
      ),
      bottomNavigationBar: Container(
        height: screenHeight*0.1,
        decoration: BoxDecoration(
          color: Root.card_bg_dark,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -4),
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