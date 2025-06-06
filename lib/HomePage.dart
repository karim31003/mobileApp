import 'package:flutter/material.dart';
import 'package:one/MoreScreen.dart';
import 'CarSearchScreen.dart';
import 'brands_screen.dart';
import 'calculator.dart';
import 'car_types_page.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    CarSearchScreen(),
    // DashboardScreen(),
    Morescreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.blueAccent,
          backgroundColor: Colors.white,
          labelTextStyle: MaterialStateProperty.all(
        TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        child: NavigationBar(
          height: 73,
          selectedIndex: _currentIndex,
          onDestinationSelected: (int index) {
        setState(() {
          _currentIndex = index;
        });
          },
          
          destinations: [
        NavigationDestination(
          icon: Icon(Icons.directions_car),
          label: "Buy a Car",
        ),
        NavigationDestination(
          icon: Icon(Icons.search),
          label: "Research",
        ),
        // NavigationDestination(
        //   icon: Icon(Icons.dashboard),
        //   label: "Dashboard",
        // ),
        NavigationDestination(
          icon: Icon(Icons.more_horiz),
          label: "More",
        ),
          ],
        ),
      ),
      );
    
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        title: Row(
          children: [
            Icon(Icons.directions_car, color: Colors.white),
            SizedBox(width: 8),
            Text("CarFlow", style: TextStyle(color: Colors.white, fontSize: 20)),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Find a Great Deal",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 45),
            Center(
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Shop By", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue.shade700,
                            Colors.blue.shade400,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => BrandsScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          minimumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          "Model Search",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(height: 17),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue.shade700,
                            Colors.blue.shade400,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CarTypesPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          minimumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          "Category Search",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// باقي الصفحات في شريط التنقل السفلي

// class ResearchScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Research")),
//       body: Center(child: Text("Research Page", style: TextStyle(fontSize: 34))),
//     );
//   }
// }

// class DashboardScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Dashboard")),
//       body: Center(child: Text("Dashboard Page", style: TextStyle(fontSize: 24))),
//     );
//   }
// }

// class MoreScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("More")),
//       backgroundColor: Colors.blueAccent,
//       body: Center(child: Text("More Page", style: TextStyle(fontSize: 24))),
//     );
//   }
// }

// صفحة MAKE & MODEL
// class MakeModelPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Select Make & Model"),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: ListView(
//         children: const [
//           ListTile(title: Text("Toyota - Corolla")),
//           ListTile(title: Text("Honda - Civic")),
//           ListTile(title: Text("Ford - Focus")),
//           ListTile(title: Text("BMW - 3 Series")),
//         ],
//       ),
//     );
//   }
// }