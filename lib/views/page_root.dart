import 'package:fitwith/main.dart';
import 'package:fitwith/utils/utils_common.dart';
import 'package:fitwith/views/premium/page_premium_member.dart';
import 'package:fitwith/views/premium/page_premium_trainer.dart';
import 'package:fitwith/views/setting/page_setting_temp_main.dart';
import 'package:fitwith/views/training/page_training_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class RootPage extends StatefulWidget {
  final int tabIndex; // 하단 네비게이션 탭 인덱스
  final String type; // fixme :: 디버그용

  RootPage(this.type, {Key key, this.tabIndex = 2}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {

  // 하단 네비게이션 화면 키 리스트
  final List<GlobalKey<NavigatorState>> _keyList = [tabNavKey1, tabNavKey2, tabNavKey3, tabNavKey4, tabNavKey5];

  int _tabIndex = 0; // 하단 네비게이션 탭 인덱스
  CupertinoTabController _tabBarController; // 하단 네비게이션 컨트롤러

  @override
  void initState() {
    _tabIndex = widget.tabIndex;
    _tabBarController = CupertinoTabController(initialIndex: _tabIndex);
    _tabBarController.addListener(() {
      // 하단 네비게이션 탭
      if (_keyList[_tabBarController.index].currentState != null && _keyList[_tabBarController.index].currentState.canPop()) {
        _keyList[_tabBarController.index].currentState.popUntil((route) => route.isFirst); // root 페이지로 이동
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // 하단 네비게이션 화면 리스트
    List _screenList = [
      widget.type == CommonUtils.TYPE_MEMBER ? PremiumMemberPage() : PremiumTrainerPage(), // 프리미엄 관리
      Container(), // 게시판
      TrainingMainPage(userType: widget.type), // 트레이닝
      Container(), // 쇼핑
      SettingTempMainPage(widget.type), // 마이페이지 fixme :: 임시 메인 페이지
    ];

    return WillPopScope(
      onWillPop: () async {
        if (_tabBarController.index == 2) {
          return !await _keyList[_tabBarController.index].currentState.maybePop();
        } else {
          if (!await _keyList[_tabBarController.index].currentState.maybePop()) {
            _tabBarController.index = 2;
          }
          return false;
        }
      },
      child: CupertinoTabScaffold(
        controller: _tabBarController,
        tabBar: CupertinoTabBar(
          items: [
            _buildBottomNavigationBarItem('assets/ic_unselected_nav_1.png', '프리미엄 관리'),
            _buildBottomNavigationBarItem('assets/ic_unselected_nav_2.png', '게시판'),
            _buildBottomNavigationBarItem('assets/ic_unselected_nav_3.png', '트레이닝'),
            _buildBottomNavigationBarItem('assets/ic_unselected_nav_4.png', '쇼핑'),
            _buildBottomNavigationBarItem('assets/img_empty_profile.png', '마이페이지'), // fixme :: 이미지를 다운 받을수 없어서 임시용
          ],
        ),
        tabBuilder: (context, index) {
          return CupertinoTabView(
            navigatorKey: _keyList[index],
            builder: (BuildContext context) {
              return _screenList[index];
            },
          );
        },
      ),
    );
  }

  /// 하단 네비게이션 바 아이템 위젯 생성
  BottomNavigationBarItem _buildBottomNavigationBarItem(String assetPath, String label) {
    return BottomNavigationBarItem(
      icon: Image.asset(assetPath),
      activeIcon: Image.asset(assetPath, color: CommonUtils.getPrimaryColor()),
      label: label,
    );
  }
}
