import 'package:dio/dio.dart';
import 'package:emerald/api/dio_service.dart';
import 'package:emerald/component/currentUser.dart';
import 'package:emerald/tabbar/first/first.dart';
import 'package:emerald/tabbar/mainPage.dart';
import 'package:emerald/tabbar/profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final storage = const FlutterSecureStorage(); // SecureStorage 초기화
  dynamic userInfo = "";
  String id = '';

  @override
  void initState() {
    super.initState();
    // 비동기로 flutter secure storage 정보 불러옴
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    // key값 불러옴...
    userInfo = await storage.read(key: "login");
    // id = userInfo.split("/")[0];
    if (userInfo != null) {
      // Navigator.pushNamed(context, '/mainpage');
      id = userInfo.split("/")[0];
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainPage(id: id),
          ));
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    // 핸드폰 화면 사이즈 가져오기
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              _logoImage,
              // logoImage 그리기
              // Container(width: 200,  height: 200, color: Colors.tealAccent,),
              Stack(
                children: <Widget>[
                  _inputForm(size),
                  _loginButton(size),
                ],
              ),
              Container(
                height: size.height * 0.05,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: Text("아직 회원이 아니신가요?"),
              ),
              Container(
                height: size.height * 0.1,
              )
            ],
          )
        ],
      ),
    );
  }

  // Logo Image - 로고 이미지
  Widget get _logoImage => Expanded(
        child: Padding(
          padding: const EdgeInsets.only(top: 70, left: 30, right: 30),
          child: FittedBox(
            fit: BoxFit.contain,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://cdn.discordapp.com/attachments/1075293243308261426/1088002807229075496/KakaoTalk_Photo_2023-03-22-16-34-26.png"),
            ),
          ),
        ),
      );

  // input Form
  Widget _inputForm(Size size) => Padding(
        padding: EdgeInsets.all(
          size.width * 0.05,
        ),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: _idController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.account_circle),
                      labelText: "ID",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "아이디를 입력해주세요.";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    obscureText: true, //비밀번호 가리기
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.vpn_key),
                      labelText: "Password",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "비밀번호를 입력해주세요.";
                      }
                      return null;
                    },
                  ),
                  Container(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 240),
                    child: Text("Forgot Password?"),
                  ),
                  Container(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  @override
  void dispose() {
    // _idController.dispose();
    // _passwordController.dispose();
    super.dispose();
  }

  Widget _loginButton(Size size) {
    return Positioned(
        left: size.width * 0.35,
        right: size.width * 0.35,
        bottom: 0,
        child: SizedBox(
          height: 45,
          child: ElevatedButton(
            child: Text(
              "Login",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                String message = "아이디와 패스워드 입력해주세요.";
                var res = await server.signInReq(
                    _idController.text, _passwordController.text);
                if (res == 200) {
                  // Navigator.pushNamed(context, '/mainpage');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainPage(id: _idController.text),
                      ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(message),
                    backgroundColor: Colors.deepOrange,
                  ));
                }
              }
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.tealAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                )),
          ),
        ));
  }
}
