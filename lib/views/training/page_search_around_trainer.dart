import 'package:fitwith/utils/utils_common.dart';
import 'package:fitwith/utils/utils_widget.dart';
import 'package:fitwith/views/training/model/top_button.dart';
import 'package:fitwith/views/training/widget/drawer.dart';
import 'package:flutter/material.dart';

/// 내 주변 트레이너 찾기 페이지
class SearchAroundTrainerPage extends StatefulWidget {
  @override
  _SearchAroundTrainerPageState createState() => _SearchAroundTrainerPageState();
}

class _SearchAroundTrainerPageState extends State<SearchAroundTrainerPage> {
  Size _deviceSize; // 기기 사이즈

  /// fixme :: 리스트 데이터 수정필요
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
        SizedBox(height: 20.0),
        _buildTopButtonWidget(), // 상단 버튼 리스트
        _buildSearchAroundTrainer(),
      ],
    );
  }

  /// 상단 버튼 리스트 위젯
  Widget _buildTopButtonWidget() {
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

  /// 내 주변 트레이너 찾기
  Widget _buildSearchAroundTrainer() {
    return Container(
      padding: const EdgeInsets.all(CommonUtils.DEFAULT_PAGE_PADDING),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30.0),
          Row(
            children: [
              Container(
                child: Text(
                  '내 주변 트레이너 찾기',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: CommonUtils.getPrimaryColor(),
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
          SizedBox(height: 30.0),
          Center(
            child: Text(
              '회원님 주변의 트레이너님을 찾아드립니다.',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Color(0xff222224).withOpacity(0.7),
              ),
            ),
          ),
          SizedBox(height: 30.0),
          Text(
            '주소',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 16.0,
              color: Color(0xff222224).withOpacity(0.7),
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(12, 24, 12, 16),
              hintText: '예) 판교역로 235, 분당 주공, 삼평동 681',
              suffixIcon: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  size: 30.0,
                  color: CommonUtils.getSecondaryColor(),
                ),
              ),
            ),
          ), // 주소 검색칸
          SizedBox(height: 40.0),
          // fixme:: 웹뷰 구현필요(현재 샘플이미지)
          Image.asset('assets/sample_img_around_trainer_map.png'),
          SizedBox(height: 30.0),
          _buildTrainerList(), // 트레이너 정보 리스트
        ],
      ),
    );
  }

  /// 트레이너 정보 리스트
  Widget _buildTrainerList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '주변 트레이너',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: Color(0xff222224).withOpacity(0.7),
          ),
        ),
        SizedBox(height: 12.0),
        _buildTrainer(),
        _buildTrainer(),
        _buildTrainer(),
      ],
    );
  }

  /// 트레이너 정보
  Widget _buildTrainer() {
    return Container(
      height: 250.0,
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.asset(
              'assets/img_around_trainer.png',
              height: 250.0,
            ),
            flex: 9,
          ),
          SizedBox(width: 18.0),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '홍길동 트레이너',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: CommonUtils.getSecondaryColor(),
                  ),
                ),
                Text(
                  'Apparently we had reached a great height in the atmosphere, for the...',
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '# 복부 # 복근',
                      style: TextStyle(
                        color: CommonUtils.getPrimaryColor(),
                      ),
                    ),
                    SizedBox(height: 2.0),
                    Divider(height: 1.0),
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        Icon(
                          Icons.favorite,
                          color: CommonUtils.getPrimaryColor(),
                        ),
                        Text(
                          ' 200',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: CommonUtils.getPrimaryColor(),
                          ),
                        ),
                        Text(
                          ' · ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: CommonUtils.getPrimaryColor(),
                          ),
                        ),
                        Icon(
                          Icons.messenger_outline,
                          color: CommonUtils.getPrimaryColor(),
                        ),
                        Text(
                          ' 120',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: CommonUtils.getPrimaryColor(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            flex: 8,
          ),
        ],
      ),
    );
  }
}
