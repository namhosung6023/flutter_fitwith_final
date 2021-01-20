import 'package:fitwith/utils/utils_common.dart';
import 'package:fitwith/utils/utils_widget.dart';
import 'package:fitwith/views/training/widget/drawer.dart';
import 'package:flutter/material.dart';

/// 일별 운동 페이지_전체 커리큘럼
class DailyExerciseAllCurriculumPage extends StatefulWidget {
  final String userType;

  DailyExerciseAllCurriculumPage({Key key, this.userType}) : super(key: key);

  @override
  _DailyExerciseAllCurriculumPageState createState() => _DailyExerciseAllCurriculumPageState();
}

class _DailyExerciseAllCurriculumPageState extends State<DailyExerciseAllCurriculumPage> {
  Size _deviceSize; // 기기사이즈
  bool _isMember = false; // 회원여부

  @override
  void initState() {
    _isMember = widget.userType == CommonUtils.TYPE_MEMBER;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _deviceSize = MediaQuery.of(context).size;

    return WidgetUtils.buildScaffold(
      _buildBody(),
      appBar: WidgetUtils.buildAppBar(),
      endDrawer: buildDrawer(context),
    );
  }

  /// 바디
  Widget _buildBody() {
    return ListView(
      padding: const EdgeInsets.all(CommonUtils.DEFAULT_PAGE_PADDING),
      children: [
        Center(
          child: Text(
            '복부 비만 완전 정복! 홍길동 트레이너',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18.0,
              color: Color(0xff707070),
            ),
          ),
        ),
        _buildAllCurriculum(),
      ],
    );
  }

  /// 전체 커리큘럼
  Widget _buildAllCurriculum() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30.0),
        Text(
          '전체 커리큘럼 확인',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 19.0,
            color: CommonUtils.getPrimaryColor(),
          ),
        ), // 전체 커리큘럼 확인
        SizedBox(height: 30.0),
        _buildCurriculumWeek(),
        _buildCurriculumWeek(),
        _buildCurriculumWeek(),
        _buildCurriculumWeek(),
      ],
    );
  }

  /// 주별 커리큘럼
  Widget _buildCurriculumWeek() {
    return Theme(
      data: ThemeData(
        dividerColor: Colors.transparent,
      ),
      child: ExpansionTile(
        title: Text('1주차'),
        tilePadding: const EdgeInsets.only(left: 10.0),
        expandedAlignment: Alignment.centerLeft,
        children: [
          Text('복부 지방 빼기 첫단계 \n습관부터 고치자! 간단한 생활속 운동 팁! \n회원님에게 딱 맞는 간단한 운동을 알려드립니다.'),
          SizedBox(height: 10.0),
          _buildCurriculumDay(),
          _buildCurriculumDay(),
          _buildCurriculumDay(),
          _buildCurriculumDay(),
        ],
      ),
    );
  }

  /// 일별 커리큘럼
  Widget _buildCurriculumDay() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xffE8EAEF))),
      ),
      child: Theme(
        data: ThemeData(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          title: Text('DAY1'),
          expandedAlignment: Alignment.centerLeft,
          childrenPadding: const EdgeInsets.only(left: 20.0),
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
            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xffE8EAEF))),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Image.asset('assets/img_barbell.png', color: Color(0xff707070)),
                    flex: 1,
                  ), // 운동 아이콘
                  Expanded(
                    child: Container(
                      child: Row(
                        children: [
                          Text(
                            '필라테스 - 소자세',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color(0xff707070),
                            ),
                          ),
                        ],
                      ),
                    ),
                    flex: 5,
                  ), // 운동 상세내용
                  if (_isMember)
                    Expanded(
                      child: Checkbox(
                        value: false,
                        onChanged: (bool value) {},
                      ), // 체크여부
                      flex: 1,
                    ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
