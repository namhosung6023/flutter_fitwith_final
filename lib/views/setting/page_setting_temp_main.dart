import 'package:fitwith/utils/utils_common.dart';
import 'package:fitwith/utils/utils_widget.dart';
import 'package:fitwith/views/setting/page_setting_etc.dart';
import 'package:fitwith/views/setting/page_setting_info_member.dart';
import 'package:fitwith/views/setting/page_setting_info_trainer.dart';
import 'package:fitwith/views/setting/page_setting_main.dart';
import 'package:fitwith/views/setting/page_setting_review.dart';
import 'package:fitwith/views/setting/page_setting_training_detail.dart';
import 'package:flutter/material.dart';

/// 임시용 세팅 메인 페이지
/// fixme :: 차후에 연결해야됨.
class SettingTempMainPage extends StatefulWidget {
  final String type;

  SettingTempMainPage(this.type);

  @override
  _SettingTempMainPageState createState() => _SettingTempMainPageState();
}

class _SettingTempMainPageState extends State<SettingTempMainPage> {
  @override
  Widget build(BuildContext context) {
    return WidgetUtils.buildScaffold(
      _buildBody(),
    );
  }

  /// Build body
  Widget _buildBody() {
    return ListView(
      children: [
        ListTile(
          title: Text('회원정보 수정_회원 : X - 17, X - 18'),
          onTap: () => CommonUtils.movePage(context, SettingInfoMemberPage()),
        ),
        ListTile(
          title: Text('회원정보 수정_트레이너 : X - 18, X - 19'),
          onTap: () => CommonUtils.movePage(context, SettingInfoTrainerPage()),
        ),
        ListTile(
          title: Text('마이페이지_프리미엄 : X - 10, 11, 13, 14'),
          onTap: () => CommonUtils.movePage(context, SettingMainPage(widget.type)),
        ),
        ListTile(
          title: Text('마이페이지_회원_트레이닝 : X - 11'),
          onTap: () => CommonUtils.movePage(context, SettingTrainingDetailPage()),
        ),
        ListTile(
          title: Text('기타 : X - 16'),
          onTap: () => CommonUtils.movePage(context, SettingEtcPage()),
        ),
        ListTile(
          title: Text('프로젝트 리뷰 : X - 12'),
          onTap: () => CommonUtils.movePage(context, SettingReviewPage()),
        ),
      ],
    );
  }
}
