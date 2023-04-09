import 'package:emerald/api/api_service.dart';
import 'package:emerald/api/getPostData.dart';
import 'package:emerald/tabbar/second/category_widget.dart';
import 'package:emerald/tabbar/second/freeboard.dart';
import 'package:emerald/tabbar/second/write.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../api/dio_service.dart';
import '../../component/drawer.dart';

const Map<String, String> UNIT_ID = kReleaseMode
    ? {
        'ios': 'ca-app-pub-7064513655636813~2675423705',
        'android': 'ca-app-pub-7064513655636813~2148810090',
      }
    : {
        'ios':
            'ca-app-pub-3940256099942544/6300978111', //'ca-app-pub-3940256099942544/2934735716',
        'android': 'ca-app-pub-3940256099942544/6300978111',
      };

class SecondPage extends StatefulWidget {
  final String id;
  const SecondPage({super.key, required this.id});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage>
    with AutomaticKeepAliveClientMixin<SecondPage> {
  // with AutomaticKeepAliveClientMixin<FirstPage>랑 bool get wantKeepAlive => true랑 같이 쓰면 다른 탭 눌렀다 돌아왔을 때 reloading 방지!
  @override
  bool get wantKeepAlive => true;

  // Future<List<GetPostData>> posts = ApiService.getPostData();
  Future<List<GetPostData>> hello = ApiService.getCategoryData("hello");
  Future<List<GetPostData>> bye = ApiService.getCategoryData("bye");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const _storage = FlutterSecureStorage();
    super.build(context);
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        drawer: drawerMethod("hi", "hello"),
        body: RefreshIndicator(
          // 화면 아래로 당겼을 때 reloading
          color: Colors.white,
          backgroundColor: Colors.tealAccent,
          onRefresh: refresh,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                      width: size.width,
                      child: const Text(
                        "자유게시판", // hello
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(320, 50, 20, 0),
                      width: size.width,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      freeBoard(id: widget.id)));
                        },
                        child: RichText(
                          text: const TextSpan(
                            children: [
                              WidgetSpan(
                                child: Icon(
                                  Icons.add,
                                  size: 18,
                                  color: Colors.red,
                                ),
                              ),
                              TextSpan(
                                text: "전체보기",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 15, 20, 10),
                  width: size.width,
                  height: 220,
                  child: FutureBuilder(
                    future: hello,
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            Expanded(
                              child: categoryList(snapshot),
                            ),
                          ],
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.tealAccent,
                        ),
                      );
                    },
                  ),
                ),
                const Divider(
                  thickness: 1,
                ),
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      width: size.width,
                      child: const Text(
                        "익명게시판", // bye
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(320, 20, 20, 0),
                      width: size.width,
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                Icons.add,
                                size: 18,
                                color: Colors.red,
                              ),
                            ),
                            TextSpan(
                              text: "전체보기",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 15, 20, 10),
                  width: size.width,
                  height: 220,
                  child: FutureBuilder(
                    future: bye,
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            Expanded(
                              child: categoryList(snapshot),
                            ),
                          ],
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.tealAccent,
                        ),
                      );
                    },
                  ),
                ),
                const Divider(
                  thickness: 1,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                  width: size.width,
                  height: 150,
                  color: Colors.yellow,
                ),
                const Divider(
                  thickness: 1,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                  width: size.width,
                  height: 150,
                  color: Colors.pink,
                ),
                const Divider(
                  thickness: 1,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                  width: size.width,
                  height: 150,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ));
  }

  Future refresh() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      hello = ApiService.getCategoryData("hello");
      bye = ApiService.getCategoryData("bye");
    });
  }

  ListView categoryList(AsyncSnapshot<dynamic> snapshot) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(), // listview scroll 없애기
      itemCount: 7,
      itemBuilder: (context, index) {
        var getcategory = snapshot.data![index];
        return GetCategory(
          id: getcategory.id,
          title: getcategory.title,
          content: getcategory.content,
          category: getcategory.category,
          nick: getcategory.nick,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 15,
      ),
    );
  }
}
