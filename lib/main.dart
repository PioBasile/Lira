import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test/firebase_options.dart';
import 'package:test/pages/firsttime.dart';
import 'package:test/pages/howitworks.dart';
import 'package:test/pages/recurring.dart';
import 'package:test/pages/register.dart';
import 'package:test/pages/home.dart';
import 'package:test/pages/login.dart';
import 'package:test/pages/payed.dart';
import 'package:test/pages/calendar.dart';
import 'package:test/pages/profile.dart';
import 'package:test/pages/graph.dart';
import 'package:test/services/auth/auth_gate.dart';
import 'package:test/services/calculations/calculations.dart';

// ----------------TO Continue--------------------


//--------------------To FIX---------------------
// -  why reccuring and category does not save in db in first time page

/* -------------------- SHIT TO DO ---------------------------------
- make the db work and link it with everything
- add settings page , maybe to delete account or some shit
- link graph to db
- on calendar possibility to see description and shit by pressing on day and per mounth how much u spent
- able to edit their shit on profile page + link it to db , except email
- add currency maybe , idk if good or no, if yes in setting page
- page how it works

-------------------AT THE END ------------------
- change language , setting page
- change theme , setting page

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
        '/login': (context) => Login(onTap: () {
              Navigator.pushNamed(context, '/register');
            }),
        '/calendar': (context) => const Calendar(),
        '/profile': (context) => const Profile(),
        '/graph': (context) => Graph(),
        '/firsttime': (context) => const FirstTime(),
        '/recuring': (context) => const RecurringPaymentsPage(),
        '/howitworks': (context) => const HowItWorks(),
      },
    );
  }
}
