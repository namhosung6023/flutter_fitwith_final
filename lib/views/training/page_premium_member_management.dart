import 'package:fitwith/utils/utils_common.dart';
import 'package:fitwith/utils/utils_widget.dart';
import 'package:fitwith/views/training/model/diet.dart';
import 'package:fitwith/views/training/model/exercise.dart';
import 'package:fitwith/views/training/widget/drawer.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

/// 트레이너_프리미엄 회원 관리 페이지
class PremiumUserManagementPage extends StatefulWidget {
  final String pageType; // 페이지유형
  PremiumUserManagementPage({Key key, this.pageType}) : super(key: key);

  @override
  _PremiumUserManagementPageState createState() => _PremiumUserManagementPageState();
}

class _PremiumUserManagementPageState extends State<PremiumUserManagementPage> {
  bool _editPage = false; // 수정페이지 여부
  bool _completePage = false; // 완료페이지 여부

  Size _deviceSize; // 기기사이즈

  CalendarController _calendarController = CalendarController(); // 캘린더 컨트롤러

  Map<int, String> _exerciseText = {1: '덤벨', 2: '조깅', 3: '필라테스'};
  Map<int, String> _exerciseDetailText = {1: '사이드 레터럴 레이즈', 2: '소자세'};

  /// fixme:: 운동 리스트 수정필요
  List<DropdownMenuItem> _exerciseItem = []; // Exercise 드롭다운 아이템
  List<DropdownMenuItem> _exerciseDetailItem = []; // ExerciseDetail 드롭다운 아이템

  List<Exercise> _exerciseList = []; // 운동 리스트

  Map<int, String> _dietText = {1: '아침', 2: '점심', 3: '저녁'};
  Map<int, String> _dietDetailText = {1: '사과 3개 바나나 1개', 2: '닭가슴살 샐러드', 3: '우유 한 컵'};

  /// fixme:: 식단 리스트 수정필요
  List<DropdownMenuItem> _dietItem = [];
  List<DropdownMenuItem> _dietDetailItem = [];

  List<Diet> _dietList = []; // 식단 리스트

  int _progressRate = 20; // 회원 달성율

  @override
  void initState() {
    _editPage = widget.pageType == CommonUtils.PAGE_TYPE_EDIT;
    _completePage = widget.pageType == CommonUtils.PAGE_TYPE_COMPLETE;

    _exerciseItem = [
      DropdownMenuItem(child: Text(_exerciseText[1]), value: 1),
      DropdownMenuItem(child: Text(_exerciseText[2]), value: 2),
      DropdownMenuItem(child: Text(_exerciseText[3]), value: 3),
    ];
    _exerciseDetailItem = [
      DropdownMenuItem(child: Text(_exerciseDetailText[1]), value: 1),
      DropdownMenuItem(child: Text(_exerciseDetailText[2]), value: 2),
    ];
    _exerciseList.add(Exercise(
      _exerciseItem[0].value,
      _exerciseText[_exerciseItem[0].value],
      ExerciseDetail(_exerciseDetailItem[0].value, _exerciseDetailText[_exerciseDetailItem[0].value], _exerciseDetailItem),
      _exerciseItem,
    ));

    List<DropdownMenuItem> _dietItem = [
      DropdownMenuItem(child: Text(_dietText[1]), value: 1),
      DropdownMenuItem(child: Text(_dietText[2]), value: 2),
      DropdownMenuItem(child: Text(_dietText[3]), value: 3),
    ];
    List<DropdownMenuItem> _dietDetailItem = [
      DropdownMenuItem(child: Text(_dietDetailText[1]), value: 1),
      DropdownMenuItem(child: Text(_dietDetailText[2]), value: 2),
      DropdownMenuItem(child: Text(_dietDetailText[3]), value: 3),
    ];
    _dietList.add(Diet(
      _dietItem[0].value,
      _dietText[_dietItem[0].value],
      DietDetail(_dietDetailItem[0].value, _dietDetailText[_dietDetailItem[0].value], _dietDetailItem),
      _dietItem,
    ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _deviceSize = MediaQuery.of(context).size;

    return WidgetUtils.buildScaffold(
      _buildBody(),
      appBar: WidgetUtils.buildAppBar(
        trailing: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.search,
            size: 30.0,
            color: CommonUtils.getSecondaryColor(),
          ),
        ),
      ),
      drawer: buildDrawer(context),
    );
  }

