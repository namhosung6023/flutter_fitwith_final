import 'package:fitwith/utils/utils_common.dart';
import 'package:fitwith/utils/utils_widget.dart';
import 'package:fitwith/views/login/page_email_login.dart';
import 'package:fitwith/views/page_root.dart';
import 'package:flutter/material.dart';

/// 로그인 페이지
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  static const String _TYPE_GOOGLE = 'google';
  static const String _TYPE_NAVER = 'naver';
  static const String _TYPE_EMAIL = 'email';

  @override
  Widget build(BuildContext context) {
    return WidgetUtils.buildScaffold(
      _buildBody(),
      backgroundColor: CommonUtils.getPrimaryColor(),
    );
  }

  /// Build body
  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.only(top: 80.0),
      child: Column(
        children: [
          Image.asset('assets/logo.png'),
          SizedBox(height: 10.0),
          Image.asset('assets/logo_text_white.png'),
          SizedBox(height: 80.0),
          Text(
            '시작하기',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 22.0,
            ),
          ),
          SizedBox(height: 30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialLoginButton(_TYPE_GOOGLE, () => _socialLogin(_TYPE_GOOGLE)),
              SizedBox(width: 15.0),
              _buildSocialLoginButton(_TYPE_NAVER, () => _socialLogin(_TYPE_NAVER)),
              SizedBox(width: 15.0),
              _buildSocialLoginButton(_TYPE_EMAIL, () => CommonUtils.movePage(context, EmailLoginPage())),
            ],
          ),
        ],
      ),
    );
  }

  /// 소셜로그인 버튼 위젯 생성
  Widget _buildSocialLoginButton(String type, Function onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 50.0,
        height: 50.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Image.asset('assets/ic_$type.png'),
      ),
    );
  }

  /// 소셜 로그인
  /// fixme :: 소셜 로그인 처리
  void _socialLogin(String type) {
    if (type == _TYPE_GOOGLE) {
      CommonUtils.movePage(context, RootPage(CommonUtils.TYPE_MEMBER));
    } else {
      CommonUtils.movePage(context, RootPage(CommonUtils.TYPE_TRAINER));
    }
  }
}
