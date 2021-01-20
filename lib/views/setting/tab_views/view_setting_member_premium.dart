import 'package:fitwith/utils/utils_common.dart';
import 'package:fitwith/views/setting/widgets/widget_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/animation.dart';

/// 회원 프리미엄 탭뷰
class SettingMemberPremiumView extends StatefulWidget {
  @override
  _SettingMemberPremiumViewState createState() => _SettingMemberPremiumViewState();
}

class _SettingMemberPremiumViewState extends State<SettingMemberPremiumView> with TickerProviderStateMixin {
  Size _deviceSize;

  Map<DateTime, List> _events;
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _scheduleCalendarController;
  CalendarController _meetingCalendarController;

  // Example holidays
  final Map<DateTime, List> _holidays = {
    DateTime(2021, 1, 1): ['New Year\'s Day'],
    DateTime(2021, 1, 6): ['Epiphany'],
    DateTime(2021, 2, 14): ['Valentine\'s Day'],
    DateTime(2021, 4, 21): ['Easter Sunday'],
    DateTime(2021, 4, 22): ['Easter Monday'],
  };

  @override
  void initState() {
    initializeDateFormatting();

    final _selectedDay = DateTime.now();

    _events = {
      _selectedDay.subtract(Duration(days: 30)): ['Event A0', 'Event B0', 'Event C0'],
      _selectedDay.subtract(Duration(days: 27)): ['Event A1'],
      _selectedDay.subtract(Duration(days: 20)): ['Event A2', 'Event B2', 'Event C2', 'Event D2'],
      _selectedDay.subtract(Duration(days: 16)): ['Event A3', 'Event B3'],
      _selectedDay.subtract(Duration(days: 10)): ['Event A4', 'Event B4', 'Event C4'],
      _selectedDay.subtract(Duration(days: 4)): ['Event A5', 'Event B5', 'Event C5'],
      _selectedDay.subtract(Duration(days: 2)): ['Event A6', 'Event B6'],
      _selectedDay: ['Event A7', 'Event B7', 'Event C7', 'Event D7'],
      _selectedDay.add(Duration(days: 1)): ['Event A8', 'Event B8', 'Event C8', 'Event D8'],
      _selectedDay.add(Duration(days: 3)): Set.from(['Event A9', 'Event A9', 'Event B9']).toList(),
      _selectedDay.add(Duration(days: 7)): ['Event A10', 'Event B10', 'Event C10'],
      _selectedDay.add(Duration(days: 11)): ['Event A11', 'Event B11'],
      _selectedDay.add(Duration(days: 17)): ['Event A12', 'Event B12', 'Event C12', 'Event D12'],
      _selectedDay.add(Duration(days: 22)): ['Event A13', 'Event B13'],
      _selectedDay.add(Duration(days: 26)): ['Event A14', 'Event B14', 'Event C14'],
    };

    _selectedEvents = _events[_selectedDay] ?? [];
    _scheduleCalendarController = CalendarController();
    _meetingCalendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scheduleCalendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _deviceSize = MediaQuery.of(context).size;

    return _buildPremiumBody();
  }

