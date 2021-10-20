// ignore_for_file: use_full_hex_values_for_flutter_colors

//import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'dart:convert';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:techmobie_admins/articlePostService/article.dart';
import 'package:techmobie_admins/service/server.service.dart' as server;
//import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
//import 'dart:async';
//import 'dart:math' as math;
import 'package:techmobie_admins/articlePostService/articles.list.dart';
//import 'package:techmobie_admins/articlePostService/articles.list.dart' as articleList;
import 'package:techmobie_admins/articlePostService/shortPost.list.dart'
    as short_post_list;

import '../login.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  //const GlobalKey _menukey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Article Post';
    return /*FutureBuilder(
        future: Init.instance.initialize(),
        builder: (context, AsyncSnapshot snapshot) {
          // Show splash screen while waiting for app resources to load:
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(home: Splash());
          } else {
            return */
        MaterialApp(
      title: appTitle,
      home: ScaffoldHome(),
      theme: TechMobieThemeData(),
    );
  }
  /*});
  }*/
}

ThemeData TechMobieThemeData() {
  return ThemeData(
    appBarTheme: const AppBarTheme(
      elevation: 100.0,
      color: Color(0xFFB021B52),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Color(0xFFB021B52),
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
    ),

    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.indigo,
      backgroundColor: Color(0xFFBE3FFFA),
      cardColor: Color(0xFFBE3FFFA),
      accentColor: Color(0xFFBE3FFFA),
    ).copyWith(secondary: const Color(0xFFBE3FFFA)),

    primaryIconTheme: const IconThemeData(
      color: Color(0xFFBE3FFFA),
    ),
    //buttonTheme: ButtonThemeData(buttonColor: Color(0xFFB021B52)),
    /*elevatedButtonTheme: const ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Color(0xFFB021B52)),
    )
  )*/
    //scaffoldBackgroundColor: Color(0xFFB021B52),
  );
}

class ScaffoldHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            //backgroundColor: const Color(0xFFB021B52),
            bottom: const TabBar(
              /*unselectedLabelColor: Colors.redAccent,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.redAccent),*/
              //indicatorColor: Color(0xFFB00FFC2),
              tabs: [
                Tab(icon: Icon(Icons.edit)),
                Tab(icon: Icon(Icons.list_alt)),
              ],
            ),
            title: Text("Short Post"),
          ),
          body: const PostForm(),
          drawer: Theme(
            data: Theme.of(context).copyWith(
              //canvasColor: Colors.,
              cardColor: Colors.red,
            ),
            child: const Menu(),
          ),
        ));
  }
}

name() async {
  final username = await storage.read(key: "username");
}

class Menu extends StatelessWidget {
  const Menu({
    Key? key,
  }) : super(key: key);
  @override
  void initState() async {
    final username = await storage.read(key: "username");
    print(username);
  }

//final user = await storage.read(key: "username");
  @override
  Widget build(BuildContext context) {
    String user = "Hello\n\n\n                       Admin!";
    var username = null;
    initState();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFFB021B52),
            ),
            child: Text(
              username == null ? user : username,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home_rounded),
            title: Text('Short Post'),
            onTap: () {
              //Scaffold.of(context).end();
              //Navigator.of(context).pop();
              //Navigator.of(context).pushReplacementNamed('/home');
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => new MyApp()));
            },
          ),
          ListTile(
            leading: Icon(Icons.article_rounded),
            title: Text('Articles'),
            onTap: () {
              //Scaffold.of(context).end();
              //Navigator.of(context).pop();
              //Navigator.pushNamed(context, '/articlesList');
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new ArticleScreen()));
              //Navigator.of(context).pushReplacementNamed('/articlesList');
            },
          ),
          /*ListTile(
            leading: Icon(Icons.video_call_rounded),
            title: Text('Videos'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),*/
          ListTile(
            leading: Icon(Icons.logout_rounded),
            title: Text('Logout'),
            onTap: () async {
              //Scaffold.of(context).end();
              //Navigator.of(context).pop();
              await storage.delete(key: "username");
              await storage.delete(key: "password");
              await storage.delete(key: "loggedIn");
              await storage.delete(key: "objectId");
              //Navigator.of(context).pushReplacementNamed('/login');
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new AdminLogin()));
            },
          ),
        ],
      ),
    );
  }
}

