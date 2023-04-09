import 'package:flutter/material.dart';

class UserDetail extends StatelessWidget {
  final String id, nick, imageUrl;

  const UserDetail({
    super.key,
    required this.id,
    required this.nick,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.pink[300],
        centerTitle: true,
        title: Text(nick, style: const TextStyle(color: Colors.black)),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(40, 20, 0, 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(imageUrl),
                ),
                Container(
                  margin: EdgeInsets.only(left: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        nick,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "detail",
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        "Verify",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
              width: size.width,
              height: size.height * 0.1,
              margin: EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Container(
                    width: size.width * 0.32,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [Text("50"), Text("Posts")],
                    ),
                  ),
                  Container(height: 50, width: 2, color: Colors.grey),
                  Container(
                    width: size.width * 0.33,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [Text("10"), Text("Likes")],
                    ),
                  ),
                  Container(height: 50, width: 2, color: Colors.grey),
                  Container(
                    width: size.width * 0.33,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [Text("30"), Text("good")],
                    ),
                  ),
                ],
              )),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  child: Container(
                    height: 50,
                    width: 180,
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Follow",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  onTap: () {
                    print("Follow 버튼");
                  },
                ),
                InkWell(
                  child: Container(
                    height: 50,
                    width: 180,
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.pink[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "메세지 신청",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  onTap: () {
                    print("메세지 신청 버튼");
                  },
                ),
              ],
            ),
          ),
          // Column(
          //   children: [
          //     Expanded(
          //       flex: 5,
          //       child: DefaultTabController(
          //         length: 3,
          //         initialIndex: 0,
          //         child: Column(
          //           children: <Widget>[
          //             Expanded(
          //               child: TabBar(tabs: [
          //                 Tab(
          //                   child: Text("Upload NFT",
          //                       style: TextStyle(color: Colors.black)),
          //                 ),
          //                 Tab(
          //                   child: Text(
          //                     "판매된 NFT",
          //                     style: TextStyle(color: Colors.black),
          //                   ),
          //                 ),
          //                 Tab(
          //                   child: Text(
          //                     "구매한 NFT",
          //                     style: TextStyle(color: Colors.black),
          //                   ),
          //                 ),
          //               ]),
          //             ),
          //             Expanded(
          //               flex: 5,
          //               child: TabBarView(children: <Widget>[
          //                 Container(
          //                   child: GridView.count(
          //                     padding: const EdgeInsets.all(20),
          //                     crossAxisSpacing: 10,
          //                     mainAxisSpacing: 10,
          //                     crossAxisCount: 3,
          //                     children: <Widget>[
          //                       Expanded(
          //                         child: Ink.image(
          //                             image: const NetworkImage(
          //                                 "https://picsum.photos/200")),
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //                 Container(
          //                   child: GridView.count(
          //                     padding: const EdgeInsets.all(20),
          //                     crossAxisSpacing: 10,
          //                     mainAxisSpacing: 10,
          //                     crossAxisCount: 3,
          //                     children: <Widget>[
          //                       Expanded(
          //                         child: Ink.image(
          //                             image: const NetworkImage(
          //                                 "https://picsum.photos/200")),
          //                       ),
          //                       Expanded(
          //                         child: Ink.image(
          //                             image: const NetworkImage(
          //                                 "https://picsum.photos/200")),
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //               ]),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
