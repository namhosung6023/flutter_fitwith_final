import 'package:fitwith/utils/utils_common.dart';
import 'package:fitwith/views/setting/widgets/widget_training_item.dart';
import 'package:flutter/material.dart';

/// 트레이너 관심 트레이닝 탭뷰
class SettingTrainerFavoriteTrainingView extends StatefulWidget {
  @override
  _SettingTrainerFavoriteTrainingViewState createState() => _SettingTrainerFavoriteTrainingViewState();
}

class _SettingTrainerFavoriteTrainingViewState extends State<SettingTrainerFavoriteTrainingView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '트레이너님의 관심 트레이닝',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16.0,
            color: CommonUtils.getColorByHex('#495057'),
          ),
        ),
        SizedBox(height: 30.0),
        TrainingItem(
          'assets/img_sample_banner.png',
          '복부비만 완전 정복! - 홍길동 트레이너',
          'Apparently we had reached a great height in the atmosphere, for the...',
          false,
          200,
          100,
          text2: '프로그램 종료 D-10',
          text2Color: CommonUtils.getColorByHex('#FF9B70'),
        ),
        TrainingItem(
          'assets/img_sample_banner.png',
          '복부비만 완전 정복! - 홍길동 트레이너',
          'Apparently we had reached a great height in the atmosphere, for the...',
          true,
          200,
          100,
          text2: '프로그램 종료 D-20',
          text2Color: CommonUtils.getColorByHex('#FF9B70'),
        ),
      ],
    );
  }
}
