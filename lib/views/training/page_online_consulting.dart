import 'package:fitwith/utils/utils_common.dart';
import 'package:fitwith/utils/utils_widget.dart';
import 'package:fitwith/views/training/widget/drawer.dart';
import 'package:flutter/material.dart';

/// 온라인 상담신청 페이지
class OnlineConsultingPage extends StatefulWidget {
  @override
  _OnlineConsultingPageState createState() => _OnlineConsultingPageState();
}

class _OnlineConsultingPageState extends State<OnlineConsultingPage> {
  Size _deviceSize; // 기기사이즈

  @override
  void initState() {
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
        Text(
          '1:1 온라인 상담 내역',
          style: TextStyle(
            color: CommonUtils.getSecondaryColor(),
            fontSize: 20.0,
          ),
        ), // 온라인 상담 내역
        SizedBox(height: 20.0),
        Divider(height: 1.0, thickness: 1.0, color: Color(0xff000000).withOpacity(0.12)),
        _buildConsultingList(),
        _buildConsultingList(),
        SizedBox(height: 20.0),
        _buildApplyConsulting(),
      ],
    );
  }

  /// 1:1 온라인 상담 내역
  Widget _buildConsultingList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildConsulting(),
      ],
    );
  }

  /// 온라인 상담
  Widget _buildConsulting() {
    return Theme(
      data: ThemeData(
        dividerColor: Colors.transparent,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xff000000).withOpacity(0.12))),
        ),
        child: ExpansionTile(
          trailing: Text(
            '답변 대기',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              color: Color(0xff000000).withOpacity(0.5),
            ),
          ),
          title: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Text(
                  '허리가 아파요',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Color(0xff000000).withOpacity(0.5),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  '2020.10.02',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Color(0xff000000).withOpacity(0.5),
                  ),
                ),
              ),
            ],
          ),
          childrenPadding: const EdgeInsets.only(left: CommonUtils.DEFAULT_PAGE_PADDING, right: CommonUtils.DEFAULT_PAGE_PADDING),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Icon(Icons.keyboard_arrow_up)),
                Divider(thickness: 1.0, color: Color(0xff000000).withOpacity(0.12)),
                SizedBox(height: 10.0),
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
                SizedBox(height: 10.0),
                Text(
                  '트레이너 답변',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Color(0xff707070),
                  ),
                ),
                SizedBox(height: 10.0),
                Row(
                  children: [
                    Text(
                      '홍길동 트레이너',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xff000000).withOpacity(0.5),
                      ),
                    ),
                    SizedBox(width: 6.0),
                    Text(
                      '2020.10.05',
                      style: TextStyle(
                        color: Color(0xff000000).withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
                Divider(thickness: 1.0, color: Color(0xff000000).withOpacity(0.12)),
                Text(
                  'Apparently we had reached a great height in the atmosphere, for the...',
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(height: 10.0),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 1:1 온라인 상담 신청
  Widget _buildApplyConsulting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '1:1 온라인 상담 신청',
              style: TextStyle(
                color: CommonUtils.getSecondaryColor(),
                fontSize: 20.0,
              ),
            ),
            IconButton(
              icon: Icon(Icons.info_outline),
              color: Color(0xffC4C4C4),
              iconSize: 26.0,
              onPressed: () {},
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: CommonUtils.DEFAULT_PAGE_PADDING, right: CommonUtils.DEFAULT_PAGE_PADDING),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.0),
              Text(
                '사진 및 영상 업로드',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Color(0xff000000).withOpacity(0.5),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                height: 160.0,
                color: CommonUtils.getAdditionalColor(),
                child: Center(
                    child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 40.0,
                )),
              ),
              SizedBox(height: 30.0),
              Text(
                '질문',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Color(0xff000000).withOpacity(0.5),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: CommonUtils.getAdditionalColor()),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextFormField(
                  initialValue: 'Apparently we had reached a great height in the atmosphere, for the...',
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(CommonUtils.DEFAULT_PAGE_PADDING),
                  ),
                  maxLines: 5,
                ),
              ),
              SizedBox(height: 30.0),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '개인 건강 관리 정보 공개 여부',
                    style: TextStyle(
                      color: Color(0xff495057),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Checkbox(
                    value: true,
                    onChanged: (bool val) {},
                  ),
                ],
              ),
              SizedBox(height: 30.0),
              Center(
                child: Container(
                  width: _deviceSize.width * 0.5,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(40.0)),
                    ),
                    color: CommonUtils.getPrimaryColor(),
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    onPressed: () {},
                    child: Text(
                      '제출',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
