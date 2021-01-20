import 'package:fitwith/utils/utils_common.dart';
import 'package:fitwith/views/premium/models/model_member.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

/// 회원 관리 페이지 - 관리 일지.
class TrainerDiary extends StatefulWidget {
  /// 선택된 회원.
  final Member _member;

  TrainerDiary(this._member);

  @override
  _TrainerDiaryState createState() => _TrainerDiaryState();
}

class _TrainerDiaryState extends State<TrainerDiary> {
  @override
  void initState() {
    CommonUtils.setKeyboardListener(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 24.0, bottom: 16.0),
      children: [
        _buildTitle('체중 관리'),
        _buildEmptyStomachPictures(),
        _buildBeforeBedPictures(),
        const SizedBox(height: 16.0),
        _buildTitle('식단 관리'),
        _buildDiet(),
      ],
    );
  }

  /// 컨텐츠 헤더 빌드.
  Widget _buildTitle(String value) {
    return RaisedButton(
      onPressed: null,
      padding: const EdgeInsets.all(16.0),
      disabledColor: CommonUtils.getPrimaryColor(),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          value,
          style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  /// 서브타이틀 빌드.
  Widget _buildSubtitle(String value, String message) {
    return Row(
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: Text(
            message,
            style: TextStyle(color: Color(0xFFFF9B70), fontSize: 12.0),
          ),
        ),
      ],
    );
  }

  /// 공복 사진.
  Widget _buildEmptyStomachPictures() {
    return Column(
      children: [
        const SizedBox(height: 24.0),
        _buildSubtitle('공복 사진', '일어나시고 배변 후 몸 사진을 찍어 올려주세요.'),
        const SizedBox(height: 24.0),
        _buildWeight(48.9),
        const SizedBox(height: 16.0),
        SizedBox(height: 160.0, child: _buildImages()),
        const SizedBox(height: 24.0),
      ],
    );
  }

  /// 자기전 사진.
  Widget _buildBeforeBedPictures() {
    return Column(
      children: [
        const SizedBox(height: 24.0),
        _buildSubtitle('자기전 사진', '잠들기 직전 몸 사진을 찍어주세요.'),
        const SizedBox(height: 24.0),
        _buildWeight(50.9),
        const SizedBox(height: 16.0),
        SizedBox(height: 160.0, child: _buildImages()),
        const SizedBox(height: 24.0),
      ],
    );
  }

  /// 몸무게 표시 영역 빌드.
  Widget _buildWeight(double value) {
    return Row(
      children: [
        Text(
          '몸무게 기록',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: Text(
            '$value kg',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  /// 식단 영역 빌드.
  Widget _buildDiet() {
    return Column(
      children: [
        const SizedBox(height: 24.0),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '아침',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        SizedBox(height: 160.0, child: _buildImages()),
        const SizedBox(height: 16.0),
        Row(
          children: [
            Image.asset('assets/ic_diet.png', width: 24.0, height: 24.0),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                '리코타 치즈 샐러드',
                style: TextStyle(
                  fontSize: 15.0,
                  color: Color(0xff707070),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 32.0),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '코멘트',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        TextField(
          style: TextStyle(fontSize: 13.0),
          maxLines: 3,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.all(16.0),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          ),
        ),
        const SizedBox(height: 8.0),
        Align(
          alignment: Alignment.centerRight,
          child: Icon(Icons.arrow_circle_up, size: 40.0, color: CommonUtils.getPrimaryColor()),
        ),
        const SizedBox(height: 24.0),
      ],
    );
  }

  /// 이미지 슬라이더 빌드.
  Widget _buildImages() {
    // sample images.
    final urls = [
      'https://i.ytimg.com/vi/frrBSyEqS6c/maxresdefault.jpg',
      'https://pbs.twimg.com/media/EoJoFT_XMAIjuRC.jpg',
      'https://thumb.mt.co.kr/06/2020/10/2020100809360793251_2.jpg/dims/optimize/',
    ];
    return Swiper(
      itemCount: urls.length,
      scale: 0.9,
      viewportFraction: 0.85,
      itemBuilder: (BuildContext context, int i) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Image.network(urls[i], fit: BoxFit.cover),
        );
      },
    );
  }
}
