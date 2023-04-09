import 'dart:io';
import 'package:emerald/api/api_service.dart';
import 'package:emerald/api/getPostData.dart';
import 'package:emerald/tabbar/first/post_widget.dart';
import 'package:emerald/tabbar/profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../api/dio_service.dart';
import '../../component/currentUser.dart';
import '../../component/drawer.dart';

// const Map<String, String> UNIT_ID = kReleaseMode
//     ? {
//         'ios': 'ca-app-pub-7064513655636813~2675423705',
//         'android': 'ca-app-pub-7064513655636813~2148810090',
//       }
//     : {
//         'ios':
//             'ca-app-pub-3940256099942544/6300978111', //'ca-app-pub-3940256099942544/2934735716',
//         'android': 'ca-app-pub-3940256099942544/6300978111',
//       };

class FirstPage extends StatefulWidget {
  final String id;
  const FirstPage({super.key, required this.id});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage>
    with AutomaticKeepAliveClientMixin<FirstPage> {
  // with AutomaticKeepAliveClientMixin<FirstPage>랑 bool get wantKeepAlive => true랑 같이 쓰면 다른 탭 눌렀다 돌아왔을 때 reloading 방지!
  @override
  bool get wantKeepAlive => true;

  Future<List<GetPostData>> posts = ApiService.getPostData();
  Future<List<GetPostData>> hello = ApiService.getCategoryData("hello");

  @override
  Widget build(BuildContext context) {
    // 광고 설정
    // TargetPlatform os = Theme.of(context).platform;
    // BannerAd banner = BannerAd(
    //   listener: BannerAdListener(
    //     onAdFailedToLoad: (Ad ad, LoadAdError error) {},
    //     onAdLoaded: (_) {},
    //   ),
    //   size: AdSize.banner,
    //   adUnitId: UNIT_ID[os == TargetPlatform.iOS ? 'ios' : 'android']!,
    //   request: AdRequest(),
    // )..load();

    super.build(context);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        drawer: drawerMethod(widget.id, "hello"),
        body: RefreshIndicator(
          // 화면 아래로 당겼을 때 reloading
          color: Colors.white,
          backgroundColor: Colors.tealAccent,
          onRefresh: refresh,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Container(
                //   height: 50,
                //   width: banner.size.width.toDouble(),
                //   color: Colors.transparent,
                //   child: AdWidget(ad: banner),
                // ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  width: size.width,
                  child: const Text(
                    "최근 게시물",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 15, 20, 10),
                  width: size.width,
                  height: 225,
                  child: FutureBuilder(
                    future: posts,
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            Expanded(
                              child: titleList(snapshot),
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
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Container(
                //       height: 50,
                //       width: banner.size.width.toDouble(),
                //       color: Colors.transparent,
                //       child: AdWidget(ad: banner),
                //     ),
                //   ],
                // ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  width: size.width,
                  child: const Text(
                    "AI 이미지",
                    style: TextStyle(fontSize: 23),
                  ),
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
      posts = ApiService.getPostData();
    });
  }

  ListView titleList(AsyncSnapshot<dynamic> snapshot) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(), // listview scroll 없애기
      itemCount: 7,
      itemBuilder: (context, index) {
        var post = snapshot.data![index];
        return Post(
          id: post.id,
          nick: post.nick,
          title: post.title,
          content: post.content,
          category: post.category,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 15,
      ),
    );
  }
}
