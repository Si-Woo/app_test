import 'package:emerald/component/currentUser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Profile extends StatelessWidget {
  final String id, nick, imageUrl;
  const Profile({
    super.key,
    required this.id,
    required this.nick,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    const _storage = FlutterSecureStorage();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Color.fromARGB(255, 40, 220, 190),
          centerTitle: true,
          title: const Text("Profile", style: TextStyle(color: Colors.white)),
          actions: [
            IconButton(
                onPressed: () {
                  _storage.delete(key: "login");
                  Navigator.pushNamed(context, '/login');
                },
                icon: const Icon(Icons.logout, color: Colors.white))
          ],
        ),
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: NetworkImage(imageUrl) == null
                          ? NetworkImage("https://picsum.photos/200")
                          : NetworkImage(imageUrl),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(id,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Text(nick, style: const TextStyle(fontSize: 18)),
                          Text("information", style: TextStyle(fontSize: 15)),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [Text("50"), Text("Posts")],
                    ),
                  ),
                  Container(height: 50, width: 2, color: Colors.grey),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [Text("10"), Text("Likes")],
                    ),
                  ),
                  Container(height: 50, width: 2, color: Colors.grey),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [Text("3"), Text("Shares")],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    child: Container(
                      height: 50,
                      width: 180,
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Follow",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                    onTap: () {},
                  ),
                  InkWell(
                    child: Container(
                      height: 50,
                      width: 180,
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Message",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: DefaultTabController(
                length: 2,
                initialIndex: 0,
                child: Column(
                  children: <Widget>[
                    const Expanded(
                      flex: 1,
                      child: TabBar(tabs: <Widget>[
                        Tab(
                          icon: Icon(Icons.directions_car, color: Colors.black),
                        ),
                        Tab(
                          icon: Icon(Icons.train, color: Colors.black),
                        )
                      ]),
                    ),
                    Expanded(
                      flex: 5,
                      child: TabBarView(children: <Widget>[
                        Container(
                          child: GridView.count(
                            padding: const EdgeInsets.all(20),
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 3,
                            children: <Widget>[
                              Expanded(
                                child: Ink.image(
                                    image: const NetworkImage(
                                        "https://picsum.photos/200")),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: GridView.count(
                            padding: const EdgeInsets.all(20),
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 3,
                            children: <Widget>[
                              Expanded(
                                child: Ink.image(
                                    image: const NetworkImage(
                                        "https://picsum.photos/200")),
                              ),
                              Expanded(
                                child: Ink.image(
                                    image: const NetworkImage(
                                        "https://picsum.photos/200")),
                              ),
                            ],
                          ),
                        )
                      ]),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
