import 'package:fitwith/utils/utils_common.dart';
import 'package:fitwith/utils/utils_widget.dart';
import 'package:fitwith/views/setting/widgets/widget_question_item.dart';
import 'package:flutter/material.dart';

/// 트레이너 구매/문의 내역 탭뷰
class SettingTrainerHistoryView extends StatefulWidget {
  @override
  _SettingTrainerHistoryViewState createState() => _SettingTrainerHistoryViewState();
}

class _SettingTrainerHistoryViewState extends State<SettingTrainerHistoryView> {
  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  /// Build body
  Column _buildBody() {
    return Column(
      children: [
        _buildPaymentHistory(),
        SizedBox(height: 60.0),
        _buildOnlineConsulting(),
        SizedBox(height: 60.0),
        _buildPremiumMemberManagement(),
        SizedBox(height: 60.0),
        _buildQuestion(),
      ],
    );
  }

  /// 강의 결제 내역 위젯 생성
  Widget _buildPaymentHistory() {
    return Column(
      children: [
        _buildTitle('강의 결제'),
        SizedBox(height: 30.0),
        _buildTableHeader('강의명', '일시', '결제확인'),
        Divider(),
        _buildTableItem('복부비만 완전 정복!\n김회원', '8/19 15:00', '결제완료', text3Color: CommonUtils.getPrimaryColor()),
        Divider(),
        _buildTableItem('복부비만 완전 정복!\n김회원', '8/19 15:00', '결제확인', text3Color: CommonUtils.getPrimaryColor()),
      ],
    );
  }

  /// 1:1 온라인 문의 위젯 생성
  Widget _buildOnlineConsulting() {
    return Column(
      children: [
        _buildTitle('1:1 온라인 상담'),
        SizedBox(height: 30.0),
        _buildTableHeader('강의명', '일시', '답변확인'),
        Divider(),
        _buildTableItem('복부비만 완전 정복!', '8/19 15:00', '답변완료', text3Color: CommonUtils.getPrimaryColor()),
        Divider(),
        _buildTableItem('복부비만 완전 정복!', '8/19 15:00', '답변대기'),
        Divider(),
      ],
    );
  }

  /// 프리미엄 개인 관리 위젯 생성
  Widget _buildPremiumMemberManagement() {
    return Column(
      children: [
        _buildTitle('프리미엄 개인관리'),
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
        _buildTitle('FITWITH 문의 내역'),
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
  Widget _buildTableItem(String text1, String text2, String text3, {Color text3Color}) {
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
  Text _buildTitle(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
