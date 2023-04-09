import 'package:emerald/api/api_service.dart';
import 'package:emerald/api/userInfo.dart';
import 'package:emerald/component/currentUser.dart';
import 'package:emerald/tabbar/profile/profile_widget.dart';
import 'package:emerald/tabbar/second/freeboard.dart';
import 'package:emerald/tabbar/second/write.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:emerald/tabbar/first/first.dart';
import 'package:emerald/tabbar/second/second.dart';
import 'package:emerald/tabbar/third/third.dart';
import 'package:emerald/tabbar/fourth/fourth.dart';
import 'package:emerald/tabbar/profile/profile.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'fifth/fifth.dart';

class MainPage extends StatefulWidget {
  final String id;
  const MainPage({super.key, required this.id});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with AutomaticKeepAliveClientMixin<MainPage> {
  @override
  bool get wantKeepAlive => true;

  int _selectedIndex = 0;
  String title = "";

  // static List<Widget> pages = <Widget>[
  //   const FirstPage(),
  //   const SecondPage(),
  //   const ThirdPage(),
  //   const FourthPage(),
  //   const FifthPage(),
  // ];

  @override
  void initState() {
    super.initState();
  }

  final pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.jumpToPage(index);
    if (index == 0) {
      title = "Emerald";
    } else if (index == 1) {
      title = "게시판";
    } else if (index == 2) {
      title = "Chat";
    } else if (index == 3) {
      title = "NFT";
    } else {
      title = "emerald";
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<List<UserInfo>> currentuser = ApiService.getCurrentUser(widget.id);
    List<Widget> pages = <Widget>[
      FirstPage(id: widget.id),
      SecondPage(id: widget.id),
      ThirdPage(id: widget.id),
      FourthPage(id: widget.id),
      FifthPage(id: widget.id),
      // Write(id: widget.id, nick: widget.nick),
    ];
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // 뒤로가기 버튼 없애기
          centerTitle: true,
          title: Text(title),
          backgroundColor: const Color.fromARGB(255, 40, 220, 190),
          actions: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: CircleAvatar(
                child: FutureBuilder(
                  future: currentuser,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return currentUser(snapshot);
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(), // tabbar 가로 스와이프 제한
          controller: pageController,
          onPageChanged: _onItemTapped,
          children: pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.grey,
          selectedItemColor: Color.fromARGB(255, 40, 220, 190),
          unselectedItemColor: Colors.white.withOpacity(.60),
          selectedFontSize: 14,
          unselectedFontSize: 14,
          currentIndex: _selectedIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: 'home'),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: 'second'),
            BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble_outline), label: 'Chat'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_add_alt_1_rounded), label: 'third'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_pin), label: 'fourth'),
          ],
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  ListView currentUser(AsyncSnapshot<dynamic> snapshot) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 1,
      itemBuilder: (context, index) {
        var user = snapshot.data![index];
        return ProfileWidget(
          id: user.id,
          nick: user.nick,
          imageUrl: user.imageUrl,
        );
      },
    );
  }

  // 안드로이드 : 핸드폰 뒤로가기 버튼 두 번 클릭시 앱 종료
  DateTime? currentBackPressTime;

  Future<bool> onWillPop() async {
    DateTime now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;

      const msg = "뒤로 버튼을 한 번 더 누르면 종료됩니다.";
      const snackBar = SnackBar(content: Text(msg));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return Future.value(false);
    }
    SystemNavigator.pop(); // 앱 종료 코드
    return Future.value(true);
  }
}
