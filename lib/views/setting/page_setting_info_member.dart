import 'package:fitwith/utils/utils_common.dart';
import 'package:fitwith/utils/utils_widget.dart';
import 'package:fitwith/views/setting/widgets/widget_user_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// 회원 및 트레이너 정보 수정 페이지
/// X - 17, X - 18, X - 19
class SettingInfoMemberPage extends StatefulWidget {
  @override
  _SettingInfoMemberPageState createState() => _SettingInfoMemberPageState();
}

class _SettingInfoMemberPageState extends State<SettingInfoMemberPage> {
  String _mode;

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
    return WidgetUtils.buildScaffold(
      _buildBody(),
      appBar: WidgetUtils.buildAppBar(),
    );
  }

  /// Build body
  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(CommonUtils.DEFAULT_PAGE_PADDING),
            child: Column(
              children: [
                _buildMainTitle(),
                SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: UserInfo(_mode, CommonUtils.TYPE_MEMBER),
                ),
                SizedBox(height: 10.0),
                _buildBodyInfo(),
              ],
            ),
          ),
          SizedBox(height: 30.0),
          _buildSwitch('건강 정보 열람', '트레이너님이 회원님의 건강정보를 열람할 수 있게 합니다.', true, (bool value) {}, isFirst: true),
          _buildSwitch('개인정보 열람', '트레이너님이 회원님의 전화번호 및 이메일을 열람할 수 있게 합니다.', false, (bool value) {}),
          SizedBox(height: 30.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildNoticeText('해당 정보의 열람 설정은 트레이너님이 회원님의 건강정보에 따른 맞춤 운동/식단을 제시해 주기 위한것입니다. 이외의 용도로는 절대 사용되지 않습니다.'),
                SizedBox(height: 30.0),
                _buildDeleteAccount(),
                SizedBox(height: 50.0),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 스위치 위젯 생성
  Container _buildSwitch(String title, String text, bool value, Function onChanged, {bool isFirst = false}) {
    Border border = Border(
      bottom: BorderSide(
        color: Colors.black.withOpacity(0.12),
      ),
    );

    if (isFirst) {
      border = Border(
        top: BorderSide(
          color: Colors.black.withOpacity(0.12),
        ),
        bottom: BorderSide(
          color: Colors.black.withOpacity(0.12),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(20.0, 3.0, 20.0, 15.0),
      decoration: BoxDecoration(
        border: border,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              Switch(
                value: value,
                onChanged: onChanged,
                activeColor: CommonUtils.getPrimaryColor(),
                inactiveThumbColor: CommonUtils.getColorByHex('#707070'),
              ),
            ],
          ),
          Text(
            text,
            style: TextStyle(
              color: Colors.black.withOpacity(0.6),
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }

  /// 몸 정보 위젯 생성
  Widget _buildBodyInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBodyInfoRow('키 :', '176.8', 'cm'),
        _buildBodyInfoRow('체중 :', '80', 'kg'),
        _buildBodyInfoRow('BMI :', '22.34', 'kg/m^2'),
        SizedBox(height: 20.0),
        _buildConstitution('소양인'),
        Row(
          children: [
            _buildBodyInfoTitle('좋은 음식'),
            SizedBox(width: 10.0),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Image.asset('assets/ic_eggs.png'),
                    Image.asset('assets/ic_eggs.png'),
                    Image.asset('assets/ic_eggs.png'),
                    Image.asset('assets/ic_eggs.png'),
                    Image.asset('assets/ic_eggs.png'),
                    Image.asset('assets/ic_eggs.png'),
                    Image.asset('assets/ic_eggs.png'),
                    Image.asset('assets/ic_eggs.png'),
                    Image.asset('assets/ic_eggs.png'),
                    Image.asset('assets/ic_eggs.png'),
                    Image.asset('assets/ic_eggs.png'),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20.0),
        _buildBodyInfoTitle('추천 트레이닝'),
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

  /// 몸 정보 제목 위젯 생성
  Text _buildBodyInfoTitle(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.black.withOpacity(0.5),
        fontWeight: FontWeight.w500,
      ),
    );
  }

  /// 몸 정보 행 위젯 생성
  Widget _buildBodyInfoRow(String title, String text, String format) {
    return Container(
      child: Row(
        mainAxisAlignment: _mode == CommonUtils.MODE_VIEW ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
        children: [
          _buildBodyInfoTitle(title),
          SizedBox(width: 5.0),
          _mode == CommonUtils.MODE_VIEW
              ? Text(
                  '$text$format',
                  style: TextStyle(color: Colors.black.withOpacity(0.5)),
                )
              : SizedBox(
                  width: 150.0,
                  height: 30.0,
                  child: TextFormField(
                    initialValue: text,
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
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
        ],
      ),
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black.withOpacity(0.12),
          ),
        ),
      ),
    );
  }

  /// 몸 정보 체질 위젯 생성
  Widget _buildConstitution(String constitution) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildBodyInfoTitle('체질 :'),
            InkWell(
              onTap: () {
                /// fixme :: 테스트 다시하기 기능 추가
              },
              child: Text(
                '테스트 다시하기',
                style: TextStyle(
                  color: CommonUtils.getPrimaryColor(),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20.0),
        Image.asset('assets/img_constitution.png'),
        SizedBox(height: 20.0),
        Text(
          constitution,
          style: TextStyle(
            color: Colors.black.withOpacity(0.5),
            fontWeight: FontWeight.w500,
          ),
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
