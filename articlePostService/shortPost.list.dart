import 'package:flutter/gestures.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//import 'package:techmobie_admins/articlePostService/edit.article.dart';
import 'package:techmobie_admins/articlePostService/edit.shortPost.dart';
import 'package:techmobie_admins/service/server.service.dart' as server;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'home.dart';

void main() => runApp(ShortPostList());
final storage = new FlutterSecureStorage();

//'/posts': (BuildContext context) => new ArticlesList(),
class ShortPostList extends StatelessWidget {
// This widget is the root
// of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Short Post List",
        theme: ThemeData(primarySwatch: Colors.green),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(title: Text("Short Post List")),
            drawer: Menu(),
            body: ShortPostListViewBuilder()));
  }
}

class ShortPostListViewBuilder extends StatefulWidget {
  //const PostForm({Key? key}) : super(key: key);

  @override
  ShortPostListView createState() {
    return ShortPostListView();
  }
}

class ShortPostListView extends State<ShortPostListViewBuilder> {
  void _onHorizontalDragStartHandler(DragStartDetails details) {
    Scaffold.of(context).openDrawer();
  }

  getAndSetId(index) async {
    id = shortPostsList1[index]["_id"].toString();
    var temp = id.split('"');
    id = temp[1];
    await storage.write(key: "objectId", value: id);
    return true;
  }

  var id = "";
  late List shortPostsList1 = [];
  late int shortPostsCount;
  Future<List> getArticles() async {
    var shortPostsList = await server.getShortPosts();
    shortPostsCount = shortPostsList.length;
    //setState(() {
    shortPostsList1 = shortPostsList;
    //});
    return shortPostsList;
  }

  @override
  Widget build(BuildContext context) {
    return /*GestureDetector(
        dragStartBehavior: DragStartBehavior.start,
        onHorizontalDragStart: _onHorizontalDragStartHandler,
        behavior: HitTestBehavior.translucent,*/
        FutureBuilder<List>(
            future: getArticles(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                children = <Widget>[
                  Expanded(
                      child: RefreshIndicator(
                          child: ListView.builder(
                            itemCount: shortPostsCount,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                leading: Icon(Icons.list),
                                trailing: Icon(Icons.arrow_right_sharp),
                                title:
                                    Text(shortPostsList1[index]["description"]),
                                onTap: () {
                                  getAndSetId(index);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditShortPost(),
                                      ));
                                  //AppBuilder.of(context).rebuild();
                                  /*if (res) {
                                    Navigator.of(context)
                                        .pushReplacementNamed('/articlesList');
                                  }*/
                                  //
                                  /*Navigator.of(context)
                                      .pushNamed('/editArticle', arguments: id);*/
                                  //Navigator.of(context).pushReplacementNamed('/editArticle');
                                },
                              );
                            },
                            //physics: const AlwaysScrollableScrollPhysics(),
                            physics: BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                          ),
                          onRefresh: () {
                            return Future.delayed(
                              Duration(seconds: 1),
                              () {
                                setState(() {
                                  var articlesList = getArticles();
                                });
                              },
                            );
                          }))
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
