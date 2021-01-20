import 'package:fitwith/utils/utils_common.dart';
import 'package:fitwith/utils/utils_widget.dart';
import 'package:fitwith/views/setting/tab_views/view_setting_member_favorite_training.dart';
import 'package:fitwith/views/setting/tab_views/view_setting_member_history.dart';
import 'package:fitwith/views/setting/tab_views/view_setting_member_premium.dart';
import 'package:fitwith/views/setting/tab_views/view_setting_member_training.dart';
import 'package:fitwith/views/setting/tab_views/view_setting_trainer_favorite_training.dart';
import 'package:fitwith/views/setting/tab_views/view_setting_trainer_history.dart';
import 'package:fitwith/views/setting/tab_views/view_setting_trainer_premium.dart';
import 'package:fitwith/views/setting/tab_views/view_setting_trainer_training.dart';
import 'package:flutter/material.dart';

/// 메인 페이지 : X - 10, 11, 12, 13, 14
/// 탭으로 구분되어 있음
class SettingMainPage extends StatefulWidget {
  final String type;

  SettingMainPage(this.type);

  @override
  _SettingMainPageState createState() => _SettingMainPageState();
}

class _SettingMainPageState extends State<SettingMainPage> {
  Size _deviceSize;
  int _tapIndex = 0;

  @override
  Widget build(BuildContext context) {
    _deviceSize = MediaQuery.of(context).size;

    return WidgetUtils.buildScaffold(
      _buildBody(),
      appBar: WidgetUtils.buildAppBar(
        trailing: IconButton(
          icon: Icon(
            Icons.settings_outlined,
            color: Colors.black.withOpacity(0.5),
          ),
          onPressed: () {
            /// fixme :: 기능 추가
          },
        ),
      ),
    );
  }

  /// Build body
  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(CommonUtils.DEFAULT_PAGE_PADDING),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.type == CommonUtils.TYPE_MEMBER)
            Text(
              '트레이너 등록하기',
              style: TextStyle(
                color: CommonUtils.getPrimaryColor(),
              ),
            ),
          SizedBox(height: 5.0),
          _buildInfoContainer(),
          SizedBox(height: 10.0),
          _buildTab(),
          SizedBox(height: 30.0),
          _buildTapView(),
          SizedBox(height: 80.0),
        ],
      ),
    );
  }

  /// 정보 컨테이너 위젯 생성
  Container _buildInfoContainer() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          border: Border.all(
        color: CommonUtils.getColorByHex('#E8EAEF'),
      )),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                overflow: Overflow.visible,
                children: [
                  SizedBox(
                    width: 60.0,
                    height: 60.0,
                    child: CircleAvatar(
                      child: Image.asset('assets/img_empty_profile.png'),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  Positioned(
                    bottom: -3.0,
                    right: -3.0,
                    child: Icon(
                      Icons.add_circle_outlined,
                      color: CommonUtils.getColorByHex('#2E3A59'),
                      size: 30.0,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 30.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '김회원',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(24.0),
                          onTap: () {},
                          child: Icon(
                            Icons.settings,
                            color: CommonUtils.getColorByHex('#2E3A59'),
                            size: 24.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3.0),
                    Text('남자 · 24세'),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 30.0),
          if (widget.type == CommonUtils.TYPE_MEMBER) _buildMemberCharacter(),
          _buildInfoRow('주소', '서울시 성동구'),
          SizedBox(height: 5.0),
          _buildInfoRow('휴대폰', '010-1234-5678'),
          SizedBox(height: 5.0),
          _buildInfoRow('이메일', 'besign_member@naver.com'),
        ],
      ),
    );
  }

  /// 정보 Row 위젯 생성
  Row _buildInfoRow(String title, String text) {
    return Row(
      children: [
        SizedBox(
          width: 80.0,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13.0,
              color: CommonUtils.getPrimaryColor(),
            ),
          ),
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 13.0,
          ),
        ),
      ],
    );
  }

  /// 탭 위젯 생성
  Row _buildTab() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildTapItem(0),
        _buildTapItem(1),
        _buildTapItem(2),
        _buildTapItem(3),
      ],
    );
  }

  /// 탭 아이템 위젯 생성
  Widget _buildTapItem(int index) {
    String text1 = '';
    String text2 = '';
    String image = '';

    switch (index) {
      case 0:
        text1 = '트레이닝';
        image = 'assets/ic_unselect_training.png';
        break;
      case 1:
        text1 = '관심 트레이닝';
        image = 'assets/ic_unselect_favorite.png';
        break;
      case 2:
        text1 = '프리미엄';
        image = 'assets/ic_unselected_nav_1.png';
        break;
      case 3:
        text1 = '구매/문의';
        text2 = '내역';
        image = 'assets/ic_unselect_history.png';
        break;
    }

    return InkWell(
      onTap: () {
        setState(() {
          _tapIndex = index;
        });
      },
      child: Column(
        children: [
          Image.asset(image, height: 40.0, color: _tapIndex == index ? CommonUtils.getPrimaryColor() : CommonUtils.getColorByHex('#BABABA')),
          SizedBox(height: 2.0),
          Text(
            text1,
            style: TextStyle(
              color: _tapIndex == index ? CommonUtils.getPrimaryColor() : CommonUtils.getColorByHex('#BABABA'),
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            text2,
            style: TextStyle(
              color: _tapIndex == index ? CommonUtils.getPrimaryColor() : CommonUtils.getColorByHex('#BABABA'),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  /// 선택된 탭에 따른 탭 뷰 위젯 생성
  Widget _buildTapView() {
    switch (_tapIndex) {
      case 0:
        return widget.type == CommonUtils.TYPE_MEMBER ? SettingMemberTrainingView() : SettingTrainerTrainingView();
      case 1:
        return widget.type == CommonUtils.TYPE_MEMBER ? SettingMemberFavoriteTrainingView() : SettingTrainerFavoriteTrainingView();
      case 2:
        return widget.type == CommonUtils.TYPE_MEMBER ? SettingMemberPremiumView() : SettingTrainerPremiumView();
      case 3:
        return widget.type == CommonUtils.TYPE_MEMBER ? SettingMemberHistoryView() : SettingTrainerHistoryView();
    }

    return Container();
  }

  /// 회원 캐릭터 위젯 생성
  Widget _buildMemberCharacter() {
    return Column(
      children: [
        Row(
          children: [
            Image.asset(
              'assets/img_character.png',
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('LV.1'),
                  SizedBox(height: 5.0),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: LinearProgressIndicator(
                      minHeight: 12.0,
                      value: 0.6,
                      valueColor: AlwaysStoppedAnimation<Color>(CommonUtils.getColorByHex('#45B7E9')),
                      backgroundColor: CommonUtils.getColorByHex('#E5E5E5'),
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Container(
                    width: _deviceSize.width,
                    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
                    decoration: BoxDecoration(
                      color: CommonUtils.getColorByHex('#E5E5E5'),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      'Lv.2까지 한 개의 트레이닝이 남았어요.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 50.0),
      ],
    );
  }
}
