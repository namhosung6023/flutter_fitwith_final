import 'package:fitwith/utils/utils_common.dart';
import 'package:fitwith/utils/utils_widget.dart';
import 'package:flutter/material.dart';
import 'package:multi_charts/multi_charts.dart';

/// 트레이닝 상세 페이지 : X - 11
class SettingTrainingDetailPage extends StatefulWidget {
  @override
  _SettingTrainingDetailPageState createState() => _SettingTrainingDetailPageState();
}

class _SettingTrainingDetailPageState extends State<SettingTrainingDetailPage> {
  Size _deviceSize;

  @override
  Widget build(BuildContext context) {
    _deviceSize = MediaQuery.of(context).size;

    return WidgetUtils.buildScaffold(
      _buildBody(),
      appBar: WidgetUtils.buildAppBar(
        trailing: IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            /// fixme :: 기능 추가
          },
        ),
      ),
    );
  }

  /// Build body
  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(CommonUtils.DEFAULT_PAGE_PADDING),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 60.0),
          _buildRadarChart(),
          SizedBox(height: 100.0),
          _buildTitle('김회원 님은 Lv.1 입니다.'),
          SizedBox(height: 20.0),
          Row(
            children: [
              Image.asset(
                'assets/img_character.png',
              ),
              SizedBox(width: 20.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('LV.1'),
                    SizedBox(height: 5.0),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: LinearProgressIndicator(
                        minHeight: 12.0,
                        value: 0.6,
                        valueColor: AlwaysStoppedAnimation<Color>(CommonUtils.getColorByHex('#45B7E9')),
                        backgroundColor: CommonUtils.getColorByHex('#E5E5E5'),
                      ),
                    ),
                    SizedBox(height: 12.0),
                    Container(
                      width: _deviceSize.width,
                      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: CommonUtils.getColorByHex('#E5E5E5'),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        'Lv.2까지 한 개의 트레이닝이 남았어요.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '들은 트레이닝 수',
                            style: TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                          Text(
                            '1',
                            style: TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          _buildTitle('등급 미리보기'),
          SizedBox(height: 20.0),
          SizedBox(
            height: _deviceSize.height * 0.5,
            child: ListView(
              children: [
                _buildPreviewItem('1', '1~2', '이제 막 운동을 시작했어요.', '열심히 하다보면 근육이 쑥쑥 자라날거에요'),
                _buildPreviewItem('2', '3~4', '운동에 재미를 붙혀가고 있어요', '몸이 튼튼해지는게 느껴져요!'),
                _buildPreviewItem('3', '5~8', '몸에 근육이 많이 생겨난 것 같아요', '근손실이 두려워지기 시작했어요'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 레이더 차트 위젯 생성
  RadarChart _buildRadarChart() {
    return RadarChart(
      maxWidth: _deviceSize.width * 0.95,
      values: [1, 2, 4, 7, 9, 6],
      labels: [
        "체수분",
        "체중",
        "체지방",
        "골격근량",
        "근량",
        "BMI",
      ],
      strokeColor: CommonUtils.getColorByHex('#969696'),
      labelColor: CommonUtils.getPrimaryColor(),
      maxValue: 10,
      fillColor: CommonUtils.getColorByHex('#45B7E9'),
      chartRadiusFactor: 1.6,
    );
  }

  /// 제목 위젯 생성
  Text _buildTitle(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  /// 미리보기 아이템 위젯 생성
  Widget _buildPreviewItem(String level, String count, String text1, String text2) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 80.0),
      child: Row(
        children: [
          Image.asset(
            'assets/img_character.png',
          ),
          SizedBox(width: 20.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('LV.$level'),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '들은 트레이닝 수',
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                    Text(
                      count,
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Text(
                  text1,
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  text2,
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
