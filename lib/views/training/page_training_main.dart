import 'package:fitwith/utils/utils_common.dart';
import 'package:fitwith/utils/utils_widget.dart';
import 'package:fitwith/views/training/model/top_button.dart';
import 'package:fitwith/views/training/page_premium_member_management.dart';
import 'package:fitwith/views/training/page_search_around_trainer.dart';
import 'package:fitwith/views/training/widget/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 트레이닝 메인 페이지
class TrainingMainPage extends StatefulWidget {
  final String userType;

  TrainingMainPage({Key key, this.userType}) : super(key: key);

  @override
  _TrainingMainPageState createState() => _TrainingMainPageState();
}

class _TrainingMainPageState extends State<TrainingMainPage> {
  /// 기기 사이즈
  Size _deviceSize;

  /// 유저타입 회원여부
  bool _isMember = false;

  /// 유저타입 트레이너여부
  bool _isTrainer = false;

  /// 상단버튼 리스트 fixme :: 리스트 수정필요
  List<TopButton> _buttonList = [
    TopButton('HOT', true),
    TopButton('다이어트', false),
    TopButton('복부', false),
    TopButton('PT', false),
    TopButton('필라테스', false),
    TopButton('HOT', false),
    TopButton('다이어트', false),
    TopButton('복부', false),
    TopButton('PT', false),
    TopButton('필라테스', false),
  ];

  @override
  void initState() {
    _isMember = widget.userType == CommonUtils.TYPE_MEMBER;
    _isTrainer = widget.userType == CommonUtils.TYPE_TRAINER;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _deviceSize = MediaQuery.of(context).size;
    return WidgetUtils.buildScaffold(
      _buildBody(),
      appBar: WidgetUtils.buildAppBar(
        leading: IconButton(
          icon: Icon(
            Icons.notifications,
            color: CommonUtils.getPrimaryColor(),
            size: 30.0,
          ),
        ),
      ),
      endDrawer: buildDrawer(context),
    );
  }

  /// 바디
  Widget _buildBody() {
    return ListView(
      children: [
        SizedBox(height: 20.0),
        _buildTopButtonList(),
        // 상단 버튼 리스트
        _buildClassList(), // 내 수강/강의 목록
        _buildPremiumManagementList(), // 프리미엄 개인관리/내 프리미엄 회원
        if (_isMember)
          GestureDetector(
            onTap: () => CommonUtils.movePage(context, SearchAroundTrainerPage()),
            child: Container(
              width: _deviceSize.width,
              padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
              margin: const EdgeInsets.only(left: 46.0, right: 46.0),
              decoration: BoxDecoration(
                border: Border.all(color: CommonUtils.getAdditionalColor()),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(
                  '내 주변 트레이너 찾기',
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
          ), // 내 주변 트레이너 찾기
        SizedBox(height: 40.0),
        if (_isMember)
          Container(
            width: _deviceSize.width,
            padding: const EdgeInsets.all(CommonUtils.DEFAULT_PAGE_PADDING),
            child: RaisedButton(
              onPressed: () {},
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              ),
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Text('추천 강의 보러가기', style: TextStyle(fontSize: 18.0)),
              textColor: Colors.white,
              color: CommonUtils.getPrimaryColor(),
            ),
          ), // 추천강의 보러가기
        if (_isTrainer)
          Container(
            padding: const EdgeInsets.all(CommonUtils.DEFAULT_PAGE_PADDING),
            width: _deviceSize.width,
            child: RaisedButton(
              onPressed: () => CommonUtils.movePage(context, PremiumUserManagementPage()),
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              ),
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Text('프로젝트 등록하기', style: TextStyle(fontSize: 18.0)),
              textColor: Colors.white,
              color: CommonUtils.getPrimaryColor(),
            ),
          ), // 프로젝트 등록하기
      ],
    );
  }

  /// 상단 버튼 리스트 위젯
  Widget _buildTopButtonList() {
    return Container(
      height: 26.0,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        children: [
          ..._buttonList.map((e) => _buildTopButton(e)),
        ],
      ),
    );
  }

  /// 상단 버튼 위젯
  Widget _buildTopButton(TopButton button) {
    return GestureDetector(
      onTap: () {
        /// fixme :: 버튼 동작구현 필요
        print('버튼');
        _buttonList.where((e) => e.checked == true).toList().forEach((e) => e.checked = false);
        setState(() {
          button.checked = true;
        });
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(12.0, 3.0, 12.0, 3.0),
        margin: const EdgeInsets.only(left: 3.0, right: 3.0),
        decoration: BoxDecoration(
          color: button.checked ? Colors.white : CommonUtils.getAdditionalColor(),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Text(
            button.text,
            style: TextStyle(
              fontSize: 14.0,
              color: button.checked ? CommonUtils.getPrimaryColor() : CommonUtils.getSecondaryColor(),
            ),
          ),
        ),
      ),
    );
  }

  /// 내 수강/강의 목록
  Widget _buildClassList() {
    return Container(
      padding: const EdgeInsets.only(left: 30.0, top: 40.0, right: 30.0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                child: Text(
                  (_isMember) ? '내 수강 목록' : '내 강의 목록',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: CommonUtils.getSecondaryColor(),
                  ),
                ),
              ),
              SizedBox(width: 10.0),
            ],
          ),
          SizedBox(height: 20.0),
          _buildClass('복부비만 완전 정복 · 홍길동 트레이너'),
          _buildClass('하루 한끼 식단관리 · 홍길동 영양사'),
          Icon(Icons.keyboard_arrow_down, size: 30.0),
        ],
      ),
    );
  }

  /// 내 수강
  Widget _buildClass(String text, {Function onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: _deviceSize.width,
        padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
        margin: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 4.0),
        decoration: BoxDecoration(
          border: Border.all(color: CommonUtils.getAdditionalColor()),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
        ),
      ),
    );
  }

  /// 프리미엄 개인관리/프리미엄 회원
  Widget _buildPremiumManagementList() {
    return Container(
      padding: const EdgeInsets.only(left: 30.0, top: 40.0, right: 30.0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                child: Text(
                  (_isMember) ? '프리미엄 개인관리' : '내 프리미엄 회원',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: CommonUtils.getSecondaryColor(),
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              Icon(
                Icons.star,
                size: 22.0,
                color: Color(0xffff9b70),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          _buildPremiumManagement('김회원', '트레이닝 23일차'), // 프리미엄 회원
          Icon(Icons.keyboard_arrow_down, size: 30.0),
        ],
      ),
    );
  }

  /// 프리미엄 회원
  Widget _buildPremiumManagement(String user, String training) {
    return Container(
      width: _deviceSize.width,
      padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
      margin: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 4.0),
      decoration: BoxDecoration(
        border: Border.all(color: CommonUtils.getAdditionalColor()),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              user,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
            flex: 1,
          ),
          Expanded(
            child: Text(
              '|  ' + training,
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
            flex: 1,
          )
        ],
      ),
    );
  }
}
