import 'package:fitwith/utils/utils_common.dart';
import 'package:fitwith/utils/utils_widget.dart';
import 'package:fitwith/views/training/widget/drawer.dart';
import 'package:flutter/material.dart';

/// 일별 운동 페이지_예약업로드관리
class ManagementReservationUploadPage extends StatefulWidget {
  @override
  _ManagementReservationUploadPageState createState() => _ManagementReservationUploadPageState();
}

class _ManagementReservationUploadPageState extends State<ManagementReservationUploadPage> {
  Size _deviceSize;
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: _currentIndex);
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
    return Column(
      children: [
        SizedBox(height: 20.0),
        Expanded(
          child: Center(
            child: Text(
              '복부 비만 완전 정복! 홍길동 트레이너',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18.0,
                color: Color(0xff707070),
              ),
            ),
          ),
          flex: 1,
        ),
        SizedBox(height: 20.0),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: CommonUtils.DEFAULT_PAGE_PADDING, right: CommonUtils.DEFAULT_PAGE_PADDING),
            child: Row(
              children: [
                Text(
                  '강의 영상 관리',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 19.0,
                    color: CommonUtils.getPrimaryColor(),
                  ),
                ),
              ],
            ),
          ),
          flex: 1,
        ),
        SizedBox(height: 20.0),
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: (int val) {
              setState(() {
                _currentIndex = val;
              });
            },
            children: [
              _buildManagementVideo(),
              _buildManagementVideo(),
              _buildManagementVideo(),
              _buildManagementVideo(),
            ],
          ),
          flex: 18,
        ),
      ],
    );
  }

  /// 강의 영상 관리
  Widget _buildManagementVideo() {
    return ListView(
      padding: const EdgeInsets.only(left: CommonUtils.DEFAULT_PAGE_PADDING, right: CommonUtils.DEFAULT_PAGE_PADDING),
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (_currentIndex != 0)
                  IconButton(
                    onPressed: () => _pageController.previousPage(duration: Duration(milliseconds: 500), curve: Curves.ease),
                    icon: Icon(
                      Icons.arrow_back_ios_outlined,
                      color: Color(0xff707070),
                    ),
                  ),
                SizedBox(width: 6.0),
                Text(
                  '1주차',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.0,
                    color: Color(0xff707070),
                  ),
                ),
                SizedBox(width: 6.0),
                if (_currentIndex != 3)
                  IconButton(
                    onPressed: () => _pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease),
                    icon: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Color(0xff707070),
                    ),
                  ),
              ],
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Text(
                '수정',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 16.0,
                ),
              ),
              color: CommonUtils.getPrimaryColor(),
              onPressed: () {},
            ),
          ],
        ),
        SizedBox(height: 20.0),
        Text(
          'DAY1',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
            color: Color(0xff707070),
          ),
        ),
        SizedBox(height: 20.0),
        Padding(
          padding: const EdgeInsets.only(left: 40.0, right: 40.0),
          child: Text(
            '운동',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
              color: Color(0xff000000).withOpacity(0.5),
            ),
          ),
        ),
        SizedBox(height: 10.0),
        _buildExerciseWidget(),
        _buildExerciseWidget(),
        Padding(
          padding: const EdgeInsets.only(left: 40.0, right: 40.0),
          child: Text(
            '식단',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
              color: Color(0xff000000).withOpacity(0.5),
            ),
          ),
        ),
        SizedBox(height: 10.0),
        _buildDietWidget(),
        SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.only(left: 100.0, right: 100.0),
          child: Divider(height: 1.0, thickness: 1.0, color: Color(0xff000000).withOpacity(0.12)),
        ),
        SizedBox(height: 10.0),
        _buildDietWidget(),
        SizedBox(height: 20.0),
        Padding(
          padding: const EdgeInsets.only(left: 40.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: CommonUtils.getAdditionalColor()),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextFormField(
                    initialValue: 'comment',
                    style: TextStyle(
                      color: Color(0xff707070),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(10.0),
                    ),
                    maxLines: 1,
                  ),
                ),
                flex: 9,
              ),
              SizedBox(width: 6.0),
              Expanded(
                child: Icon(
                  Icons.arrow_circle_up_outlined,
                  color: CommonUtils.getPrimaryColor(),
                  size: 40.0,
                ),
                flex: 1,
              ),
            ],
          ),
        ),
        SizedBox(height: 20.0),
      ],
    );
  }

  /// 운동 위젯
  Widget _buildExerciseWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0, right: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 160.0,
            decoration: BoxDecoration(
              color: CommonUtils.getAdditionalColor(),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(child: Icon(Icons.play_circle_outline, color: Colors.white, size: 40.0)),
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/img_barbell.png'),
              SizedBox(width: 20.0),
              Text(
                '필라테스 - 소자세',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff000000).withOpacity(0.5),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: CommonUtils.getAdditionalColor()),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: TextFormField(
              style: TextStyle(
                color: Color(0xff707070),
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
              ),
              initialValue: '10회씩 3세트 해주시면 됩니다. 허리에 무리가 가지 않도록 유의 하면서 진행해주세요.',
              maxLines: 3,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(10.0),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {},
                child: Text(
                  '수정',
                  style: TextStyle(
                    color: CommonUtils.getPrimaryColor(),
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              GestureDetector(
                onTap: () {},
                child: Text(
                  '삭제',
                  style: TextStyle(
                    color: Color(0xffFF0000).withOpacity(0.52),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }

  /// 식단 위젯
  Widget _buildDietWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0, right: 40.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/img_diet.png'),
              SizedBox(width: 20.0),
              Text(
                '아침 - 닭가슴살 샐러드',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff000000).withOpacity(0.5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
