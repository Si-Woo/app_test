import 'package:emerald/api/userInfo.dart';
import 'package:emerald/tabbar/second/write.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../api/api_service.dart';
import '../../api/getPostData.dart';
import 'category_widget.dart';
import 'freeboard_widget.dart';

class freeBoard extends StatefulWidget {
  final String id;
  const freeBoard({super.key, required this.id});

  @override
  State<freeBoard> createState() => _freeBoardState();
}

class _freeBoardState extends State<freeBoard>
    with AutomaticKeepAliveClientMixin<freeBoard> {
  // with AutomaticKeepAliveClientMixin<FirstPage>랑 bool get wantKeepAlive => true랑 같이 쓰면 다른 탭 눌렀다 돌아왔을 때 reloading 방지!
  @override
  bool get wantKeepAlive => true;

  //자유게시판
  Future<List<GetPostData>> hello = ApiService.getCategoryData("hello");

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "자유게시판",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 40, 220, 190),
      ),
      body: RefreshIndicator(
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
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(340, 50, 20, 0),
                    width: size.width,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Write(
                                    id: widget.id,
                                    nick: "",
                                    category: "hello")));
                      },
                      child: RichText(
                          text: const TextSpan(children: [
                        WidgetSpan(
                          child: Icon(
                            Icons.add,
                            size: 18,
                            color: Colors.red,
                          ),
                        ),
                        TextSpan(
                          text: "글쓰기",
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                      ])),
                    ),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 15, 20, 10),
                width: size.width,
                height: size.height,
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
            ],
          ),
        ),
      ),
    );
  }

  Future refresh() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      hello = ApiService.getCategoryData("hello");
    });
  }

  ListView categoryList(AsyncSnapshot<dynamic> snapshot) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(), // listview scroll 없애기
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        var getcategory = snapshot.data![index];
        return GetFreeboard(
          id: getcategory.id,
          nick: getcategory.nick,
          title: getcategory.title,
          content: getcategory.content,
          category: getcategory.category,
          created: getcategory.created,
        );
      },
      separatorBuilder: (context, index) => const Divider(
        height: 20,
        thickness: 1,
      ),
    );
  }
}
