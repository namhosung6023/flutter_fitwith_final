import 'package:fitwith/views/training/page_daily_exercise_all_curriculum.dart';
import 'package:fitwith/views/training/page_management_reservation_upload.dart';
import 'package:fitwith/views/training/page_management_student.dart';
import 'package:fitwith/utils/utils_common.dart';
import 'package:fitwith/utils/utils_widget.dart';
import 'package:fitwith/views/training/page_online_consulting.dart';
import 'package:fitwith/views/training/widget/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

/// 주별 운동 페이지.
class WeeklyTrainingPage extends StatefulWidget {
  /// 로그인 타입.
  final String userType;

  WeeklyTrainingPage({Key key, this.userType}) : super(key: key);

  @override
  _WeeklyTrainingPageState createState() => _WeeklyTrainingPageState();
}

class _WeeklyTrainingPageState extends State<WeeklyTrainingPage> {
  static const _TRAINER_SHEET_HEIGHT = 120.0;

  static const _MEMBER_SHEET_HEIGHT = 210.0;

  static const _SHEET_MIN_HEIGHT = .0;

  /// animation widget key.
  final _animationKey = GlobalKey();

  ///
  final TextEditingController _commentCtrl = TextEditingController();

  /// animation widget height.
  var _sheetHeight = _SHEET_MIN_HEIGHT;

  /// 트레이너 코멘트 수정 모드 여부.
  var _isEditMode = false;

  Size _deviceSize;

  /// 유저타입 회원여부
  bool _isMember = false;

  /// 유저타입 트레이너여부
  bool _isTrainer = false;

  @override
  void initState() {
    if (this._commentCtrl.text.isEmpty) this._commentCtrl.text = '운동을 하실 때 복부의 힘을 생각하며 해주세요';
    _isMember = widget.userType == CommonUtils.TYPE_MEMBER;
    _isTrainer = widget.userType == CommonUtils.TYPE_TRAINER;
    super.initState();
    CommonUtils.setKeyboardListener(context);
  }

