import 'package:emerald/api/api_service.dart';
import 'package:emerald/api/getPostData.dart';
import 'package:emerald/component/currentUser.dart';
import 'package:emerald/tabbar/first/post_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../api/dio_service.dart';
import '../../api/userInfo.dart';
import '../../component/drawer.dart';
import 'connect_user_widget.dart';

class ThirdPage extends StatefulWidget {
  final String id;
  const ThirdPage({super.key, required this.id});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage>
    with AutomaticKeepAliveClientMixin<ThirdPage> {
  // with AutomaticKeepAliveClientMixin<FirstPage>랑 bool get wantKeepAlive => true랑 같이 쓰면 다른 탭 눌렀다 돌아왔을 때 reloading 방지!
  @override
  bool get wantKeepAlive => true;

  Future<List<UserInfo>> users = ApiService.getConnectUser();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        // 화면 아래로 당겼을 때 reloading
        body: RefreshIndicator(
      color: Colors.white,
      backgroundColor: Colors.tealAccent,
      onRefresh: refresh,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 15, 0, 10),
              width: size.width,
              height: size.height,
              child: FutureBuilder(
                future: users,
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Expanded(
                          child: userList(snapshot),
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
    ));
  }

  Future refresh() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      users = ApiService.getConnectUser();
    });
  }

  ListView userList(AsyncSnapshot<dynamic> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      // physics: const NeverScrollableScrollPhysics(), // listview scroll 없애기
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        var user = snapshot.data![index];
        return User(
          id: user.id,
          nick: user.nick,
          imageUrl: user.imageUrl,
        );
      },
      separatorBuilder: (context, index) => const Divider(
        height: 2,
        thickness: 1,
      ),
    );
  }
}
