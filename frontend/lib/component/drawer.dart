import 'package:flutter/material.dart';

Drawer drawerMethod(String id, String name) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        UserAccountsDrawerHeader(
          currentAccountPicture: const CircleAvatar(
            backgroundImage: NetworkImage("https://picsum.photos/200"),
            backgroundColor: Colors.red,
          ),
          accountName: Text(id),
          accountEmail: Text(name),
          // 분홍부분 꾸미는 part.
          decoration: BoxDecoration(
            color: Colors.red[200],
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.home,
            color: Colors.grey[850],
          ),
          title: const Text("Home"),
          onTap: () {
            print("home");
          },
        ),
        ListTile(
          leading: Icon(
            Icons.settings,
            color: Colors.grey,
          ),
          title: const Text("설정"),
          onTap: () {
            print("설정");
          },
        ),
        ListTile(
          leading: Icon(
            Icons.logout,
            color: Colors.grey,
          ),
          title: const Text("로그아웃"),
          onTap: () {
            print("설정");
          },
        )
      ],
    ),
  );
}
