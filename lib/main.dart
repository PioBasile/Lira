import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lira/firebase_options.dart';
import 'package:lira/pages/firsttime.dart';
import 'package:lira/pages/howitworks.dart';
import 'package:lira/pages/recurring.dart';
import 'package:lira/pages/register.dart';
import 'package:lira/pages/home.dart';
import 'package:lira/pages/login.dart';
import 'package:lira/pages/payed.dart';
import 'package:lira/pages/calendar.dart';
import 'package:lira/pages/profile.dart';
import 'package:lira/pages/graph.dart';
import 'package:lira/pages/settings.dart';
import 'package:lira/pages/history.dart';
import 'package:lira/services/auth/auth_gate.dart';
import 'package:lira/services/calculations/calculations.dart';

// ----------------TO Continue--------------------
//- settings page!!!

//--------------------To FIX---------------------
//calculate one time per month the salary , add something to track it per month and year
//shit is not getting recieved payments


/* -------------------- TO DO ---------------------------------
- add way to delete a payment
- app logo from home page
- forgot pass (check yt)
- add settings page , maybe to delete account or some shit
- add currency maybe , idk if good or no, if yes in setting page
- maybe add more graphs , possibilty to switch between month view and day view, maybe add a received and payed graph 
  and a whole month view , day by day (batton and shit) 
- add annotations in the code
- in history, check the style with ppl

-------------------AT THE END ------------------
- change language , setting page
- change theme , setting page
- change currency , setting page

*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await loadAllData();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      routes: {
        '/home': (context) => const Home(),
        
        '/register': (context) =>const Register(),
        
        '/addpage': (context) => const Payed(),
        
        '/login': (context) => Login(
          onTap: () {
              Navigator.pushNamed(context, '/register');
            }
        ),
        
        '/calendar': (context) => const Calendar(),
        
        '/profile': (context) => const Profile(),
        
        '/graph': (context) => const Graph(),
        
        '/firsttime': (context) => const FirstTime(),
        
        '/recuring': (context) => const RecurringPaymentsPage(),
        
        '/howitworks': (context) => const HowItWorks(),
        
        '/history': (context) => const History(),

        '/settings': (context) => const Settings(),
      },
    );
  }
}
