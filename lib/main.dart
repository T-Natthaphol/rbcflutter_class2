import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rbcknightflutter/pages/authentication_page.dart';
import 'package:rbcknightflutter/pages/usersignup_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.lightGreen[800],
          centerTitle: true,
          titleTextStyle: TextStyle(color: Colors.white),
        ),
      ),
      title: 'Home Page',
      routes: {
        '/usersignup': (context) => UserSignupPage(),
        // '/homework': (context) => HomeworkPage(),
      },
      home: AuthenPage(), //
      // home: Testpage(),
      //TodoListPage()
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color myColor = Colors.amber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // CircleAvatar(child: Image.network('https://en.wikipedia.org/wiki/Aang#/media/File:Avatar_Aang.png'),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                      height: 150,
                      width: 150,
                      image: NetworkImage(
                          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg')),
                  Image(
                      height: 150,
                      width: 150,
                      image: AssetImage('images/Avatar_Aang.png')),
                ],
              ),
              SizedBox(
                height: 50,
              ),

              Text(
                'Hello "xxxx"',
                style: TextStyle(color: myColor),
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    myColor = Colors.blueAccent;
                  });
                },
                child: Text('Click Me'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
