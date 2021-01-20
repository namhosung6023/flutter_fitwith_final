import 'package:fitwith/utils/utils_common.dart';
import 'package:fitwith/utils/utils_widget.dart';
import 'package:fitwith/views/training/widget/drawer.dart';
import 'package:flutter/material.dart';

/// 일별 운동 페이지_수강관리
class ManagementStudentPage extends StatefulWidget {
  @override
  _ManagementStudentPageState createState() => _ManagementStudentPageState();
}

class _ManagementStudentPageState extends State<ManagementStudentPage> {
  Size _deviceSize;

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
        _buildManagement(),
        _buildConsulting(),
      ],
    );
  }

  /// 관리
  Widget _buildManagement() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30.0),
        Text(
          '수강생 관리',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 19.0,
            color: CommonUtils.getPrimaryColor(),
          ),
        ),
        SizedBox(height: 30.0),
        Text(
          '관리',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18.0,
            color: Color(0xff707070),
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          '수강생 현황',
          style: TextStyle(
            fontSize: 16.0,
            color: Color(0xff707070),
          ),
        ),
        SizedBox(height: 20.0),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Text(
                '총 수강생',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xff707070),
                ),
              ),
            ),
            Expanded(
              child: Text(
                '신규',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xff707070),
                ),
              ),
            ),
            Expanded(
              child: Text(
                '수강 완료',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xff707070),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Text(
                '25명',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff707070),
                ),
              ),
            ),
            Expanded(
              child: Text(
                '8명',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff707070),
                ),
              ),
            ),
            Expanded(
              child: Text(
                '5명',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff707070),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// 1:1 문의
  Widget _buildConsulting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30.0),
        Text(
          '1:1 문의',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18.0,
            color: Color(0xff707070),
          ),
        ),
        SizedBox(height: 30.0),
        ListTile(
          trailing: SizedBox(),
          title: Row(
            children: [
              Expanded(
                child: Text(
                  '유저이름',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff707070),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  '내용',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff707070),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  '시간',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff707070),
                  ),
                ),
              ),
            ],
          ),
        ),
        _buildConsultingItem(),
        _buildConsultingItem(),
        _buildConsultingItem(),
      ],
    );
  }

  /// 1:1 문의 아이템
  Widget _buildConsultingItem() {
    return Theme(
      data: ThemeData(
        dividerColor: Colors.transparent,
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.all(0.0),
        title: Row(
          children: [
            Expanded(child: Text('김회원', textAlign: TextAlign.center)),
            Expanded(child: Text('허리가 아파요', textAlign: TextAlign.center)),
            Expanded(child: Text('2020.11.01', textAlign: TextAlign.center)),
          ],
        ),
        children: [
          Center(child: Icon(Icons.keyboard_arrow_down)),
          Divider(thickness: 1.0, color: Color(0xff000000).withOpacity(0.12)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Image.asset('assets/img_around_trainer.png')), // 프로필
              SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '허리가 아파요',
                      style: TextStyle(
                        color: CommonUtils.getPrimaryColor(),
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Apparently we had reached a great height in the atmosphere, for the...',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 20,
                    ),
                  ],
                ),
              ), // 상담 내용
            ],
          ),
          ExpansionTile(
            title: Row(
              children: [
                Text(
                  '회원 개인 건강 정보 열람',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff495057),
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: Color(0xff495057),
                )
              ],
            ),
            trailing: SizedBox(),
            children: [],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '답변 작성',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xff707070),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: CommonUtils.getAdditionalColor()),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextFormField(
                    initialValue: 'Message',
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(CommonUtils.DEFAULT_PAGE_PADDING),
                    ),
                    maxLines: 5,
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
          SizedBox(height: 20.0),
          Center(child: Icon(Icons.keyboard_arrow_up)),
          Divider(thickness: 1.0, color: Color(0xff000000).withOpacity(0.12)),
        ],
      ),
    );
  }
}