/*name() async {
  final username = await storage.read(key: "username");
  print("Printing username");
  print(username);
  setState(() {
    
  });
  if (username != null) {
    return username;
    /*Text(
      username,
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
      ),
    );*/
  } else {
    return /*Text(
      "Hello",
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
      ),
    );*/
        "Hello";
  }
}
*/
// Create a Form widget.
class PostForm extends StatefulWidget {
  const PostForm({Key? key}) : super(key: key);

  @override
  PostFormState createState() {
    return PostFormState();
  }
}

class _PostData {
  String imageUrl = '';
  String keywords = '';
  String description = '';
  String sourceUrl = '';
}

class PostFormState extends State<PostForm> {
  /*void _onHorizontalDragStartHandler(DragStartDetails details) {
    Scaffold.of(context).openDrawer();
  }*/

  final _formKey = GlobalKey<FormState>();
  _PostData _data = new _PostData();
  String imageUrl = "",
      shortDescription = "",
      description = "",
      sourceUrl = "",
      keywords = "";
  @override
  Widget build(BuildContext context) {
    return /*GestureDetector(
        dragStartBehavior: DragStartBehavior.start,
        onHorizontalDragStart: _onHorizontalDragStartHandler,
        behavior: HitTestBehavior.translucent,
        child: */
        TabBarView(children: [
      Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => imageUrl = value,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.title_rounded),
                        labelText: "Image URL",
                        border: OutlineInputBorder()),
                    maxLines: null,
                    textCapitalization: TextCapitalization.sentences,
                    validator: (value) {
                      if (value == null ||
                          value == false ||
                          ((value is Iterable ||
                                  value is String ||
                                  value is Map) &&
                              value.isEmpty) ||
                          value.trim().isEmpty) {
                        return "Image URL is Required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => description = value,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.description_rounded),
                        labelText: "Description",
                        border: OutlineInputBorder()),
                    //maxLength: 200,
                    maxLines: null,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => sourceUrl = value,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.description_rounded),
                        labelText: "Source URL",
                        border: OutlineInputBorder()),
                    //maxLength: 50,
                    maxLines: null,
                    validator: (value) {
                      if (value == null ||
                          value == false ||
                          ((value is Iterable ||
                                  value is String ||
                                  value is Map) &&
                              value.isEmpty) ||
                          value.trim().length == null) {
                        return "Source URL is Required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    onChanged: (value) => keywords = value,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.title_rounded),
                        labelText: "keywords",
                        border: OutlineInputBorder()),
                    //maxLength: 50,
                    maxLines: null,
                    textCapitalization: TextCapitalization.sentences,
                    validator: (value) {
                      if (value == null ||
                          value == false ||
                          ((value is Iterable ||
                                  value is String ||
                                  value is Map) &&
                              value.isEmpty) ||
                          value.trim().isEmpty) {
                        return "Keywords is Required";
                      }
                      return null;
                    },
                  ),
                  //const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          print("Printing Data");
                          var posted = await server.shortPost_Post(
                              imageUrl, description, sourceUrl, keywords);
                          if (posted == "posted") {
                            _formKey.currentState?.reset();
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Posted successfully')));
                          } else if (posted == "NoAccess") {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor: Colors.red,
                                    elevation: 10.0,
                                    duration: Duration(seconds: 10),
                                    padding: EdgeInsets.fromLTRB(
                                        20.0, 5.0, 0.0, 5.0),
                                    content: Text(
                                        "You Don't have access to post, please conact admins")));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor: Colors.yellowAccent,
                                    elevation: 10.0,
                                    duration: Duration(seconds: 5),
                                    padding: EdgeInsets.fromLTRB(
                                        20.0, 5.0, 0.0, 5.0),
                                    content: Text(
                                        'Something went wrong, please contact admins for a fix!')));
                          }
                        }
                      },
                      child: const Text('Post'),
                    ),
                  ),
                ],
              ),
            ),
          )),
      short_post_list.ShortPostListViewBuilder(),
    ]);
  }
}

class Splash extends StatelessWidget {
  //const Splash({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool lightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    return Scaffold(
        backgroundColor: const Color(0xFFBE3FFFA),
        body: Center(
          child: Image.asset('assets/splashImages/splash.png'),
        )
        /*lightMode
          ? const Color(0x00e1f5fe).withOpacity(1.0)
          : const Color(0x00042a49).withOpacity(1.0),
      body: Center(
          child: lightMode
              ? Image.asset('assets/splash.png')
              : Image.asset('assets/splash_dark.png')),*/
        );
  }
}

class Init {
  Init._();
  static final instance = Init._();

  Future initialize() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    await Future.delayed(const Duration(seconds: 3));
  }
}