  /// 바디
  Widget _buildBody() {
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.all(CommonUtils.DEFAULT_PAGE_PADDING),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildUserInfo(), // 회원정보
              SizedBox(height: 20.0),
              _buildSelectDate(), // 일자 선택
              SizedBox(height: 20.0),
              Container(
                padding: (_editPage || _completePage) ? const EdgeInsets.only(left: 40.0, right: 40.0) : const EdgeInsets.all(0.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '운동',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ), // 운동 제목
                    SizedBox(height: 10.0),
                    ..._exerciseList.map((e) {
                      return _buildDropDownRow(exercise: e);
                    }), // 운동
                    if (!_editPage && !_completePage)
                      Center(
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              _exerciseList.add(Exercise(
                                _exerciseItem[0].value,
                                _exerciseText[_exerciseItem[0].value],
                                ExerciseDetail(
                                  _exerciseDetailItem[0].value,
                                  _exerciseDetailText[_exerciseDetailItem[0].value],
                                  _exerciseDetailItem,
                                ),
                                _exerciseItem,
                              ));
                            });
                          },
                          icon: Icon(
                            Icons.add_circle_outline,
                            color: Color(0xffC2C9D1),
                            size: 30.0,
                          ),
                        ),
                      ), // 운동 추가버튼
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                padding: (_editPage || _completePage) ? const EdgeInsets.only(left: 40.0, right: 40.0) : const EdgeInsets.all(0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '식단',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ), // 식단 제목
                    SizedBox(height: 10.0),
                    ..._dietList.map((e) {
                      return _buildDropDownRow(diet: e);
                    }), // 식단
                    if (!_editPage && !_completePage)
                      Center(
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              _dietList.add(Diet(
                                _dietItem[0].value,
                                _dietText[_dietItem[0].value],
                                DietDetail(
                                  _dietDetailItem[0].value,
                                  _dietDetailText[_dietDetailItem[0].value],
                                  _dietDetailItem,
                                ),
                                _dietItem,
                              ));
                            });
                          },
                          icon: Icon(
                            Icons.add_circle_outline,
                            color: Color(0xffC2C9D1),
                            size: 30.0,
                          ),
                        ),
                      ), // 식단 추가버튼
                    SizedBox(height: 20.0),
                    Center(
                      child: Text(
                        '*체크박스는 회원님의 표기 내역입니다.',
                        style: TextStyle(
                          color: Colors.deepOrangeAccent.withOpacity(0.7),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (_completePage) _buildUserAchievementRate(), // 회원달성율
              _buildComment(), // 코멘트
              _buildUserMemo(), // 회원메모
              SizedBox(height: 20.0),
              if (!_editPage && !_completePage)
                Container(
                  width: _deviceSize.width,
                  child: RaisedButton(
                    child: Text('일정 저장', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700)),
                    shape: RoundedRectangleBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    ),
                    color: CommonUtils.getPrimaryColor(),
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    textColor: Colors.white,

                    /// fixme:: 일정저장 기능필요
                    onPressed: () {},
                  ),
                ), // 일정 저장
            ],
          ),
        ),
      ],
    );
  }

  /// 회원정보
  Widget _buildUserInfo() {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: CircleAvatar(
                backgroundColor: CommonUtils.getAdditionalColor(),
                child: Image.asset('assets/ic_profile_default.png'),
              ),
              flex: 1,
            ),
            SizedBox(width: 4.0),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '김회원 | 남,41세',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  Text(
                    '트레이닝 25일차',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: CommonUtils.getPrimaryColor(),
                    ),
                  ),
                ],
              ),
              flex: 6,
            ),
          ],
        ),
        if (_editPage) SizedBox(height: 20.0),
        if (_editPage)
          TextFormField(
            decoration: InputDecoration(
              hintText: '회원 건강 정보 열람',
              suffixIcon: Icon(Icons.keyboard_arrow_down),
            ),
          ),
      ],
    );
  }

  /// 일자 선택
  Widget _buildSelectDate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '일자 선택',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff000000),
              ),
            ),
            if (_editPage)
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text('편집'),
                textColor: Colors.white,
                color: CommonUtils.getPrimaryColor(),

                /// fixme:: 편집 버튼 기능필요
                onPressed: () {},
              ),
          ],
        ),
        TableCalendar(
          calendarController: _calendarController,
          startingDayOfWeek: StartingDayOfWeek.sunday,
          availableCalendarFormats: const {
            CalendarFormat.month: 'Month',
          },
          calendarStyle: CalendarStyle(selectedColor: CommonUtils.getPrimaryColor()),
        ),
      ],
    );
  }

  /// 드롭다운 포함한 열 위젯
  Widget _buildDropDownRow({Exercise exercise, Diet diet}) {
    String _iconImage = '';
    Color _iconColor = Color(0xff707070);

    if (exercise != null) {
      _iconImage = 'assets/img_barbell.png';
      if (exercise.isChecked) _iconColor = CommonUtils.getPrimaryColor();
    } else if (diet != null) {
      _iconImage = 'assets/img_diet.png';
      if (diet.isChecked) _iconColor = CommonUtils.getPrimaryColor();
    }

    if (_editPage || _completePage) {
      // 일정수정/일정완료 페이지
      return Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.5))),
        ),
        child: Row(
          children: [
            Expanded(
              child: Image.asset(_iconImage, color: _iconColor),
              flex: 1,
            ),
            Expanded(
              child: Container(
                child: Row(
                  children: [
                    if (exercise != null)
                      Text(
                        '${exercise.name} - ${exercise.detail.name}',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: exercise.isChecked ? CommonUtils.getPrimaryColor() : Color(0xff707070),
                        ),
                      ),
                    if (diet != null)
                      Text(
                        '${diet.name} - ${diet.detail.name}',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: diet.isChecked ? CommonUtils.getPrimaryColor() : Color(0xff707070),
                        ),
                      ),
                  ],
                ),
              ),
              flex: 5,
            ),
            Expanded(
              child: Checkbox(
                value: exercise != null ? exercise.isChecked : diet.isChecked,
                onChanged: (bool value) {
                  setState(() {
                    if (exercise != null) exercise.isChecked = value;
                    if (diet != null) diet.isChecked = value;
                  });
                },
              ),
              flex: 1,
            ),
          ],
        ),
      );
    } else {
      // 일정입력 페이지
      return Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Image.asset(_iconImage),
                  flex: 1,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: DropdownButton(
                      isExpanded: true,
                      value: exercise != null ? exercise.value : diet.value,
                      items: exercise != null ? exercise.dropdownList : diet.dropdownList,
                      underline: SizedBox(),
                      icon: Icon(Icons.keyboard_arrow_down_rounded),
                      onChanged: (value) {
                        setState(() {
                          if (exercise != null) exercise.value = value;
                          if (diet != null) diet.value = value;
                        });
                      },
                    ),
                  ),
                  flex: 5,
                ),
                Expanded(
                  child: Icon(
                    Icons.keyboard_arrow_down_outlined,
                    size: 40.0,
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Checkbox(
                    value: exercise != null ? exercise.isChecked : diet.isChecked,
                    onChanged: (bool value) {
                      setState(() {
                        if (exercise != null) exercise.isChecked = value;
                        if (diet != null) diet.isChecked = value;
                      });
                    },
                  ),
                  flex: 1,
                ),
              ],
            ),
          ), // 운동
          Container(
            margin: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SizedBox(),
                  flex: 1,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: DropdownButton(
                      isExpanded: true,
                      value: exercise != null ? exercise.detail.value : diet.detail.value,
                      items: exercise != null ? exercise.detail.dropdownList : diet.detail.dropdownList,
                      underline: SizedBox(),
                      icon: Icon(Icons.keyboard_arrow_down_rounded),
                      onChanged: (value) {
                        setState(() {
                          if (exercise != null) exercise.detail.value = value;
                          if (diet != null) diet.detail.value = value;
                        });
                      },
                    ),
                  ),
                  flex: 5,
                ),
                Expanded(
                  child: Icon(
                    Icons.keyboard_arrow_down_outlined,
                    size: 40.0,
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: SizedBox(),
                  flex: 1,
                ),
              ],
            ),
          ), // 운동상세
        ],
      );
    }
  }

  /// 회원 달성율
  Widget _buildUserAchievementRate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.0),
        Text(
          '회원 달성율',
          style: TextStyle(
            color: Color(0xff495057),
            fontWeight: FontWeight.w700,
            fontSize: 16.0,
          ),
        ),
        SizedBox(height: 20.0),
        SizedBox(
          width: _deviceSize.width,
          height: 30.0,
          child: Stack(
            children: [
              Positioned(
                left: (_deviceSize.width - 40) * (_progressRate / 100) - 16.0,
                child: Image.asset(
                  'assets/img_progress_man.png',
                  color: CommonUtils.getPrimaryColor().withOpacity(0.5),
                  width: 32.0,
                  height: 30.0,
                ),
              ),
            ],
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: LinearProgressIndicator(
            value: _progressRate / 100,
            backgroundColor: CommonUtils.getPrimaryColor().withOpacity(0.3),
            valueColor: AlwaysStoppedAnimation<Color>(CommonUtils.getPrimaryColor()),
          ),
        ),
        SizedBox(height: 10.0),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '0%',
              style: TextStyle(color: Color(0xff949397)),
            ),
            Text(
              '100%',
              style: TextStyle(color: Color(0xff949397)),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text.rich(
          TextSpan(
              text: '목표 달성보다 ',
              style: TextStyle(
                color: CommonUtils.getPrimaryColor(),
              ),
              children: [
                TextSpan(
                  text: '${100 - _progressRate}% ',
                  style: TextStyle(
                    color: Colors.deepOrangeAccent.withOpacity(0.7),
                  ),
                ),
                TextSpan(text: '미달하였습니다'),
              ]),
        ),
        SizedBox(height: 20.0),
      ],
    );
  }

  /// 코멘트
  Widget _buildComment() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 20.0),
        Row(
          children: [
            Expanded(
              child: ClipOval(
                child: Image.asset('assets/img_sample.png', fit: BoxFit.cover, width: 40.0, height: 40.0),
              ),
              flex: 1,
            ), // 프로필
            SizedBox(width: 10.0),
            Expanded(
              child: Container(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextFormField(
                    initialValue: '',
                    decoration: InputDecoration(
                      hintText: 'comment',
                      contentPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              flex: 5,
            ), // 코멘트 입력칸
            SizedBox(width: 10.0),
            Expanded(
              child: Icon(
                Icons.arrow_circle_up_outlined,
                size: 40.0,
                color: CommonUtils.getPrimaryColor(),
              ),
              flex: 1,
            ), // 코멘트 저장
          ],
        ),
      ],
    );
  }

  /// 회원메모
  Widget _buildUserMemo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.0),
        Text(
          '회원 메모',
          style: TextStyle(
            color: CommonUtils.getSecondaryColor().withOpacity(0.5),
            fontSize: 14.0,
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: TextFormField(
            initialValue: '',
            decoration: InputDecoration(
              hintText: '글자 제한 200자',
              contentPadding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
              border: InputBorder.none,
            ),
            maxLines: 5,
            maxLength: 200,
          ),
        )
      ],
    );
  }
}
