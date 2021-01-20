import 'package:fitwith/utils/utils_common.dart';
import 'package:flutter/material.dart';

/// 트레이닝 아이템
class TrainingItem extends StatelessWidget {
  final String banner;
  final String title;
  final String text;

  final bool isFavorite; // 좋아요 여부

  final int favoriteCount; // 좋아요 개수
  final int commentCount; // 댓글 개수

  final String text2;
  final Color text2Color;
  final Function text2OnTap;

  TrainingItem(this.banner, this.title, this.text, this.isFavorite, this.favoriteCount, this.commentCount,
      {this.text2, this.text2Color, this.text2OnTap});

  @override
  Widget build(BuildContext context) {
    Size _deviceSize = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(banner, width: _deviceSize.width),
        SizedBox(height: 20.0),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18.0,
          ),
        ),
        SizedBox(height: 10.0),
        SizedBox(
          width: _deviceSize.width * 0.6,
          child: Text(text),
        ),
        SizedBox(height: 5.0),
        Divider(),
        SizedBox(height: 2.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _buildTrainingItemIcon(isFavorite ? Icons.favorite : Icons.favorite_border_rounded),
                SizedBox(width: 5.0),
                _buildTrainingItemText('$favoriteCount'),
                SizedBox(width: 10.0),
                _buildTrainingItemIcon(Icons.chat_bubble_outline_rounded),
                SizedBox(width: 5.0),
                _buildTrainingItemText('$commentCount'),
              ],
            ),
            if (text2 != null) _buildTrainingItemText(text2, color: text2Color, onTap: text2OnTap),
          ],
        ),
        SizedBox(height: 30.0),
      ],
    );
  }

  /// 트레이닝 아이템 텍스트 위젯 생성
  Widget _buildTrainingItemText(String text, {Function onTap, Color color}) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12.0,
          color: color ?? CommonUtils.getPrimaryColor(),
        ),
      ),
    );
  }

  /// 트레이닝 아이템 아이콘 위젯 생성
  Icon _buildTrainingItemIcon(IconData iconData) {
    return Icon(
      iconData,
      color: CommonUtils.getPrimaryColor(),
      size: 18.0,
    );
  }
}