  @override
  Widget build(BuildContext context) {
    _deviceSize = MediaQuery.of(context).size;

    return WidgetUtils.buildScaffold(
      Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(height: 16.0),
          _buildHeader(),
          const SizedBox(height: 16.0),
          Expanded(
            child: Stack(
              children: [
                ListView(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  children: List.generate(10, (i) => _buildTrainingItem(i)),
                ),
                Positioned(left: .0, right: .0, bottom: .0, child: _buildBottomPopupMenu()),
              ],
            ),
          ),
        ],
      ),
      appBar: WidgetUtils.buildAppBar(),
      endDrawer: buildDrawer(context),
    );
  }

  /// 헤더 위젯 빌드.
  Widget _buildHeader() {
    final member = Text(
      this._commentCtrl.text,
      style: TextStyle(
        color: Colors.grey,
        fontSize: 14.0,
      ),
    );

    final trainer = (this._isEditMode)
        ? TextField(
            controller: this._commentCtrl,
            style: TextStyle(
              fontSize: 14.0,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          )
        : Text(
            this._commentCtrl.text,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14.0,
            ),
          );

    final edit = InkWell(
      child: Text(
        '확인',
        style: TextStyle(
          color: CommonUtils.getPrimaryColor(),
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {
        setState(() {
          this._isEditMode = false;
        });
      },
    );

    final submit = InkWell(
      child: Text(
        '편집',
        style: TextStyle(
          color: CommonUtils.getPrimaryColor(),
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {
        setState(() {
          this._isEditMode = true;
        });
      },
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '복부 비만 완전 정복! 홍길동 트레이너',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xff707070),
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24.0),
        Row(
          children: [
            const SizedBox(width: 48.0),
            WidgetUtils.buildNotificationIcon(size: 28.0),
            const SizedBox(width: 14.0),
            Expanded(child: (_isMember) ? member : trainer),
            if (_isTrainer) const SizedBox(width: 14.0),
            if (_isTrainer && this._isEditMode) edit,
            if (_isTrainer && !this._isEditMode) submit,
            const SizedBox(width: 48.0),
          ],
        ),
      ],
    );
  }

  /// 운동 아이템 위젯 빌드.
  Widget _buildTrainingItem(int i) {
    return Padding(
      padding: const EdgeInsets.only(left: 48.0, right: 48.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 24.0),
          Text(
            '2020년 10월 24일',
            style: TextStyle(
              color: Color(0xff707070),
            ),
          ),
          Divider(height: 8.0, color: Colors.grey),
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset('assets/img_video_sample.png', width: double.infinity),
              Icon(Icons.play_circle_outline, size: 64.0, color: Colors.white),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person_outline, color: Color(0xff707070), size: 24.0),
              const SizedBox(width: 8.0),
              Text('덤벨 - 사이드 레터럴 레이즈'),
            ],
          ),
          Divider(height: 16.0, color: Colors.grey),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: Text(
              '10회씩 3세트 해주시면 됩니다. 허리에 무리가 가지 않도록 유의 하면서 진행해주세요.',
              style: TextStyle(
                height: 1.5,
                color: Color(0xff707070),
                fontSize: 13.0,
              ),
            ),
          ),
          const SizedBox(height: 24.0),
        ],
      ),
    );
  }

  ///
  Widget _buildBottomPopupMenu() {
    final buildMenu = (IconData icons, String value, {void onTap()}) => GestureDetector(
          onTap: onTap,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icons, color: Colors.white, size: 32.0),
              const SizedBox(height: 8.0),
              Text(
                value,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );

    final trainerMenu = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buildMenu(
          Icons.work_outline,
          '전체 커리큘럼',
          onTap: () => CommonUtils.movePage(context, DailyExerciseAllCurriculumPage(userType: widget.userType)),
        ),
        buildMenu(
          Icons.person_outline,
          '수강생 관리',
          onTap: () => CommonUtils.movePage(context, ManagementStudentPage()),
        ),
        buildMenu(
          Icons.access_time,
          '강의 영상 관리',
          onTap: () => CommonUtils.movePage(context, ManagementReservationUploadPage()),
        ),
      ],
    );

    final Size size = MediaQuery.of(context).size;

    final memberMenu = Padding(
      padding: const EdgeInsets.only(left: 32.0, right: 32.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '오늘의 진도율 (12일째)',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          SizedBox(
            width: _deviceSize.width,
            height: 30.0,
            child: Stack(
              children: [
                Positioned(
                  left: (_deviceSize.width - 64) * (50 / 100) - 16.0,
                  child: Image.asset(
                    'assets/img_progress_man.png',
                    color: Colors.white.withOpacity(0.95),
                    width: 32.0,
                    height: 30.0,
                  ),
                ),
              ],
            ),
          ),
          LinearPercentIndicator(
            width: size.width - 64.0,
            percent: 0.5,
            lineHeight: 6.0,
            backgroundColor: Colors.white24,
            progressColor: Colors.white,
          ),
          const SizedBox(height: 4.0),
          Text(
            '50%',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.0,
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            '67% 달성 완료',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.0,
            ),
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildMenu(Icons.work_outline, 'To Do List'),
              buildMenu(
                Icons.feedback_outlined,
                '온라인 상담',
                onTap: () => CommonUtils.movePage(context, OnlineConsultingPage()),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
        ],
      ),
    );

    final action = GestureDetector(
      onTap: _onTapActionSheet,
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: Icon(
          (this._sheetHeight == _SHEET_MIN_HEIGHT) ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
          color: Colors.white,
          size: 40.0,
        ),
        decoration: BoxDecoration(
          color: CommonUtils.getPrimaryColor(),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(32.0), topRight: Radius.circular(32.0)),
        ),
      ),
    );

    final sheet = AnimatedContainer(
      key: this._animationKey,
      duration: Duration(milliseconds: 200),
      curve: Curves.bounceInOut,
      height: this._sheetHeight,
      color: CommonUtils.getPrimaryColor(),
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: (_isMember) ? memberMenu : trainerMenu,
      ),
    );

    return Column(
      children: [
        action,
        sheet,
      ],
    );
  }

  /// on tap action sheet top bar.
  void _onTapActionSheet() {
    setState(() {
      if (_isMember) {
        this._sheetHeight = (this._sheetHeight == _SHEET_MIN_HEIGHT) ? _MEMBER_SHEET_HEIGHT : _SHEET_MIN_HEIGHT;
      } else {
        this._sheetHeight = (this._sheetHeight == _SHEET_MIN_HEIGHT) ? _TRAINER_SHEET_HEIGHT : _SHEET_MIN_HEIGHT;
      }
    });
  }
}
