import 'package:fitwith/utils/utils_common.dart';
import 'package:flutter/material.dart';

/// 문의 내역 아이템
class QuestionItem extends StatelessWidget {
  final String date;
  final String question;
  final String answer;

  QuestionItem(this.date, this.question, this.answer);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          date,
          style: TextStyle(
            color: CommonUtils.getColorByHex('#495057'),
          ),
        ),
        Divider(),
        _buildQuestionItemText('Q.', question),
        Divider(),
        _buildQuestionItemText('A.', answer),
        Divider(),
        SizedBox(height: 10.0),
      ],
    );
  }

  /// 문의 내역 아이템 텍스트 위젯 생성
  Row _buildQuestionItemText(String text1, String text2) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text1,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: CommonUtils.getColorByHex('#495057'),
          ),
        ),
        SizedBox(width: 5.0),
        Expanded(
          child: Text(
            text2,
            style: TextStyle(
              color: CommonUtils.getColorByHex('#495057'),
            ),
          ),
        ),
      ],
    );
  }
}
