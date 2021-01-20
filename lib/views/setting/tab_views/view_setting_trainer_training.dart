import 'package:fitwith/utils/utils_common.dart';
import 'package:fitwith/utils/utils_widget.dart';
import 'package:fitwith/views/setting/widgets/widget_training_item.dart';
import 'package:flutter/material.dart';

/// 트레이너 트레이닝 탭 뷰
class SettingTrainerTrainingView extends StatefulWidget {
  @override
  _SettingTrainerTrainingViewState createState() => _SettingTrainerTrainingViewState();
}

class _SettingTrainerTrainingViewState extends State<SettingTrainerTrainingView> {
  Size _deviceSize;

  @override
  Widget build(BuildContext context) {
    _deviceSize = MediaQuery.of(context).size;

    return _buildBody();
  }

  /// Build body
  Widget _buildBody() {
    return Column(
      children: [
        _buildProgressingTraining(),
        SizedBox(height: 40.0),
        _buildRegisteredTraining(),
        SizedBox(height: 40.0),
        _buildExpirationTraining(),
      ],
    );
  }

  /// 진행중인 내 강의 위젯 생성
  Widget _buildProgressingTraining() {
    return Column(
      children: [
        _buildTitle('진행중인 내 강의'),
        SizedBox(height: 30.0),
        TrainingItem(
          'assets/img_sample_banner.png',
          '복부비만 완전 정복! - 홍길동 트레이너',
          'Apparently we had reached a great height in the atmosphere, for the...',
          false,
          200,
          100,
          text2: '등록기간 D-120',
        ),
        TrainingItem(
          'assets/img_sample_banner.png',
          '복부비만 완전 정복! - 홍길동 트레이너',
          'Apparently we had reached a great height in the atmosphere, for the...',
          false,
          200,
          100,
          text2: '등록기간 D-120',
        ),
        WidgetUtils.buildCustomButton(
          Text(
            '프로젝트 등록하기',
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
          () {},
          CommonUtils.getPrimaryColor(),
          Colors.white,
          width: _deviceSize.width,
          padding: const EdgeInsets.symmetric(vertical: 28.0),
        ),
      ],
    );
  }

  /// 등록중인 강의 위젯 생성
  Widget _buildRegisteredTraining() {
    return Column(
      children: [
        _buildTitle('등록중인 강의'),
        SizedBox(height: 30.0),
        TrainingItem(
          'assets/img_sample_banner.png',
          '복부비만 완전 정복! - 홍길동 트레이너',
          'Apparently we had reached a great height in the atmosphere, for the...',
          false,
          200,
          100,
          text2: '심사중',
        ),
        TrainingItem(
          'assets/img_sample_banner.png',
          '복부비만 완전 정복! - 홍길동 트레이너',
          'Apparently we had reached a great height in the atmosphere, for the...',
          true,
          200,
          100,
          text2: '심사중',
        ),
      ],
    );
  }

  /// 기간만료 강의 위젯 생성
  Widget _buildExpirationTraining() {
    return Column(
      children: [
        _buildTitle('기간만료 강의'),
        SizedBox(height: 30.0),
        TrainingItem(
          'assets/img_sample_banner.png',
          '복부비만 완전 정복! - 홍길동 트레이너',
          'Apparently we had reached a great height in the atmosphere, for the...',
          false,
          200,
          100,
          text2: '재등록 신청',
          text2OnTap: () {
            /// fixme :: 재등록 신청 기능 추가
          },
        ),
        SizedBox(height: 30.0),
        TrainingItem(
          'assets/img_sample_banner.png',
          '복부비만 완전 정복! - 홍길동 트레이너',
          'Apparently we had reached a great height in the atmosphere, for the...',
          true,
          200,
          100,
          text2: '재등록 신청',
          text2OnTap: () {
            /// fixme :: 재등록 신청 기능 추가
          },
        ),
      ],
    );
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
