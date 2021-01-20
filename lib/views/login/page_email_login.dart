import 'package:fitwith/utils/utils_common.dart';
import 'package:fitwith/utils/utils_widget.dart';
import 'package:fitwith/views/page_root.dart';
import 'package:fitwith/views/premium/page_premium_member.dart';
import 'package:fitwith/views/sign_up/page_email_sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 이메일 로그인 페이지
class EmailLoginPage extends StatefulWidget {
  @override
  _EmailLoginPageState createState() => _EmailLoginPageState();
}

class _EmailLoginPageState extends State<EmailLoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String password = "";
  String email = "";

  void _logins() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_formKey.currentState.validate()) {
      Scaffold.of(_formKey.currentContext).showSnackBar(
          SnackBar(content: Text('처리중')));
    }
    Dio dio = new Dio();
    String hashedPassword = sha512.convert(utf8.encode(password)).toString();
    print(email);
    print(hashedPassword);
    Response response = await dio.post('http://10.0.2.2:3000/accounts/login',
        data: { "email": email, "password": hashedPassword});
    print(response.data['accesstoken']);
    prefs.setString('token', response.data['accesstoken']);
    CommonUtils.movePage(context, RootPage(CommonUtils.TYPE_MEMBER));
    // CommonUtils.movePage(context, PremiumMemberPage());
  }

  Size _deviceSize;
  bool _isAutoLogin = true; // 자동로그인

  @override
  Widget build(BuildContext context) {
    _deviceSize = MediaQuery
        .of(context)
        .size;

    return WidgetUtils.buildScaffold(
      _buildBody(),
      backgroundColor: CommonUtils.getPrimaryColor(),
    );
  }

  /// Build body
  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20.0, 80.0, 20.0, 0.0),
      child: Column(
        children: [
          Image.asset('assets/logo.png'),
          SizedBox(height: 10.0),
          Image.asset('assets/logo_text_white.png'),
          SizedBox(height: 30.0),
          Form(
            key: _formKey,
            child: Column(
              children: [
                _buildTextFormField(
                    '이메일',
                        (String value) {
                      if (value.isEmpty) return '이메일을 입력하세요.';
                      email = value;
                      return null;
                    },
                    false
                ),
                SizedBox(height: 10.0),
                _buildTextFormField(
                    '비밀번호',
                        (String value) {
                      if (value.isEmpty) return '비밀번호를 입력하세요.';
                      password = value;
                      return null;
                    },
                    true
                ),
                Theme(
                  data: ThemeData(unselectedWidgetColor: Colors.white),
                  child: CheckboxListTile(
                    title: Text(
                      '자동로그인',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    value: _isAutoLogin,
                    activeColor: CommonUtils.getPrimaryColor(),
                    contentPadding: const EdgeInsets.all(0.0),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (bool value) {
                      setState(() {
                        _isAutoLogin = value;
                      });
                    },
                  ),
                ),
                WidgetUtils.buildCustomButton(
                  Text(
                    '로그인',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  _logins,
                  Colors.white,
                  CommonUtils.getPrimaryColor(),
                  width: _deviceSize.width,
                  padding: const EdgeInsets.symmetric(vertical: 28.0),
                  elevation: 2.0,
                ),
                SizedBox(height: 5.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FlatButton(
                      child: Text('아이디/비밀번호 찾기'),
                      textColor: Colors.white,
                      onPressed: () {},
                    ),
                    FlatButton(
                      child: Text('이메일 가입하기'),
                      textColor: Colors.white,
                      onPressed: () =>
                          CommonUtils.movePage(context, EmailSignUpPage()),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build text form field
  TextFormField _buildTextFormField(String hintText, Function validator,
      bool isPassword) {
    return TextFormField(
      obscureText: isPassword,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: Colors.red),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
      validator: validator,
    );
  }

  /// 로그인
  /// fixme :: 로그인 처리
  void _login() {
    if (_formKey.currentState.validate()) {
      print('로그인');
      /// fixme :: 임시로 메인페이지 이동
      CommonUtils.movePage(context, RootPage(CommonUtils.TYPE_MEMBER));
    }
  }
}
