import 'package:fitwith/utils/utils_common.dart';
import 'package:fitwith/utils/utils_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 트레이너 프리미엄 탭뷰
class SettingTrainerPremiumView extends StatefulWidget {
  @override
  _SettingTrainerPremiumViewState createState() => _SettingTrainerPremiumViewState();
}

class _SettingTrainerPremiumViewState extends State<SettingTrainerPremiumView> with TickerProviderStateMixin {
  Size _deviceSize;

  @override
  Widget build(BuildContext context) {
    _deviceSize = MediaQuery.of(context).size;

    return _buildPremiumBody();
  }

  /// 프리미엄 서비스 미등록인 경우
  Column _buildNoPremiumBody() {
    return Column(
      children: [
        Text(
          '프리미엄 이란?',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16.0,
            color: CommonUtils.getColorByHex('#495057'),
          ),
        ),
        SizedBox(height: 30.0),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '회원님들과 트레이너 님을 ',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: '1:1로 매칭',
                style: TextStyle(
                  color: CommonUtils.getPrimaryColor(),
                ),
              ),
              TextSpan(
                text: '시켜주는 서비스 입니다. 회원님들께서 원하는 지역의 트레이너를 매칭시켜 개인 관리를 용이하게 합니다.',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.0),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '앱에서는 개인 PT를 용이하게 하기 위한 서비스를 제공합니다. ',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: '운동부터 식단까지 ',
                style: TextStyle(
                  color: CommonUtils.getPrimaryColor(),
                ),
              ),
              TextSpan(
                text: '회원님의 상태를 한눈에 볼 수 있습니다.',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.0),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '트레이너님이 회원님과의 미팅 혹은 정보에 따라 운동과 식단 계획을 ',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: '회원님의 맞춤형 ',
                style: TextStyle(
                  color: CommonUtils.getPrimaryColor(),
                ),
              ),
              TextSpan(
                text: '으로 잡아 줄 수 있습니다.',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 30.0),
        Align(
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: () {
              /// fixme :: 프리미엄 미리보기 기능 추가
            },
            child: Text(
              '프리미엄 미리보기',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: CommonUtils.getColorByHex('#495057'),
              ),
            ),
          ),
        ),
        SizedBox(height: 30.0),
        WidgetUtils.buildCustomButton(
          Text(
            '프리미엄 서비스 등록',
            style: TextStyle(
              fontSize: 17.0,
            ),
          ),
              () {},
          CommonUtils.getPrimaryColor(),
          Colors.white,
          width: _deviceSize.width,
          padding: const EdgeInsets.all(20.0),
        ),
      ],
    );
  }

  /// 프리미엄 서비스 등록인 경우
  Widget _buildPremiumBody() {
    return Column(
      children: [
        _buildPremiumMember(),
        SizedBox(height: 30.0),
        _buildMemberApplyQuestion(),
        SizedBox(height: 30.0),
        _buildMemberStatus(),
      ],
    );
  }

  /// 프리미엄 회원 위젯 생성
  Widget _buildPremiumMember() {
    return Column(
      children: [
        _buildTitle('프리미엄 회원 관리'),
        SizedBox(height: 20.0),
        SizedBox(
          height: _deviceSize.height * 0.3,
          child: ListView(
            padding: const EdgeInsets.all(10.0),
            children: [
              _buildPremiumMemberItem('김회원', '남, 41세'),
              _buildPremiumMemberItem('김회원', '남, 41세'),
              _buildPremiumMemberItem('김회원', '남, 41세'),
              _buildPremiumMemberItem('김회원', '남, 41세'),
            ],
          ),
        ),
      ],
    );
  }

  /// 프리미엄 회원 아이템 위젯 생성
  Container _buildPremiumMemberItem(String name, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black.withOpacity(0.12),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16.0,
            ),
          ),
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16.0,
            ),
          )
        ],
      ),
    );
  }

  /// 회원 신청 문의 위젯 생성
  Widget _buildMemberApplyQuestion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '회원 신청 문의',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: CommonUtils.getColorByHex('#707070'),
          ),
        ),
        SizedBox(height: 10.0),
        SizedBox(
          height: _deviceSize.height * 0.3,
          child: ListView(
            padding: const EdgeInsets.all(10.0),
            children: [
              _buildMemberApplyQuestionItem('김회원', '남, 41세', () {}),
              _buildMemberApplyQuestionItem('김회원', '남, 41세', () {}),
              _buildMemberApplyQuestionItem('김회원', '남, 41세', () {}),
              _buildMemberApplyQuestionItem('김회원', '남, 41세', () {}),
            ],
          ),
        ),
      ],
    );
  }

  /// 회원 신청 문의 아이템 위젯 생성
  Container _buildMemberApplyQuestionItem(String name, String text, Function onPressed) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black.withOpacity(0.12),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16.0,
            ),
          ),
          Row(
            children: [
              Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(width: 5.0),
              WidgetUtils.buildCustomButton(
                Text(
                  '신청확인',
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
                onPressed,
                CommonUtils.getPrimaryColor(),
                Colors.white,
                borderRadius: BorderRadius.circular(15.0),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 회원 현황 위젯 생성
  Widget _buildMemberStatus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '회원 현황',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: CommonUtils.getColorByHex('#707070'),
          ),
        ),
        SizedBox(height: 20.0),
        _buildMemberStatusHeader(),
        SizedBox(height: 10.0),
        _buildMemberStatusRow(),
      ],
    );
  }

  /// 회원 현황 Row 위젯 생성
  Row _buildMemberStatusRow() {
    return Row(
      children: [
        Expanded(
          child: _buildMemberStatusRowText('12명'),
        ),
        Expanded(
          child: _buildMemberStatusRowText('8명'),
        ),
        Expanded(
          child: _buildMemberStatusRowText('5명'),
        ),
      ],
    );
  }

  /// 회원 현황 Row 텍스트 위젯 생성
  Text _buildMemberStatusRowText(String text) => Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: CommonUtils.getColorByHex('#707070'),
          fontSize: 18.0,
          fontWeight: FontWeight.w700,
        ),
      );

  /// 회원 현황 헤더 위젯 생성
  Row _buildMemberStatusHeader() {
    return Row(
      children: [
        Expanded(
          child: _buildMemberStatusHeaderText('총 회원'),
        ),
        Expanded(
          child: _buildMemberStatusHeaderText('신규'),
        ),
        Expanded(
          child: _buildMemberStatusHeaderText('수강 완료'),
        ),
      ],
    );
  }

  /// 회원 현황 헤더 텍스트 위젯 생성
  Text _buildMemberStatusHeaderText(String text) => Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: CommonUtils.getColorByHex('#707070'),
          fontSize: 14.0,
        ),
      );

  /// 제목 위젯 생성
  Text _buildTitle(String text) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16.0,
        color: CommonUtils.getColorByHex('#495057'),
      ),
    );
  }
}
