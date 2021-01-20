import 'package:fitwith/utils/utils_common.dart';
import 'package:fitwith/utils/utils_widget.dart';
import 'package:fitwith/views/setting/widgets/widget_training_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';

/// 회원 트레이닝 탭 뷰
class SettingMemberTrainingView extends StatefulWidget {
  @override
  _SettingMemberTrainingViewState createState() => _SettingMemberTrainingViewState();
}

class _SettingMemberTrainingViewState extends State<SettingMemberTrainingView> {
  Size _deviceSize;

  /// 체중 관리 관련 변수
  int _weightSwiperIndex = 0; // 체중 관리 스와이프 인덱스
  SwiperController _weightSwiperController; // 체중 관리 스와이프 컨트롤러
  DateTime _weightDateTime; // 체중 관리 데이터

  @override
  void initState() {
    _weightSwiperController = SwiperController();
    _weightDateTime = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _deviceSize = MediaQuery.of(context).size;

    return _buildBody();
  }

  /// Build body
  Widget _buildBody() {
    return Column(
      children: [
        _buildListeningTraining(),
        SizedBox(height: 40.0),
        _buildCalorie(),
        SizedBox(height: 60.0),
        _buildWeightManagement(),
        SizedBox(height: 40.0),
        _buildRecommendTraining(),
        SizedBox(height: 40.0),
        _buildCompleteTraining(),
      ],
    );
  }

  /// 수강중인 트레이닝 위젯 생성
  Widget _buildListeningTraining() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle('수강중인 트레이닝'),
        SizedBox(height: 30.0),
        TrainingItem(
          'assets/img_sample_banner.png',
          '복부비만 완전 정복! - 홍길동 트레이너',
          'Apparently we had reached a great height in the atmosphere, for the...',
          false,
          200,
          100,
        ),
        SizedBox(height: 20.0),
        Text(
          '진도율',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16.0,
            color: CommonUtils.getColorByHex('#495057'),
          ),
        ),
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
        Text(
          '67% 수강중',
          style: TextStyle(
            fontSize: 12.0,
            color: CommonUtils.getColorByHex('#949397'),
          ),
        ),
      ],
    );
  }

  /// 오늘 소비한 칼로리 위젯 생성
  Widget _buildCalorie() {
    return Column(
      children: [
        _buildTitle('오늘 소비한 칼로리'),
        SizedBox(height: 30.0),
        Text(
          'Density',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            color: CommonUtils.getColorByHex('#707070'),
          ),
        ),
        SizedBox(height: 5.0),
        CircularPercentIndicator(
          radius: _deviceSize.width * 0.6,
          animation: true,
          circularStrokeCap: CircularStrokeCap.round,
          lineWidth: 12.0,
          percent: 0.6,
          center: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '250.2',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 48.0,
                  color: CommonUtils.getColorByHex('#707070'),
                ),
              ),
              Text(
                'kcal',
                style: TextStyle(
                  fontSize: 24.0,
                  color: CommonUtils.getColorByHex('#707070'),
                ),
              ),
            ],
          ),
          progressColor: CommonUtils.getPrimaryColor(),
          backgroundColor: CommonUtils.getColorByHex('#E6E6E6'),
        ),
        SizedBox(height: 10.0),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Min 50',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: CommonUtils.getColorByHex('#707070'),
              ),
            ),
            SizedBox(width: 60.0),
            Text(
              'Max 156',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: CommonUtils.getColorByHex('#707070'),
              ),
            ),
          ],
        )
      ],
    );
  }

  /// 체중 관리 위젯 생성
  Widget _buildWeightManagement() {
    return Column(
      children: [
        _buildTitle('체중 관리'),
        SizedBox(height: 30.0),
        SizedBox(
          height: 250.0,
          child: Swiper(
            controller: _weightSwiperController,
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                width: _deviceSize.width * 0.8,
                decoration: BoxDecoration(
                  color: index == _weightSwiperIndex
                      ? CommonUtils.getColorByHex('#4781EC').withOpacity(0.5)
                      : CommonUtils.getColorByHex('#4781EC').withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: index == _weightSwiperIndex
                    ? Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30.0,
                      )
                    : Container(),
              );
            },
            loop: false,
            scale: 0.8,
            viewportFraction: 0.5,
            onIndexChanged: (int index) {
              setState(() {
                if (_weightSwiperIndex < index) {
                  _weightDateTime = _weightDateTime.add(Duration(days: 1));
                } else {
                  _weightDateTime = _weightDateTime.subtract(Duration(days: 1));
                }
                _weightSwiperIndex = index;
              });
            },
          ),
        ),
        SizedBox(height: 20.0),
        Row(
          children: [
            GestureDetector(
              onTap: _weightSwiperPrev,
              child: Icon(
                Icons.arrow_back_ios_rounded,
                color: CommonUtils.getColorByHex('#E6E6E6'),
                size: 20.0,
              ),
            ),
            Expanded(
              child: Text(
                DateFormat('EEEE, MMM dd').format(_weightDateTime),
                style: TextStyle(
                  color: CommonUtils.getColorByHex('#707070'),
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            GestureDetector(
              onTap: _weightSwiperNext,
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: CommonUtils.getColorByHex('#E6E6E6'),
                size: 20.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 20.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
          decoration: BoxDecoration(
            border: Border.all(color: CommonUtils.getAdditionalColor()),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            '74 kg',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 24.0,
              color: CommonUtils.getPrimaryColor(),
            ),
          ),
        ),
      ],
    );
  }

  /// 추천 트레이닝 위젯 생성
  Widget _buildRecommendTraining() {
    return Column(
      children: [
        _buildTitle('추천 트레이닝'),
        SizedBox(height: 30.0),
        TrainingItem(
          'assets/img_sample_banner.png',
          '복부비만 완전 정복! - 홍길동 트레이너',
          'Apparently we had reached a great height in the atmosphere, for the...',
          false,
          200,
          100,
        ),
      ],
    );
  }

  /// 수강 완료 트레이닝 위젯 생성
  Widget _buildCompleteTraining() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle('수강 완료 트레이닝'),
        SizedBox(height: 30.0),
        TrainingItem(
          'assets/img_sample_banner.png',
          '복부비만 완전 정복! - 홍길동 트레이너',
          'Apparently we had reached a great height in the atmosphere, for the...',
          false,
          200,
          100,
        ),
        SizedBox(height: 10.0),
        WidgetUtils.buildCustomButton(
          Text(
            '리뷰 작성하기',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          () {},
          CommonUtils.getPrimaryColor(),
          Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 20.0),
          borderRadius: BorderRadius.circular(15.0),
        ),
      ],
    );
  }

  /// 체중 관리 스와이프 다음
  Future<void> _weightSwiperNext() async {
    // fixme :: 임시로 아이템 개수를 10개로 지정하여 9 넣어둠.
    if (_weightSwiperIndex == 9) {
      return;
    }

    await _weightSwiperController.next();
  }

  /// 체중 관리 스와이프 이전
  Future<void> _weightSwiperPrev() async {
    if (_weightSwiperIndex == 0) {
      return;
    }

    await _weightSwiperController.previous();
  }

  /// 제목 위젯 생성
  Widget _buildTitle(String text) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16.0,
          color: CommonUtils.getColorByHex('#495057'),
        ),
      ),
    );
  }
}
