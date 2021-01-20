import 'package:fitwith/utils/utils_common.dart';
import 'package:fitwith/views/setting/page_setting_trainer_edit_phone.dart';
import 'package:flutter/material.dart';

/// 유저 정보
class UserInfo extends StatefulWidget {
  final String mode; // 편집 모드, 뷰 모드
  final String type;

  UserInfo(this.mode, this.type); // 회원, 트레이너

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          overflow: Overflow.visible,
          children: [
            SizedBox(
              width: 128.0,
              height: 128.0,
              child: CircleAvatar(
                child: Image.asset('assets/img_empty_profile.png'),
                backgroundColor: Colors.transparent,
              ),
            ),
            Positioned(
              bottom: -10.0,
              right: -10.0,
              child: Icon(
                Icons.add_circle_outlined,
                color: CommonUtils.getColorByHex('#2E3A59'),
                size: 60.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        SizedBox(
          width: 200.0,
          child: TextFormField(
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.edit),
            ),
          ),
        ),
        SizedBox(height: 20.0),
        _buildUserInfoRow('성명', '김회원', isBoldText: true),
        SizedBox(height: 10.0),
        _buildUserInfoRow('성별', '남자', isBoldText: true),
        SizedBox(height: 10.0),
        _buildUserInfoRow('주소', '서울시 성동구 하왕십리동'),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildUserInfoRow('전화번호', '010-1234-5678'),
            if (widget.mode == CommonUtils.MODE_EDIT && widget.type == CommonUtils.TYPE_TRAINER)
              SizedBox(
                width: 60.0,
                child: RaisedButton(
                  onPressed: () => CommonUtils.movePage(context, SettingTrainerEditPhonePage()),
                  elevation: 0.0,
                  child: Text(
                    '수정',
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                  color: CommonUtils.getPrimaryColor(),
                  textColor: Colors.white,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 10.0),
        _buildUserInfoRow('이메일', 'test@naver.com'),
      ],
    );
  }

  /// 유저 정보 행 위젯 생성
  Row _buildUserInfoRow(String title, String text, {bool isBoldText = false}) {
    return Row(
      children: [
        SizedBox(
          width: 70.0,
          child: Text(
            title,
            style: TextStyle(
              color: CommonUtils.getPrimaryColor(),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        widget.mode == CommonUtils.MODE_VIEW
            ? Text(
                text,
                style: TextStyle(fontWeight: isBoldText ? FontWeight.w700 : FontWeight.w400),
              )
            : SizedBox(
                width: 140.0,
                height: 30.0,
                child: TextFormField(
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
    );
  }
}
