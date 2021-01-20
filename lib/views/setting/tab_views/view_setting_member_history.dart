import 'package:fitwith/utils/utils_common.dart';
import 'package:fitwith/utils/utils_widget.dart';
import 'package:fitwith/views/setting/widgets/widget_question_item.dart';
import 'package:flutter/material.dart';

/// 회원 구매/문의 내역 탭뷰
class SettingMemberHistoryView extends StatefulWidget {
  @override
  _SettingMemberHistoryViewState createState() => _SettingMemberHistoryViewState();
}

class _SettingMemberHistoryViewState extends State<SettingMemberHistoryView> {
  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  /// Build body
  Column _buildBody() {
    return Column(
      children: [
        _buildPurchaseHistory(),
        SizedBox(height: 60.0),
        _buildConsulting(),
      ],
    );
  }

  /// 구매 내역 위젯 생성
  Widget _buildPurchaseHistory() {
    return Column(
      children: [
        _buildTitle('구매내역'),
        SizedBox(height: 30.0),
        _buildTableHeader('강의명', '일시', '상태'),
        Divider(),
        _buildTableItem('복부비만 완전 정복!', '8/19 15:00', '수강중', text3Color: CommonUtils.getPrimaryColor()),
        Divider(),
        _buildTableItem('복부비만 완전 정복!', '8/19 15:00', '수강완료'),
      ],
    );
  }

  /// 상담 신청 내역 위젯 생성
  Widget _buildConsulting() {
    return Column(
      children: [
        _buildTitle('상담신청 내역'),
        SizedBox(height: 30.0),
        _buildOnlineConsulting(),
        SizedBox(height: 60.0),
        _buildPremiumMemberManagement(),
        SizedBox(height: 60.0),
        _buildQuestion(),
      ],
    );
  }

  /// 1:1 온라인 문의 위젯 생성
  Widget _buildOnlineConsulting() {
    return Column(
      children: [
        _buildSubTitle('1:1 온라인 상담'),
        SizedBox(height: 30.0),
        _buildTableHeader('강의명', '일시', '신청확인'),
        Divider(),
        _buildTableItem(
          '복부비만 완전 정복!',
          '8/19 15:00',
          '신청완료',
          text3Color: CommonUtils.getPrimaryColor(),
          text4: '취소/변경',
          text4OnTap: () {
            /// fixme :: 취소/변경 기능 추가
          },
        ),
        Divider(),
        _buildTableItem(
          '복부비만 완전 정복!',
          '8/19 15:00',
          '신청확인',
          text3Color: CommonUtils.getPrimaryColor(),
          text4: '취소/변경',
          text4OnTap: () {
            /// fixme :: 취소/변경 기능 추가
          },
        ),
        Divider(),
      ],
    );
  }

  /// 프리미엄 개인 관리 위젯 생성
  Widget _buildPremiumMemberManagement() {
    return Column(
      children: [
        _buildSubTitle('프리미엄 개인관리'),
        SizedBox(height: 30.0),
        _buildTableHeader('트레이너', '일시', '상태'),
        Divider(),
        _buildTableItem('홍길동', '8/19 15:00', '수강중', text3Color: CommonUtils.getPrimaryColor()),
        Divider(),
        _buildTableItem('참다랑', '8/19 15:00', '기간만료'),
      ],
    );
  }

  /// 문의 내역 위젯 생성
  Widget _buildQuestion() {
    return Column(
      children: [
        _buildSubTitle('FITWITH 문의 내역'),
        SizedBox(height: 30.0),
        QuestionItem(
          '2020.11.01',
          '트레이너 회원인데 일반회원으로 바꾸고 싶어요.',
          '안녕하세요 함께 건강해지는 앱 FITWITH입니다. 회원님께서는 이미 진행중인 강의가 있으셔서 현재 변경이 어렵습니다. 추후 강의진행이 끝나면 일반회원으로 변경 도와드리겠습니다. 감사합니다.',
        ),
        QuestionItem(
          '2020.11.01',
          '트레이너 회원인데 일반회원으로 바꾸고 싶어요.',
          '안녕하세요 함께 건강해지는 앱 FITWITH입니다. 회원님께서는 이미 진행중인 강의가 있으셔서 현재 변경이 어렵습니다. 추후 강의진행이 끝나면 일반회원으로 변경 도와드리겠습니다. 감사합니다.',
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            WidgetUtils.buildCustomButton(
              Text(
                'FAQ 자주묻는 질문 보기',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              () {},
              Colors.transparent,
              CommonUtils.getPrimaryColor(),
            ),
            WidgetUtils.buildCustomButton(
              Text(
                '1:1 문의하기',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              () {},
              Colors.transparent,
              CommonUtils.getPrimaryColor(),
            ),
          ],
        ),
      ],
    );
  }

  /// 테이블 아이템 위젯 생성
  Widget _buildTableItem(String text1, String text2, String text3, {String text4, Function text4OnTap, Color text3Color}) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            text1,
            style: TextStyle(
              color: CommonUtils.getColorByHex('#495057'),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            text2,
            style: TextStyle(
              color: CommonUtils.getColorByHex('#495057'),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Text(
                text3,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: text3Color ?? CommonUtils.getColorByHex('#495057'),
                ),
              ),
              if (text4 != null) ...[
                SizedBox(height: 5.0),
                InkWell(
                  onTap: text4OnTap ?? () {},
                  child: Text(
                    text4,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: CommonUtils.getColorByHex('#FF2F2F'),
                    ),
                  ),
                ),
              ]
            ],
          ),
        ),
      ],
    );
  }

  /// 테이블 헤더 위젯 생성
  Widget _buildTableHeader(String text1, String text2, String text3) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            text1,
            style: TextStyle(
              color: CommonUtils.getColorByHex('#495057'),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            text2,
            style: TextStyle(
              color: CommonUtils.getColorByHex('#495057'),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            text3,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: CommonUtils.getColorByHex('#495057'),
            ),
          ),
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

  /// 서브 제목 위젯 생성
  Text _buildSubTitle(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
