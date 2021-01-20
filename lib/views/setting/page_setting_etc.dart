import 'package:fitwith/utils/utils_common.dart';
import 'package:fitwith/utils/utils_widget.dart';
import 'package:flutter/material.dart';

/// 기타 페이지 : X - 16
class SettingEtcPage extends StatefulWidget {
  @override
  _SettingEtcPageState createState() => _SettingEtcPageState();
}

class _SettingEtcPageState extends State<SettingEtcPage> {
  Size _deviceSize;

  @override
  Widget build(BuildContext context) {
    _deviceSize = MediaQuery.of(context).size;
    return WidgetUtils.buildScaffold(
      _buildBody(),
      appBar: WidgetUtils.buildAppBar(),
    );
  }

  /// Build body
  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildListTile('FITWITH 리뷰 쓰러가기', () {}),
          _buildListTile('개인정보 처리 방침', () {}),
          _buildListTile('정보 수신 동의 변경', () {}),
          _buildListTile('업데이트 확인', () {}),
          _buildListTile('이용약관', () {}),
          WidgetUtils.buildCustomButton(
            Text(
              '로그아웃',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            () {},
            Colors.transparent,
            CommonUtils.getColorByHex('#FF9B70'),
            width: _deviceSize.width,
            padding: const EdgeInsets.symmetric(vertical: 20.0),
          ),
          Divider(),
        ],
      ),
    );
  }

  /// Build list tile
  Widget _buildListTile(String text, Function onTap) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          title: Text(text),
          trailing: Icon(Icons.chevron_right, size: 30.0),
        ),
        Divider(),
      ],
    );
  }
}
