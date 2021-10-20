import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:techmobie_admins/articlePostService/articles.list.dart';
import 'package:techmobie_admins/service/auth.service.dart';
import 'package:techmobie_admins/login.dart';
import 'package:techmobie_admins/articlePostService/home.dart';
//import 'package:techmobie_admins/service/auth.service.dart' as auth;
//import 'package:techmobie_admins/articlePostService/articles.list.dart';
import 'articlePostService/article.dart';
import 'articlePostService/edit.article.dart';

//AuthService appAuth = new AuthService();
/*void initState() async {
  bool _isLoggedIn;
  SharedPreferences prefs = await SharedPreferences.getInstance();
       _isLoggedIn  =  (prefs.getBool('log') ?? 0);
    main();
}*/
/*isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
      int _isLoggedIn  =  (prefs.getInt('log') ?? 0);
      return _isLoggedIn;
}*/

final storage = new FlutterSecureStorage();

// Read value

// Read all values
//Map<String, String> allValues = await storage.readAll();

// Delete value
//await storage.delete(key: key);

// Delete all
//await storage.deleteAll();

// Write value
//await storage.write(key: key, value: value);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //final llog = "False";
  //print("1");
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  //bool _isLoggedIn  =  (prefs.getBool('log') ?? 0);
  // Set default home.
  Widget _defaultHome = AdminLogin();
  //print("2");
  // Get result of the login function.
  //bool _isLoggedIn =  appAuth.isLoggedIn();
  //parsed.map<AdminsList>((json) => AdminsList.fromJson(json)).toList();

  final llog = await storage.read(key: "loggedIn");
  var temp = await fetchAdmins(http.Client());

  print(temp[0].name);
  String _isLoggedIn = llog == "True" ? "True" : "False";
  //_isLoggedIn = "True";
  print("This is");
  print(_isLoggedIn);
  if (_isLoggedIn == "True") {
    print("3");
    final username = await storage.read(key: "username");
    _defaultHome = MyApp();
  }
  print("4");
  // Run app!
  runApp(MaterialApp(
    title: 'App',
    home: _defaultHome,
    routes: <String, WidgetBuilder>{
      // Set routes for using the Navigator.
      '/home': (BuildContext context) => new MyApp(),
      '/login': (BuildContext context) => new AdminLogin(),
      '/articlesList': (BuildContext context) => new ArticlesList(),
      '/articles': (BuildContext context) => new ArticleScreen(),
      //'/postList': (BuildContext context) => new ArticlesList(),
      '/editArticle': (BuildContext context) => new EditArticle(),
      //'/logout': (BuildContext context) => new MyApp(),
    },
  ));
}
