import 'package:flutter/material.dart';
import 'package:responsi/page/categories_view.dart';
import 'package:responsi/page/login_page.dart';
import 'package:responsi/page/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Check if user is logged in
  final prefs = await SharedPreferences.getInstance();
  final username = prefs.getString('username');
  final password = prefs.getString('password');

  runApp(MyApp(username: username, password: password));
}

class MyApp extends StatelessWidget {
  final String? username;
  final String? password;

  MyApp({this.username, this.password});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: username != null && password != null
          ? '/menuUtama'
          : '/login', // Redirect based on login status
      routes: {
        '/login': (context) => LoginPage(),
        '/menuUtama': (context) => CategoriesView(),
        '/register': (context) => RegisterPage(), // Route to RegisterPage
      },
    );
  }
}
