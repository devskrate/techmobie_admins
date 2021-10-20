import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
//import 'dart:convert';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:techmobie_admins/articlePostService/home.dart';
import 'package:techmobie_admins/service/server.service.dart' as server;
import 'dart:async';
//import 'dart:math' as math;

//import 'package:techmobie_admins/service/server.service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() => runApp(EditArticle());
final storage = new FlutterSecureStorage();

class EditArticle extends StatelessWidget {
  const EditArticle({Key? key}) : super(key: key);
  //final id;
  //const EditArticle({Key? key, @required this.id}) : super(key: key);
  //const GlobalKey _menukey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Article Edit';

    return MaterialApp(
      title: appTitle,
      theme: TechMobieThemeData(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: EditPostForm(),
        /*drawer: Drawer(
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
                leading: Icon(Icons.article_rounded),
                title: Text('Articles'),
                onTap: () {
                  //Scaffold.of(context).end();
                  //Navigator.of(context).pop();
                  Navigator.of(context).pushReplacementNamed('/articlesList');
                },
              ),
              ListTile(
                leading: Icon(Icons.video_call_rounded),
                title: Text('Videos'),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
              ),
            ],
          ),
        ),*/
      ),
    );
  }

  /*@override
  State<StatefulWidget> createState() {
    return EditPostFormState();
  }*/
}

// Create a Form widget.
class EditPostForm extends StatefulWidget {
  //EditPostForm({Key? key, @required this.id}) : super(key: key);

  const EditPostForm({Key? key}) : super(key: key);
  //final id;
  @override
  State<StatefulWidget> createState() {
    // print("IN Statefulwidget");
    //print(this.id);
    return EditPostFormState();
  }
}

class _PostData {
  String title = '';
  String shortDescription = '';
  String description = '';
  String sourceUrl = '';
  String keywords = '';
  String imageUrl = '';
}

class EditPostFormState extends State<EditPostForm> {
  //const EditPostForm({Key? key}) : super(key: key);
  void _onHorizontalDragStartHandler(DragStartDetails details) {
    Scaffold.of(context).openDrawer();
  }

  /*final textFieldController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    textFieldController.dispose();
    super.dispose();
  }*/
  //final id;
  //EditPostFormState(this.id);

  final _formKey = GlobalKey<FormState>();

