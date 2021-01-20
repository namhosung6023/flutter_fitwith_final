import 'dart:io';
import 'package:fitwith/utils/utils_common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MemberDiary extends StatefulWidget {
  @override
  _MemberDiaryState createState() => _MemberDiaryState();
}

class _MemberDiaryState extends State<MemberDiary> {

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        return Image.file(_image);
      }
    });
  }

  Future cameraImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        return Image.file(_image);
      }
    });
  }

  /// Dropdown button value;
  int _value = 0;


  @override
  void initState() {
    CommonUtils.setKeyboardListener(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(left: 32.0, right: 32.0),
      children: [
        const SizedBox(height: 16.0),
        _buildTitle('체중 관리'),
        _buildEmptyStomachPictures(),
        _buildBeforeBedPictures(),
        const SizedBox(height: 16.0),
        _buildDiet(),
        const SizedBox(height: 32.0),
        const SizedBox(height: CommonUtils.DEFAULT_PAGE_BOTTOM_PADDING),
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
        _buildWeight(),
        const SizedBox(height: 16.0),
        _buildUploadImages(),
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
        _buildWeight(),
        const SizedBox(height: 16.0),
        _buildUploadImages(),
        const SizedBox(height: 24.0),
      ],
    );
  }

  /// 식단 관리 영역 빌드.
  Widget _buildDiet() {
    final dropdownItem = (int value, String text) {
      return DropdownMenuItem(
        value: value,
        child: Row(
          children: [
            Text('$text', style: TextStyle(color: Colors.grey, fontSize: 13.0, fontWeight: FontWeight.bold)),
            const SizedBox(width: 16.0),
          ],
        ),
      );
    };

    return Column(
      children: [
        _buildTitle('식단 관리'),
        const SizedBox(height: 16.0),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            height: 32.0,
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(6.0)),
            child: DropdownButton(
              value: this._value,
              underline: Container(),
              iconSize: 16.0,
              onChanged: (int value) => setState(() => this._value = value),
              items: [
                dropdownItem(0, '아침'),
                dropdownItem(1, '점심'),
                dropdownItem(2, '저녁'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        _buildUploadImages(),
        const SizedBox(height: 16.0),
        Row(
          children: [
            Image.asset('assets/ic_diet.png', width: 24.0, height: 24.0),
            const SizedBox(width: 16.0),
            Expanded(
              child: TextField(
                style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: Colors.black54),
                decoration: InputDecoration(
                  isDense: true, // Added this
                  contentPadding: EdgeInsets.all(8.0),
                  hintText: '음식이름을 입력해주세요',
                  hintStyle: TextStyle(color: Color(0xffCCCCCC)),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
                ),
              ),
            ),
          ],
        ),
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

  /// 이미지 업로드 영역 빌드.
  Widget _buildUploadImages() {
    return InkWell(
      child: Container(
      width: double.infinity,
      height: 160.0,
      child : Icon(Icons.upgrade, color: Colors.white, size: 48.0),
      decoration: BoxDecoration(
        color: Color(0xffE8EAEF),
        borderRadius: BorderRadius.circular(8.0),
      ),
      ),
      onTap: () {
        // getImage();
        final action = CupertinoActionSheet(
          message: Text(
            "사진 업로드",
            style: TextStyle(fontSize: 15.0),
          ),
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: Text("갤러리",style: TextStyle(fontWeight: FontWeight.normal),),
              isDefaultAction: true,
              onPressed: () {
                getImage();
              },
            ),
            CupertinoActionSheetAction(
              child: Text("카메라",style: TextStyle(fontWeight: FontWeight.normal),),
              isDestructiveAction: true,
              onPressed: () {
                cameraImage();
              },
            )
          ],
        );
        showCupertinoModalPopup(
            context: context, builder: (context) => action);
      },
    );
  }

  /// 몸무게 입력 영역 빌드.
  Widget _buildWeight() {
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
        const SizedBox(width: 8.0),
        SizedBox(
          width: 100.0,
          child: TextField(
            style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: Colors.black54),
            decoration: InputDecoration(
              isDense: true, // Added this
              contentPadding: EdgeInsets.all(8.0),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
            ),
          ),
        ),
        const SizedBox(width: 8.0),
        Text(
          'kg',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