  /// 프리미엄 미신청자인 경우
  Column _buildNoPremiumBody() {
    return Column(
      children: [
        Text(
          '프리미엄 이란?',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16.0,
            color: CommonUtils.getColorByHex('#495057'),
          ),
        ),
        SizedBox(height: 30.0),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '회원님들과 트레이너 님을 ',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: '1:1로 매칭',
                style: TextStyle(
                  color: CommonUtils.getPrimaryColor(),
                ),
              ),
              TextSpan(
                text: '시켜주는 서비스 입니다. 회원님들께서 원하는 지역의 트레이너를 매칭시켜 개인 관리를 용이하게 합니다.',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.0),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '앱에서는 개인 PT를 용이하게 하기 위한 서비스를 제공합니다. ',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: '운동부터 식단까지 ',
                style: TextStyle(
                  color: CommonUtils.getPrimaryColor(),
                ),
              ),
              TextSpan(
                text: '회원님의 상태를 한눈에 볼 수 있습니다.',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.0),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '트레이너님이 회원님과의 미팅 혹은 정보에 따라 운동과 식단 계획을 ',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: '회원님의 맞춤형 ',
                style: TextStyle(
                  color: CommonUtils.getPrimaryColor(),
                ),
              ),
              TextSpan(
                text: '으로 잡아 줄 수 있습니다.',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 30.0),
        Align(
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: () {
              /// fixme :: 프리미엄 미리보기 기능 추가
            },
            child: Text(
              '프리미엄 미리보기',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: CommonUtils.getColorByHex('#495057'),
              ),
            ),
          ),
        ),
        SizedBox(height: 30.0),
        SizedBox(
          width: _deviceSize.width,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: const EdgeInsets.all(20.0),
            onPressed: () {},
            child: Text(
              '맞춤 트레이너 보러가기',
              style: TextStyle(
                fontSize: 17.0,
              ),
            ),
            textColor: Colors.white,
            color: CommonUtils.getPrimaryColor(),
          ),
        ),
      ],
    );
  }

  /// 프리미엄 신청자인 경우
  Column _buildPremiumBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle('오늘의 일정 보기(D-23)'),
        SizedBox(height: 20.0),
        Calendar(
          _scheduleCalendarController,
          _events,
          _holidays,
        ),
        SizedBox(height: 8.0),
        _buildEventList(),
        SizedBox(height: 50.0),
        _buildAchievementRate(),
        SizedBox(height: 30.0),
        _buildPremiumTrainer(),
        SizedBox(height: 30.0),
        _buildTitle('미팅 신청'),
        SizedBox(height: 20.0),
        Calendar(
          _meetingCalendarController,
          _events,
          _holidays,
        ),
        SizedBox(height: 20.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '시간 선택',
                style: TextStyle(
                  color: CommonUtils.getColorByHex('#495057'),
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                width: 120.0,
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: CommonUtils.getPrimaryColor()),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: DropdownButton(
                  isExpanded: true,
                  isDense: true,
                  value: 9,
                  dropdownColor: CommonUtils.getAdditionalColor(),
                  elevation: 0,
                  underline: Container(),
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                  ),
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 16.0,
                    color: CommonUtils.getColorByHex('#C2C9D1'),
                  ),
                  items: [
                    DropdownMenuItem(
                      value: 9,
                      child: Text('09시'),
                    ),
                    DropdownMenuItem(
                      value: 10,
                      child: Text('10시'),
                    ),
                  ],
                  onChanged: (dynamic value) {
                    print(value);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 선택된 날짜의 이벤트 리스트 위젯 생성
  Widget _buildEventList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildEventTitle('운동'),
          SizedBox(height: 5.0),
          _buildEventItem('assets/ic_exercise.png', '필라테스-소자세'),
          _buildEventItem('assets/ic_exercise.png', '덤벨-사이드 레티럴 레이즈'),
          SizedBox(height: 10.0),
          _buildEventTitle('식단'),
          SizedBox(height: 5.0),
          _buildEventItem('assets/ic_food.png', '아침-닭가슴살 샐러드'),
          _buildEventItem('assets/ic_food.png', '점심-사과 3개 바나나 1개'),
          _buildEventItem('assets/ic_food.png', '저녁-자유식사'),
        ],
      ),
    );
  }

  /// 이벤트 아이템 위젯 생성
  Widget _buildEventItem(String imagePath, String text) {
    return Column(
      children: [
        SizedBox(
          height: 40.0,
          child: CheckboxListTile(
            contentPadding: const EdgeInsets.all(0.0),
            value: true,
            onChanged: (bool value) {},
            title: Text(
              text,
              style: TextStyle(
                fontSize: 13.0,
                color: CommonUtils.getPrimaryColor(),
              ),
            ),
            secondary: Image.asset(imagePath),
          ),
        ),
        Divider(),
      ],
    );
  }

  /// 이벤트 제목 위젯 생성
  Text _buildEventTitle(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.black.withOpacity(0.5),
        fontWeight: FontWeight.w500,
      ),
    );
  }

  /// 오늘의 달성률 위젯 생성
  Widget _buildAchievementRate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle('오늘의 달성율'),
        SizedBox(
          width: _deviceSize.width,
          height: 50.0,
          child: Stack(
            children: [
              Positioned(
                left: _deviceSize.width * 0.7 - 48.0,
                child: Image.asset(
                  'assets/img_progress_character.png',
                  width: 32.0,
                  height: 50.0,
                ),
              ),
            ],
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: LinearProgressIndicator(
            minHeight: 8.0,
            value: 0.7,
            valueColor: AlwaysStoppedAnimation<Color>(CommonUtils.getPrimaryColor()),
            backgroundColor: CommonUtils.getPrimaryColor().withOpacity(0.4),
          ),
        ),
        SizedBox(height: 5.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '0%',
              style: TextStyle(
                color: CommonUtils.getColorByHex('#949397'),
              ),
            ),
            Text(
              '100%',
              style: TextStyle(
                color: CommonUtils.getColorByHex('#949397'),
              ),
            ),
          ],
        ),
        SizedBox(height: 5.0),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '목표 달성까지 ',
                style: TextStyle(
                  color: CommonUtils.getPrimaryColor(),
                ),
              ),
              TextSpan(
                text: '38% ',
                style: TextStyle(
                  color: CommonUtils.getColorByHex('#FF9B70'),
                ),
              ),
              TextSpan(
                text: '남았습니다.',
                style: TextStyle(
                  color: CommonUtils.getPrimaryColor(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 프리미엄 관리 트레이너 위젯 생성
  Widget _buildPremiumTrainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: _buildTitle('프리미엄 관리 트레이너'),
        ),
        SizedBox(height: 30.0),
        Row(
          children: [
            Image.asset('assets/img_sample_banner.png', width: _deviceSize.width * 0.5),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                children: [
                  Text(
                    '홍길동 트레이너',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text('Apparently we had reached a great height in the atmosphere, for the...'),
                  SizedBox(height: 20.0),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildPremiumTrainerTag('#복부'),
                        _buildPremiumTrainerTag('#복근 운동'),
                        _buildPremiumTrainerTag('#복부'),
                        _buildPremiumTrainerTag('#복근 운동'),
                      ],
                    ),
                  ),
                  Divider(),
                  Row(
                    children: [
                      _buildPremiumTrainerIcon(Icons.favorite),
                      SizedBox(width: 5.0),
                      _buildPremiumTrainerText('200'),
                      SizedBox(width: 5.0),
                      _buildPremiumTrainerText('·'),
                      SizedBox(width: 5.0),
                      _buildPremiumTrainerIcon(Icons.chat_bubble_outline_rounded),
                      SizedBox(width: 5.0),
                      _buildPremiumTrainerText('120'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20.0),
        _buildPremiumTrainerTitle('센터 위치'),
        SizedBox(height: 10.0),
        Text('판교역로 235, 제주 첨단로 242'),
        SizedBox(height: 10.0),
        _buildPremiumTrainerTitle('연락처'),
        SizedBox(height: 10.0),
        Text('010-1234-5678'),
      ],
    );
  }

  /// 프리미엄 관리 트레이너 텍스트 위젯 생성
  ///   - 좋아요 개수, 댓글 개수
  Text _buildPremiumTrainerText(String text) {
    return Text(
      text,
      style: TextStyle(
        color: CommonUtils.getPrimaryColor(),
      ),
    );
  }

  /// 프리미엄 관리 트레이너 아이콘 위젯 생성
  Icon _buildPremiumTrainerIcon(IconData iconData) {
    return Icon(
      iconData,
      size: 18.0,
      color: CommonUtils.getPrimaryColor(),
    );
  }

  /// 프리미엄 관리 트레이너 태그 위젯 생성
  Widget _buildPremiumTrainerTag(String text) {
    return Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: Text(
        text,
        style: TextStyle(
          color: CommonUtils.getPrimaryColor(),
        ),
      ),
    );
  }

  /// 프리미엄 관리 트레이너 제목 위젯 생성
  Text _buildPremiumTrainerTitle(String text) {
    return Text(
      text,
      style: TextStyle(
        color: CommonUtils.getColorByHex('#707070'),
        fontWeight: FontWeight.w700,
        fontSize: 18.0,
      ),
    );
  }

  /// 제목 위젯 생성
  Text _buildTitle(String text) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16.0,
        color: CommonUtils.getColorByHex('#495057'),
      ),
    );
  }
}