  String title = "",
      shortDescription = "",
      description = "",
      sourceUrl = "",
      keywords = "",
      imageUrl = "";
  late List data;
  Future<List> getArticleData() async {
    final objectId = await storage.read(key: "objectId");
    print("At GEt Articles");
    print(objectId);
    //print(id);
    var data1 = await server.getSingleArticle(objectId);
    data = await data1;
    /*imageUrl = data[0]["imageUrl"];
    title = data[0]["title"];
    shortDescription = data[0]["shortDescription"];
    description = data[0]["description"];
    keywords = data[0]["keywords"];
    sourceUrl = data[0]["sourceUrl"];*/
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getArticleData(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = <Widget>[
              Expanded(
                  child: Form(
                      key: _formKey,
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextFormField(
                                //controller: textFieldController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                initialValue: data[0]["imageUrl"],
                                onChanged: (value) {
                                  //print("HEREEEEEEE"+_formKey.text);
                                  setState(() {
                                    imageUrl = value;
                                  });
                                },
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.title_rounded),
                                    labelText: "Image URL",
                                    border: OutlineInputBorder()),
                                //maxLength: 200,
                                maxLines: null,
                                textCapitalization:
                                    TextCapitalization.sentences,
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
                                //controller: textFieldController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                initialValue: data[0]["title"],
                                onChanged: (value) => setState(() {
                                  title = value;
                                }),
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.title_rounded),
                                    labelText: "Title",
                                    border: OutlineInputBorder()),
                                //maxLength: 20,
                                maxLines: null,
                                textCapitalization:
                                    TextCapitalization.sentences,
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
                                //controller: textFieldController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                initialValue: data[0]["shortDescription"],
                                onChanged: (value) => setState(() {
                                  shortDescription = value;
                                }),
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.short_text_rounded),
                                    labelText: "Short Description",
                                    border: OutlineInputBorder()),
                                //maxLength: 100,
                                maxLines: null,
                                textCapitalization:
                                    TextCapitalization.sentences,
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
                                //controller: textFieldController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                initialValue: data[0]["description"],
                                onChanged: (value) => setState(() {
                                  description = value;
                                }),
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.description_rounded),
                                    labelText: "Description",
                                    border: OutlineInputBorder()),
                                //maxLength: 500,
                                maxLines: 8,
                                textCapitalization:
                                    TextCapitalization.sentences,
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
                                //controller: textFieldController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                initialValue: data[0]["keywords"],
                                onChanged: (value) => setState(() {
                                  keywords = value;
                                }),
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.description_rounded),
                                    labelText: "Keywords",
                                    border: OutlineInputBorder()),
                                //maxLength: 100,
                                maxLines: null,
                                textCapitalization:
                                    TextCapitalization.sentences,
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
                                //controller: textFieldController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                initialValue: data[0]["sourceUrl"],
                                onChanged: (value) => setState(() {
                                  sourceUrl = value;
                                }),
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
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      ElevatedButton(
                                        onPressed: () async {
                                          print("Printing Data");
                                          var posted = await server
                                              .deleteArticle(data[0]["_id"]);
                                          if (posted == "deleted") {
                                            //Navigator.pop(context, true);
                                            /*Navigator.popAndPushNamed(
                                                context, '/articlesList');*/
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    backgroundColor:
                                                        Colors.green,
                                                    content: Text(
                                                        'Deleted successfully')));
                                          } else if (posted == "NoAccess") {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    backgroundColor: Colors.red,
                                                    elevation: 10.0,
                                                    duration:
                                                        Duration(seconds: 10),
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            20.0,
                                                            5.0,
                                                            0.0,
                                                            5.0),
                                                    content: Text(
                                                        "You Don't have access to post, please conact admins")));
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    backgroundColor:
                                                        Colors.yellowAccent,
                                                    elevation: 10.0,
                                                    duration:
                                                        Duration(seconds: 5),
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            20.0,
                                                            5.0,
                                                            0.0,
                                                            5.0),
                                                    content: Text(
                                                      'Something went wrong, please contact admins for a fix!',
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    )));
                                          }
                                        },
                                        child: const Text('Delete'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            print("Printing Data");
                                            var posted =
                                                await server.articleUpdate(
                                                    data[0]["_id"],
                                                    imageUrl,
                                                    title,
                                                    shortDescription,
                                                    description,
                                                    keywords,
                                                    sourceUrl);
                                            if (posted == "posted") {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          'Updated successfully')));
                                            } else if (posted == "NoAccess") {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      backgroundColor:
                                                          Colors.red,
                                                      elevation: 10.0,
                                                      duration:
                                                          Duration(seconds: 10),
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              20.0,
                                                              5.0,
                                                              0.0,
                                                              5.0),
                                                      content: Text(
                                                          "You Don't have access to post, please conact admins")));
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      backgroundColor:
                                                          Colors.yellowAccent,
                                                      elevation: 10.0,
                                                      duration:
                                                          Duration(seconds: 5),
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              20.0,
                                                              5.0,
                                                              0.0,
                                                              5.0),
                                                      content: Text(
                                                          'Something went wrong, please contact admins for a fix!')));
                                            }
                                          }
                                        },
                                        child: const Text('Update'),
                                      ),
                                    ]),
                              )
                            ],
                          ),
                        ),
                      )))
            ];
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              )
            ];
          } else {
            children = <Widget>[
              SpinKitFadingCube(
                size: 50.0,
                itemBuilder: (BuildContext context, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: index.isEven ? Colors.red : Colors.green,
                    ),
                  );
                },
                duration: const Duration(seconds: 1),
              )
            ];
          }
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children,
          ));
        });
  }
}
