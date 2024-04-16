import 'package:flutter/material.dart';
import 'package:test/pages/payed.dart';
import 'package:test/pages/received.dart';
import 'package:test/services/auth/auth_service.dart';


class Home extends StatefulWidget {
    
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List _pages = [
    const Payed(),
    const Received()
  ];

  void _goToGraph() {
    Navigator.pushNamed(context, '/graph');
  }

  void _goToCalendar() {
    Navigator.pushNamed(context, '/calendar');
  }

  void _goToProfile() {
    Navigator.pushNamed(context, '/profile');
  }

  int _pageindex = 0;

  void _changePageIndex(int index) {
    setState(() {
      _pageindex = index;
    });
  }

  void _goToHome() {
    Navigator.pushNamed(context, '/home');
  }

  void logout(){
    final authservice = AuthService();
    authservice.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Home', style: TextStyle(
              color: Colors.white,
              ),
            ),
            backgroundColor: const Color.fromARGB(255, 18, 18, 18),
            iconTheme: const IconThemeData(color: Colors.white),
          ),

          body: _pages[_pageindex],

          backgroundColor: const Color.fromARGB(255, 18, 18, 18),
          drawer: Drawer(
              backgroundColor: const Color.fromARGB(255, 54, 53, 53),
              child: Column(
                children: [
                  
                  const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min, 
                      children: [
                        SizedBox(height: 50),
                        Padding(
                          padding: EdgeInsets.only(top: 25),
                            child :Image(
                              image: AssetImage('lib/images/Lira-Name-Only.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        SizedBox(height: 5),
                        Divider(
                            color: Color.fromARGB(255, 173, 170, 170),
                            thickness: 2,
                            indent: 20,
                            endIndent: 20,
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        ListTile(
                          title: const Text('Home'),
                          leading: const Icon(Icons.home),
                          textColor: Colors.white,
                          iconColor: Colors.white,
                          onTap: _goToHome,
                        ),
                    
                        const SizedBox(height: 10),
                        ListTile(
                          title:  const Text('Calendar'),
                          textColor: Colors.white,
                          iconColor: Colors.white,
                          leading: const Icon(Icons.date_range_rounded),
                          onTap: _goToCalendar,
                        ),
                    
                        const SizedBox(height: 10),
                        ListTile(
                          title: const Text('Graphs'),
                          textColor: Colors.white,
                          iconColor: Colors.white,
                          leading: const Icon(Icons.data_usage_rounded),
                          onTap: _goToGraph,
                        ),
                        
                        const SizedBox(height: 10),
                        ListTile(
                          title: const Text('Profile'),
                          textColor: Colors.white,
                          iconColor: Colors.white,
                          leading: const Icon(Icons.person_outlined),
                          onTap: _goToProfile,
                        ),
                    
                        const SizedBox(height: 10),
                        const ListTile(
                          title: Text('Settings'),
                          textColor: Colors.white,
                          iconColor: Colors.white,
                          leading: Icon(Icons.settings),
                          onTap: null,
                        ),
                        
                        const SizedBox(height: 230),
                        ListTile(
                          title: const Text('Log Out'),
                          textColor: Colors.white,
                          iconColor: Colors.white,
                          leading: const  Icon(Icons.logout),
                            onTap: logout,
                        ),
                      ],
                                    ),
                  )
              ]
            )
          ),
        
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageindex,
        onTap: _changePageIndex,
        backgroundColor: const Color.fromARGB(255, 18, 18, 18),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.payment_rounded),
            label: 'Payed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_card_rounded),
            label: 'Received',
          ),
        ],
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color.fromARGB(255, 134, 132, 132),
        unselectedIconTheme: const IconThemeData(color: Color.fromARGB(255, 134, 132, 132),),
        selectedIconTheme: const IconThemeData(color: Colors.white),
        
      ),
    )
  );
  }
}
