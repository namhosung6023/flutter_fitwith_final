import 'package:fitwith/utils/utils_common.dart';
import 'package:fitwith/utils/utils_widget.dart';
import 'package:flutter/material.dart';

/// 프로젝트 리뷰 페이지 : X - 12
class SettingReviewPage extends StatefulWidget {
  @override
  _SettingReviewPageState createState() => _SettingReviewPageState();
}

class _SettingReviewPageState extends State<SettingReviewPage> {
  @override
  Widget build(BuildContext context) {
    return WidgetUtils.buildScaffold(
      _buildBody(),
      appBar: WidgetUtils.buildAppBar(),
    );
  }

  /// Build body
  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(CommonUtils.DEFAULT_PAGE_PADDING),
      child: Column(
        children: [
          Text(
            '복부비만 완전 정복! - 홍길동 트레이너',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18.0,
            ),
          ),
          SizedBox(height: 20.0),
          InkWell(
            onTap: () {
              /// fixme :: 정렬 기능 추가
            },
            child: Row(
              children: [
                Image.asset('assets/ic_sort.png'),
                SizedBox(width: 5.0),
                Text('최신순'),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Expanded(
            child: ListView(
              children: [
                _buildReviewItem('이**', '2020.10.08', '트레이너님 세심하게 잘 챙겨주시고 좋았습니다. 덕분에 살도 많이 빠졌네요!'),
                _buildReviewItem('이**', '2020.10.08', '트레이너님 세심하게 잘 챙겨주시고 좋았습니다. 덕분에 살도 많이 빠졌네요!'),
                _buildReviewItem('이**', '2020.10.08', '트레이너님 세심하게 잘 챙겨주시고 좋았습니다. 덕분에 살도 많이 빠졌네요!'),
                _buildReviewItem('이**', '2020.10.08', '트레이너님 세심하게 잘 챙겨주시고 좋았습니다. 덕분에 살도 많이 빠졌네요!'),
                _buildReviewItem('이**', '2020.10.08', '트레이너님 세심하게 잘 챙겨주시고 좋았습니다. 덕분에 살도 많이 빠졌네요!'),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Row(
            children: [
              CircleAvatar(
                child: Image.asset('assets/img_empty_profile.png'),
                backgroundColor: Colors.transparent,
              ),
              SizedBox(width: 5.0),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
                    hintText: 'comment',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.black.withOpacity(0.1),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 5.0),
              InkWell(
                borderRadius: BorderRadius.circular(36.0),
                onTap: () {
                  /// fixme :: 리뷰 기능 추가
                },
                child: Icon(
                  Icons.arrow_circle_up_rounded,
                  color: CommonUtils.getPrimaryColor(),
                  size: 36.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 리뷰 아이템 위젯 생성
  Column _buildReviewItem(String name, String date, String text) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 60.0,
              height: 60.0,
              child: CircleAvatar(
                child: Image.asset('assets/img_empty_profile.png'),
                backgroundColor: Colors.transparent,
              ),
            ),
            SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 20.0),
        Text(text),
        SizedBox(height: 10.0),
        Divider(),
        SizedBox(height: 10.0),
      ],
    );
  }
}
