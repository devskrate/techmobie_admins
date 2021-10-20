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

void main() => runApp(EditShortPost());
final storage = new FlutterSecureStorage();

class EditShortPost extends StatelessWidget {
  const EditShortPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'ShortPost Edit';

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
        body: EditShortPostForm(),
      ),
    );
  }
}

class EditShortPostForm extends StatefulWidget {
  //EditShortPostForm({Key? key, @required this.id}) : super(key: key);

  const EditShortPostForm({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return EditShortPostFormState();
  }
}

class _PostData {
  String imageUrl = '';
  String description = '';
  String keywords = '';
  String sourceUrl = '';
}

class EditShortPostFormState extends State<EditShortPostForm> {
  //const EditPostForm({Key? key}) : super(key: key);
  void _onHorizontalDragStartHandler(DragStartDetails details) {
    Scaffold.of(context).openDrawer();
  }

  //final id;
  //EditPostFormState(this.id);

  final _formKey = GlobalKey<FormState>();

  String imageUrl = "", description = "", sourceUrl = "", keywords = "";
  late List data;
  Future<List> getShortPostData() async {
    final objectId = await storage.read(key: "objectId");
    print("At GEt Articles");
    print(objectId);
    //print(id);
    var data1 = await server.getSingleShortPost(objectId);
    data = await data1;
    /*imageUrl = data[0]["imageUrl"];
    description = data[0]["description"];
    sourceUrl = data[0]["sourceUrl"];
    keywords = data[0]["keywords"];*/
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getShortPostData(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = <Widget>[
              Expanded(
                  child: Form(
                      key: _formKey,
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextFormField(
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                initialValue: data[0]["imageUrl"],
                                onChanged: (value) => setState(() {
                                  imageUrl = value;
                                }),
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
                                    return "Description is Required";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 15),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                initialValue: data[0]["sourceUrl"],
                                onChanged: (value) => setState(() {
                                  sourceUrl = value;
                                }),
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.description_rounded),
                                    labelText: "Source URL",
                                    border: OutlineInputBorder()),
                                //maxLength: 100,
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
                                                await server.shortPostUpdate(
                                                    data[0]["_id"],
                                                    imageUrl,
                                                    description,
                                                    sourceUrl,
                                                    keywords);
                                            if (posted == "posted") {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          'Posted successfully')));
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
