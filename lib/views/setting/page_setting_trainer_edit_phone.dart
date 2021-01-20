import 'package:fitwith/utils/utils_common.dart';
import 'package:fitwith/utils/utils_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 마이페이지_트레이너_전화번호 수정 : X - 17
class SettingTrainerEditPhonePage extends StatefulWidget {
  @override
  _SettingTrainerEditPhonePageState createState() => _SettingTrainerEditPhonePageState();
}

class _SettingTrainerEditPhonePageState extends State<SettingTrainerEditPhonePage> {
  @override
  Widget build(BuildContext context) {
    return WidgetUtils.buildScaffold(
      _buildBody(),
      appBar: WidgetUtils.buildAppBar(),
    );
  }

  /// Build body
  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(CommonUtils.DEFAULT_PAGE_PADDING),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '전화번호 수정',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
          SizedBox(height: 30.0),
          _buildText('휴대폰 번호'),
          SizedBox(height: 20.0),
          _buildTextFormField(hintText: '01012345678'),
          SizedBox(height: 20.0),
          WidgetUtils.buildCustomButton(
            Text('인증번호 발송'),
            () {},
            CommonUtils.getPrimaryColor(),
            Colors.white,
            padding: const EdgeInsets.all(20.0),
          ),
          SizedBox(height: 20.0),
          _buildText('인증번호 입력'),
          SizedBox(height: 20.0),
          _buildTextFormField(hintText: '6자리'),
          SizedBox(height: 20.0),
          WidgetUtils.buildCustomButton(
            Text('확인'),
            () {},
            CommonUtils.getPrimaryColor(),
            Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 20.0),
          ),
        ],
      ),
    );
  }

  /// 텍스트 필드 위젯 생성
  TextFormField _buildTextFormField({String hintText}) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: CommonUtils.getColorByHex('#222224').withOpacity(0.2),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
            color: CommonUtils.getColorByHex('#C2C9D1'),
          ),
        ),
      ),
    );
  }

  /// 텍스트 위젯 생성
  Widget _buildText(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
          color: CommonUtils.getColorByHex('#222224'),
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
