import 'package:fitwith/utils/utils_common.dart';
import 'package:fitwith/utils/utils_widget.dart';
import 'package:fitwith/views/setting/widgets/widget_user_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// 회원정보 수정_트레이너
/// X - 18, X - 19
class SettingInfoTrainerPage extends StatefulWidget {
  @override
  _SettingInfoTrainerPageState createState() => _SettingInfoTrainerPageState();
}

class _SettingInfoTrainerPageState extends State<SettingInfoTrainerPage> {
  static const String _TYPE_CAREER = 'CAREER'; // 경력사항
  static const String _TYPE_CERTIFICATE = 'CERTIFICATE'; // 자격사항

  String _mode;

  Size _deviceSize;

  @override
  void initState() {
    _mode = CommonUtils.MODE_VIEW;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _deviceSize = MediaQuery.of(context).size;

    return WidgetUtils.buildScaffold(
      _buildBody(),
      appBar: WidgetUtils.buildAppBar(),
    );
  }

  /// Build body
  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(CommonUtils.DEFAULT_PAGE_PADDING),
      child: Column(
        children: [
          _buildMainTitle(),
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserInfo(_mode, CommonUtils.TYPE_TRAINER),
                SizedBox(height: 20.0),
                _buildPersonalTraining(),
                SizedBox(height: 20.0),
                _buildExercise(),
                SizedBox(height: 20.0),
                _buildCertification(_TYPE_CAREER),
                SizedBox(height: 20.0),
                _buildCertification(_TYPE_CERTIFICATE),
                if (_mode == CommonUtils.MODE_EDIT) _buildRequest(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// PT 정보 설정 위젯 생성
  Widget _buildPersonalTraining() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTitle('프리미엄 개인 PT 여부'),
            Switch(
              value: true,
              onChanged: (bool value) {},
              activeColor: CommonUtils.getPrimaryColor(),
              inactiveThumbColor: CommonUtils.getColorByHex('#707070'),
            ),
          ],
        ),
        Text(
          '수강생들에게 프리미엄 서비스 신청을 받습니다.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.black.withOpacity(0.6),
          ),
        ),
        SizedBox(height: 10.0),
        _buildNoticeText('관리 회원수가 많은 경우 꺼놓으셨다가 다시 켜실 수 있습니다.'),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTitle('프리미엄 PT 최대 인원'),
            Container(
              width: 120.0,
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
              decoration: BoxDecoration(
                border: Border.all(color: CommonUtils.getPrimaryColor()),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: DropdownButton(
                isExpanded: true,
                isDense: true,
                value: 9,
                dropdownColor: CommonUtils.getAdditionalColor(),
                elevation: 0,
                underline: Container(),
                style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                ),
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 16.0,
                  color: CommonUtils.getColorByHex('#C2C9D1'),
                ),
                items: [
                  DropdownMenuItem(
                    value: 9,
                    child: Text('09명'),
                  ),
                  DropdownMenuItem(
                    value: 10,
                    child: Text('10명'),
                  ),
                ],
                onChanged: (dynamic value) {
                  print(value);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// 주력 운동 위젯 생성
  Widget _buildExercise() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle('주력 운동'),
        SizedBox(height: 10.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildPill('복부'),
              SizedBox(width: 5.0),
              _buildPill('PT'),
              SizedBox(width: 5.0),
              _buildPill('필라테스'),
              SizedBox(width: 5.0),
              _buildPill('필라테스'),
              SizedBox(width: 5.0),
              _buildPill('필라테스'),
              SizedBox(width: 5.0),
              _buildPill('필라테스'),
              SizedBox(width: 5.0),
              _buildPill('필라테스'),
              SizedBox(width: 5.0),
              _buildPill('필라테스'),
            ],
          ),
        ),
      ],
    );
  }

  /// 경력사항, 자격사항 위젯 생성
  Widget _buildCertification(String type) {
    String text = type == _TYPE_CAREER ? '경력사항' : '자격사항';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(text),
        SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCertificationItem('카이로프랙틱 1급'),
              _buildCertificationItem('생활체육 지도자 보디빌딩 2급'),
              _buildCertificationItem('운동처방 지도자 2급'),
              _buildCertificationItem('미국 공인 법인 세계 자연 치유 관리사'),
              _buildCertificationItem('스포츠 마사지 2급'),
              _buildCertificationItem('대한 응급구조사 응급처치'),
            ],
          ),
        ),
      ],
    );
  }

  /// 경력사항, 자격사항 아이템 위젯 생성
  Widget _buildCertificationItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: _mode == CommonUtils.MODE_VIEW
          ? Text(
              '- $text',
              style: TextStyle(
                fontSize: 16.0,
              ),
            )
          : Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: CommonUtils.getColorByHex('#C2C9D1'),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5.0),
                Icon(
                  Icons.add_circle_outline_rounded,
                  color: CommonUtils.getColorByHex('#C2C9D1'),
                  size: 26.0,
                ),
              ],
            ),
    );
  }

  /// 자격증 파일 승인 요청 및 회원탈퇴
  Column _buildRequest() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.0),
        Text(
          '자격증 파일 업로드',
          style: TextStyle(
            fontSize: 16.0,
            color: CommonUtils.getColorByHex('#222224'),
          ),
        ),
        SizedBox(height: 10.0),
        InkWell(
          onTap: () {},
          child: Container(
            width: _deviceSize.width,
            height: _deviceSize.width * 0.4,
            decoration: BoxDecoration(
              border: Border.all(
                color: CommonUtils.getColorByHex('#C2C9D1'),
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Icon(
              Icons.add,
              color: Colors.black.withOpacity(0.2),
              size: 40.0,
            ),
          ),
        ),
        SizedBox(height: 10.0),
        _buildNoticeText('자격증을 PDF/JPG 파일로 업로드 해주세요.'),
        SizedBox(height: 10.0),
        WidgetUtils.buildCustomButton(
          Text('승인 요청'),
          () {},
          CommonUtils.getPrimaryColor(),
          Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
        ),
        SizedBox(height: 10.0),
        _buildNoticeText('자격 사항의 수정 및 업데이트는 승인 이후에 이루어 집니다.'),
        SizedBox(height: 10.0),
        Align(
          alignment: Alignment.centerRight,
          child: _buildDeleteAccount(),
        ),
      ],
    );
  }

  /// 회원 탈퇴 위젯 생성
  Widget _buildDeleteAccount() {
    return InkWell(
      onTap: () {
        /// fixme :: 회원 탈퇴 기능 추가
      },
      child: _buildNoticeText('회원 탈퇴'),
    );
  }

  /// 알림 텍스트 위젯 생성
  Text _buildNoticeText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12.0,
        color: CommonUtils.getColorByHex('#FF9B70'),
      ),
    );
  }

  /// 제목 위젯 생성
  Text _buildTitle(String text) {
    return Text(
      text,
      style: TextStyle(
        color: CommonUtils.getPrimaryColor(),
        fontWeight: FontWeight.w500,
      ),
    );
  }

  /// 메인 타이틀 위젯 생성
  Row _buildMainTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '회원 정보 수정',
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        InkWell(
          onTap: () {
            // fixme :: 편집 및 확인 기능 추가
            setState(() {
              if (_mode == CommonUtils.MODE_VIEW) {
                _mode = CommonUtils.MODE_EDIT;
              } else {
                _mode = CommonUtils.MODE_VIEW;
              }
            });
          },
          child: Text(
            _mode == CommonUtils.MODE_VIEW ? '편집' : '확인',
            style: TextStyle(
              color: _mode == CommonUtils.MODE_VIEW ? CommonUtils.getColorByHex('#FF2F2F') : CommonUtils.getPrimaryColor(),
              fontSize: 16.0,
            ),
          ),
        ),
      ],
    );
  }

  /// 알약 위젯 생성
  Container _buildPill(String text) {
    return Container(
      child: Text(text),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
      decoration: BoxDecoration(
        color: CommonUtils.getAdditionalColor(),
        borderRadius: BorderRadius.circular(15.0),
      ),
    );
  }
}
