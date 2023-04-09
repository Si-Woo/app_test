import 'package:emerald/api/dio_service.dart';
import 'package:flutter/material.dart';

import '../component/checkButton.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  final _userName = TextEditingController();
  final _userId = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("회원가입"),
        backgroundColor: Colors.tealAccent,
      ),
      body: SingleChildScrollView(
        child: new Form(
            key: _formKey,
            child: Column(
              children: [
                _idInput(),
                _nameInput(),
                _passwordInput(),
                _confirmPasswordInput(),
                _signUpButton()
              ],
            )),
      ),
    );
  }

  Widget _idInput() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Column(children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: TextFormField(
            keyboardType: TextInputType.text,
            controller: _userId,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(0, 16, 0, 0),
              labelText: "아이디",
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "아이디를 입력해주세요.";
              }
              return null;
            },
          ),
        ),
      ]),
    );
  }

  Widget _nameInput() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: TextFormField(
              keyboardType: TextInputType.name,
              controller: _userName,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                labelText: "이름",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "이름을 입력해주세요.";
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _passwordInput() {
    RegExp regExp = RegExp(
        r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,15}$');

    return Padding(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: TextFormField(
              controller: _password,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                labelText: "비밀번호",
                helperText: "특수문자, 대소문자, 숫자 포함 8자 이상 15자 이내로 입력하세요.",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "비밀번호를 입력해주세요.";
                } else if (!regExp.hasMatch(value)) {
                  return "특수문자, 대소문자, 숫자 포함 8자 이상 15자 이내료 입력하세요.";
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _confirmPasswordInput() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: TextFormField(
              controller: _confirmPassword,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                labelText: "비밀번호 확인",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "비밀번호를 한번 더 입력해주세요.";
                } else if (_password.text != _confirmPassword.text) {
                  return "비밀번호가 일치하지 않습니다.";
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  // InputDecoration _textFormDecoration(labelText, helperText) {
  //   return new InputDecoration(
  //     contentPadding: EdgeInsets.fromLTRB(0, 16, 0, 0),
  //     labelText: labelText,
  //     helperText: helperText,
  //   );
  // }

  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    _userId.dispose();
    _userName.dispose();
    _password.dispose();
    super.dispose();
  }

  Widget _signUpButton() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: ElevatedButton(
        child: Text("확인"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.tealAccent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            var message = "이미 사용중인 아이디입니다.";
            var res = await server.signUpReq(
                _userId.text, _userName.text, _password.text);
            if (res == "success") {
              checkButton(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(message),
                backgroundColor: Colors.tealAccent,
              ));
            }
          }
        },
      ),
    );
  }
}
