import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fitwith/utils/utils_common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'dart:convert';
import 'package:mime_type/mime_type.dart';

class MemberDiary extends StatefulWidget {
  MemberDiary({Key key, this.selectedDay}) : super(key: key);
  final DateTime selectedDay;

  @override
  _MemberDiaryState createState() => _MemberDiaryState();
}

class _MemberDiaryState extends State<MemberDiary> {


  int _currentIndex = 0;

  int _pictureNumber = 0;

  List cardList = [
    Item1(),
    Item2(),
    Item3()
  ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {}
    return result;
  }

  final String endPoint = 'http://10.0.2.2:3000/file/upload';
  String morningBody = '';
  String nightBody = '';
  String morningFood = '';
  String afternoonFood = '';
  String nightFood = '';
  String snack = '';
  String userId;
  Map<String, dynamic> bodyLog;

  void _getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    userId = decodedToken['_id'];

    Dio dio = new Dio();
    dio.options.headers["accesstoken"] = "$token";
    Response response = await dio.get(
        'http://10.0.2.2:3000/file/diary/user/$userId',
        queryParameters: {"date": widget.selectedDay});
    bodyLog = response.data['bodyLog'];
    setState(() {
      if (response.data['bodyLog'].length > 0) {
        morningBody = response.data['bodyLog'][0]['morningBody'][0];
        // nightBody = response.data['bodyLog'][0]['nightBody'];
        // morningFood = response.data['bodyLog'][0]['morningFood'];

      } else {
        setState(() {
          morningBody = '';
          nightBody = '';
          morningFood = '';
        });
      }
    });
  }

  void _upload(File file) async {
    print("업로드함수");
    String fileName = file.path.split('/').last;
    String mimeType = mime(fileName);
    String mimee = mimeType.split('/')[0];
    String type = mimeType.split('/')[1];

    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path,
          filename: fileName, contentType: MediaType(mimee, type)),
      "pictureNumber": _pictureNumber,
      "date": widget.selectedDay,
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    Dio dio = new Dio();
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    userId = decodedToken['_id'];
    dio.options.headers["accesstoken"] = "$token";
    Response response = await dio.post(endPoint,
        data: formData, queryParameters: {"date": widget.selectedDay});
  }

  File _image;
  final file = ImagePicker();

  Future galleryImage() async {
    final pickedFile = await file.getImage(source: ImageSource.gallery);
    print("pickedFile:${pickedFile.toString()}");

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print(_pictureNumber);
        _upload(_image);
      } else {
        return Image.file(_image);
      }
    });
  }

  Future cameraImage() async {
    final pickedFile = await file.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _upload(_image);
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
    _getdata();
  }

  @override
  void didUpdateWidget(covariant MemberDiary oldWidget) {
    _getdata();
    super.didUpdateWidget(oldWidget);
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
        _buildUploadImages(morningBody, 0),
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
        _buildUploadImages(nightBody, 1),
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
            Text('$text',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold)),
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
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(6.0)),
            child: DropdownButton(
              value: this._value,
              underline: Container(),
              iconSize: 16.0,
              onChanged: (int value) => setState(() => this._value = value),
              items: [
                dropdownItem(0, '아침'),
                dropdownItem(1, '점심'),
                dropdownItem(2, '저녁'),
                dropdownItem(3, '간식'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        if (_value == 0)
          _buildUploadImages(morningFood, 2)
        else if (_value == 1)
          _buildUploadImages(afternoonFood, 3)
        else if (_value == 2)
          _buildUploadImages(nightFood, 4)
        else _buildUploadImages(snack, 5),
        const SizedBox(height: 16.0),
        Row(
          children: [
            Image.asset('assets/ic_diet.png', width: 24.0, height: 24.0),
            const SizedBox(width: 16.0),
            Expanded(
              child: TextField(
                style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
                decoration: InputDecoration(
                  isDense: true, // Added this
                  contentPadding: EdgeInsets.all(8.0),
                  hintText: '음식이름을 입력해주세요',
                  hintStyle: TextStyle(color: Color(0xffCCCCCC)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0)),
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
          style: TextStyle(
              color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),
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
  Widget _buildUploadImages(String imageUrl, int pictureNumber) {
    return InkWell(
      child: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              enableInfiniteScroll: false,
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: cardList.map((card){
              return Builder(
                  builder:(BuildContext context){
                    return Container(
                      height: MediaQuery.of(context).size.height*0.30,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        color: Colors.blueAccent,
                        child: card,
                      ),
                    );
                  }
              );
            }).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: map<Widget>(cardList, (index, url) {
              return Container(
                width: 5.0,
                height: 5.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index ? Colors.blueAccent : Colors.grey,
                ),
              );
            }),
          ),
        ],
      ),
      onTap: () {
        showModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
            ),
            backgroundColor: Colors.blue,
            context: context,
            builder: ((builder) => bottomSheet()));
        _pictureNumber = pictureNumber;
      },
    );
  }


  ///사진과 겔러리 선택 하단바
  Widget bottomSheet() {
    return Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          children: <Widget>[
            Text(
              '선택하세요',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton.icon(
                  icon: Icon(
                    Icons.camera_alt,
                    size: 20,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    cameraImage();
                    Navigator.pop(context);
                  },
                  label: Text(
                    'Camera',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                FlatButton.icon(
                  icon: Icon(
                    Icons.photo_library,
                    size: 23,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    galleryImage();
                    Navigator.pop(context);
                  },
                  label: Text(
                    'Gallery',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                )
              ],
            )
          ],
        ));
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
            style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: Colors.black54),
            decoration: InputDecoration(
              isDense: true, // Added this
              contentPadding: EdgeInsets.all(8.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
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

class Item2 extends StatelessWidget {
  const Item2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.3, 1],
            colors: [Color(0xff5f2c82), Color(0xff49a09d)]
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
              "2",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold
              )
          ),
        ],
      ),
    );
  }
 }

class Item1 extends StatelessWidget {
  const Item1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.3, 1],
            colors: [Color(0xff5f2c82), Color(0xff49a09d)]
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
              "1",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold
              )
          ),
        ],
      ),
    );
  }
}

class Item3 extends StatelessWidget {
  const Item3({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.3, 1],
            colors: [Color(0xff5f2c82), Color(0xff49a09d)]
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
              "3",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold
              )
          ),
        ],
      ),
    );
  }
}

