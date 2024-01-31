import 'package:flutter/material.dart';
import 'package:legends_schools_admin/helper/my_color.dart';
import 'package:legends_schools_admin/main/home_screen.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final _screens = [
    // Content for Home tab
    const HomeScreen(),
    const HomeScreen(),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      // final isSmallScreen = MediaQuery.sizeOf(context).width < 600;
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Legends Schools & Colleges",
            style: TextStyle(color: MyColor().whiteColor),
          ),
          backgroundColor: MyColor().mainColor,
        ),
        bottomNavigationBar: MediaQuery.of(context).size.width < 640
            ? BottomNavigationBar(
                currentIndex: _selectedIndex,
                unselectedItemColor: Colors.grey,
                selectedItemColor: Colors.indigoAccent,
                // called when one tab is selected
                onTap: (int index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                // bottom tab items
                items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.dashboard), label: 'Dashboard'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.person), label: 'Users'),
                    // BottomNavigationBarItem(
                    //     icon: Icon(Icons.post_add), label: 'Banner'),
                    // BottomNavigationBarItem(
                    //     icon: Icon(Icons.post_add), label: 'Feedbacks'),
                    // BottomNavigationBarItem(
                    //     icon: Icon(Icons.book), label: 'Booking'),
                    // BottomNavigationBarItem(
                    //     icon: Icon(Icons.book), label: 'Attendance'),
                    // BottomNavigationBarItem(
                    //     icon: Icon(Icons.sell), label: 'Buy Sell'),
                    // BottomNavigationBarItem(
                    //     icon: Icon(Icons.emoji_transportation), label: 'Transporter')
                  ])
            : null,
        body: Row(
          children: [
            if (MediaQuery.of(context).size.width >= 640)
              SizedBox(
                width: 120,
                child: NavigationRail(
                  onDestinationSelected: (int index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  selectedIndex: _selectedIndex,
                  destinations: const [
                    NavigationRailDestination(
                        icon: Icon(Icons.dashboard), label: Text('Dashboard')),
                    NavigationRailDestination(
                        icon: Icon(Icons.person), label: Text('Users')),
                    // NavigationRailDestination(
                    //     icon: Icon(Icons.post_add), label: Text('Banner')),
                    // NavigationRailDestination(
                    //     icon: Icon(Icons.feedback_rounded), label: Text('Feedbacks')),
                    // NavigationRailDestination(
                    //     icon: Icon(Icons.book), label: Text('Booking')),
                    // NavigationRailDestination(
                    //     icon: Icon(Icons.book), label: Text('Attendance')),
                    // NavigationRailDestination(
                    //     icon: Icon(Icons.sell), label: Text('Buy Sell')),
                    // NavigationRailDestination(
                    //     icon: Icon(Icons.emoji_transportation), label: Text('Transporter')),
                  ],
                  labelType: NavigationRailLabelType.all,
                  selectedLabelTextStyle:
                      const TextStyle(color: Colors.blueAccent, fontSize: 16),
                  selectedIconTheme:
                      const IconThemeData(color: Colors.blueAccent, size: 32),
                  unselectedLabelTextStyle: const TextStyle(),
                  leading: const Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      CircleAvatar(
                        radius: 20,
                        child: Icon(Icons.person),
                      ),
                    ],
                  ),
                ),
              ),
            Expanded(child: _screens[_selectedIndex])
          ],
        ),
      );
    });
  }
}
