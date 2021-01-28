import 'package:fitwith/utils/utils_common.dart';
import 'package:fitwith/utils/utils_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';


/// 이메일 회원가입 페이지
class EmailSignUpPage extends StatefulWidget {
  @override
  _EmailSignUpPageState createState() => _EmailSignUpPageState();
}

class _EmailSignUpPageState extends State<EmailSignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String name = "";
  String password = "";
  String email = "";

  void _signUp() async {
    if (_formKey.currentState.validate()) {
      Scaffold.of(_formKey.currentContext).showSnackBar(
          SnackBar(content: Text('처리중')));
    }
    Dio dio = new Dio();
    String hashedPassword = sha512.convert(utf8.encode(password)).toString();
    Response response = await dio.post('http://10.0.2.2:3000/accounts/join',
        data: { "username": name, "email": email, "password": hashedPassword});
    print(response);
  }

  bool _agreementPrivacy = false; // 개인정보 이용 동의
  bool _agreementMarketing = false; // 마케팅 활용 동의

  Size _deviceSize;

  @override
  Widget build(BuildContext context) {
    _deviceSize = MediaQuery
        .of(context)
        .size;

    return WidgetUtils.buildScaffold(
      _buildBody(),
      backgroundColor: CommonUtils.getPrimaryColor(),
      appBar: WidgetUtils.buildAppBar(
        backgroundColor: CommonUtils.getPrimaryColor(),
        titleAssetPath: 'assets/logo_text_white.png',
      ),
    );
  }

  /// Build body
  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '회원 가입',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 50.0),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextFormField(
                    '이름',
                        (String value) {
                      if (value.isEmpty) return '이름을 입력하세요.';
                      name = value;
                      return null;
                    },
                    false
                ),
                SizedBox(height: 10.0),
                _buildTextFormField(
                    '이메일',
                        (String value) {
                      if (!value.contains('@')) return '이메일 형식에 맞게 입력하세요.';
                      email = value;
                      return null;
                    },
                    false
                ),
                SizedBox(height: 10.0),
                _buildTextFormField(
                    '비밀번호 입력',
                        (String value) {
                      if (value.length <= 7) return '비밀번호를 8자리 이상 입력하세요.';
                      password = value;
                      return null;
                    },
                    true
                ),
                SizedBox(height: 10.0),
                _buildTextFormField(
                    '비밀번호 확인',

                        (String value) {
                      print('value: $value');
                      if (value != password) return '비밀번호가 동일하지 않습니다.';
                      return null;
                    },
                    true
                ),
                SizedBox(height: 10.0),
                _buildCheckboxListTile(
                    '개인정보 이용 동의', _agreementPrivacy, (bool value) {
                  setState(() {
                    _agreementPrivacy = value;
                  });
                }),
                _buildCheckboxListTile(
                    '마케팅 활용 동의', _agreementMarketing, (bool value) {
                  setState(() {
                    _agreementMarketing = value;
                  });
                }),
                SizedBox(height: 10.0),
                WidgetUtils.buildCustomButton(
                  Text(
                    '회원가입',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  _signUp,
                  Colors.white,
                  CommonUtils.getPrimaryColor(),
                  width: _deviceSize.width,
                  padding: const EdgeInsets.symmetric(vertical: 28.0),
                  elevation: 2.0,
                ),
                FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('이미 회원이신가요? 로그인'),
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build checkbox list tile
  Widget _buildCheckboxListTile(String text, bool value, Function onChanged) {
    return Theme(
      data: ThemeData(unselectedWidgetColor: Colors.white),
      child: CheckboxListTile(
        title: Text(
          text,
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.white,
          ),
        ),
        value: value,
        dense: true,
        activeColor: CommonUtils.getPrimaryColor(),
        contentPadding: const EdgeInsets.all(0.0),
        controlAffinity: ListTileControlAffinity.leading,
        onChanged: onChanged,
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


}