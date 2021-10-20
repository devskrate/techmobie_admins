//import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
//import 'dart:convert';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:techmobie_admins/articlePostService/home.dart';
import 'package:techmobie_admins/service/server.service.dart' as server;
//import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
//import 'dart:async';
//import 'dart:math' as math;
//import 'package:techmobie_admins/articlePostService/articles.list.dart';
import 'package:techmobie_admins/articlePostService/articles.list.dart'
    as articleList;

import '../login.dart';

void main() => runApp(const ArticleScreen());

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({Key? key}) : super(key: key);
  //const GlobalKey _menukey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Article Post';

    return MaterialApp(
      title: appTitle,
      home: ScaffoldHome(),
      theme: TechMobieThemeData(),
    );
  }
}

class ScaffoldHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.edit)),
                Tab(icon: Icon(Icons.list_alt)),
              ],
            ),
            title: Text("Article"),
          ),
          body: const PostForm(),
          drawer: Menu(),
        ));
  }
}

/*class Menu extends StatelessWidget {
  const Menu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Drawer Header',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home_rounded),
            title: Text('Home'),
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
}*/

// Create a Form widget.
class PostForm extends StatefulWidget {
  const PostForm({Key? key}) : super(key: key);

  @override
  PostFormState createState() {
    return PostFormState();
  }
}

class _PostData {
  String title = '';
  String descriptiondescription = '';
  String description = '';
  String sourceUrl = '';
  String keywords = '';
  String imageUrl = '';
}

class PostFormState extends State<PostForm> {
  /*void _onHorizontalDragStartHandler(DragStartDetails details) {
    Scaffold.of(context).openDrawer();
  }*/

  final _formKey = GlobalKey<FormState>();
  _PostData _data = new _PostData();
  String title = "",
      shortDescription = "",
      description = "",
      sourceUrl = "",
      keywords = "",
      imageUrl = "";
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
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => imageUrl = value,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.title_rounded),
                        labelText: "Image URL",
                        border: OutlineInputBorder()),
                    //maxLength: 300,
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
                    onChanged: (value) => title = value,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.title_rounded),
                        labelText: "Title",
                        border: OutlineInputBorder()),
                    //maxLength: 20,
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
                        return "Title is Required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => shortDescription = value,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.short_text_rounded),
                        labelText: "Short Description",
                        border: OutlineInputBorder()),
                    //maxLength: 100,
                    maxLines: null,
                    textCapitalization: TextCapitalization.sentences,
                    validator: (value) {
                      if (value == null ||
                          value == false ||
                          ((value is Iterable ||
                                      value is String ||
                                      value is Map) &&
                                  value.isEmpty ||
                              value.trim().isEmpty)) {
                        return "Short Description is Required";
                      }
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
                    //maxLength: 500,
                    maxLines: 8,
                    textCapitalization: TextCapitalization.sentences,
                    validator: (value) {
                      if (value == null ||
                          value == false ||
                          ((value is Iterable ||
                                      value is String ||
                                      value is Map) &&
                                  value.isEmpty ||
                              value.trim().isEmpty)) {
                        return "Description is Required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => keywords = value,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.description_rounded),
                        labelText: "Keywords",
                        border: OutlineInputBorder()),
                    //maxLength: 100,
                    maxLines: null,
                    textCapitalization: TextCapitalization.sentences,
                    validator: (value) {
                      if (value == null ||
                          value == false ||
                          ((value is Iterable ||
                                      value is String ||
                                      value is Map) &&
                                  value.isEmpty ||
                              value.trim().isEmpty)) {
                        return "Keywords are Required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    onChanged: (value) => sourceUrl = value,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.description_rounded),
                        labelText: "Source URL",
                        border: OutlineInputBorder()),
                    //maxLength: 30,
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
                  //const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          print("Printing Data");
                          var posted = await server.articlePost(
                              imageUrl,
                              title,
                              shortDescription,
                              description,
                              keywords,
                              sourceUrl);
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
      //Icon(Icons.directions_car, size: 350),
      articleList.ListViewBuilder(),
    ]);
  }
}
