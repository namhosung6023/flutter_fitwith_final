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
  var myControllerMorningWeight = TextEditingController();
  var myControllerNightWeight = TextEditingController();
  var myControllerMorningFoodTitle = TextEditingController();
  var myControllerAfternoonFoodTitle = TextEditingController();
  var myControllerNightFoodTitle = TextEditingController();
  var myControllerSnackTitle = TextEditingController();

  int _currentIndex = 0;

  int _pictureNumber = 0;
  int _weightNumber = 0;
  int _foodTitleNumber = 0;

  List<Widget> morningBodyList = [];
  List<Widget> nightBodyList = [];
  List<Widget> morningFoodList = [];
  List<Widget> afternoonFoodList = [];
  List<Widget> nightFoodList = [];
  List<Widget> snackList = [];

  final String endPoint = 'http://10.0.2.2:3000/file/upload';
  List<String> morningBody = [];
  List<String> nightBody = [];
  List<String> morningFood = [];
  List<String> afternoonFood = [];
  List<String> nightFood = [];
  List<String> snack = [];
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
    print(response.data['bodyLog']);
    if (response.data['bodyLog'].length > 0) {
      setState(() {
        if (response.data['bodyLog'][0]['morningBody'].length > 0) {
          for(int i = 0; i < response.data['bodyLog'][0]['morningBody'].length; i++) {
            morningBodyList.add(PictureCard(pictureUrl: response.data['bodyLog'][0]['morningBody'][i].toString()));
          }
        } else {
          setState(() {
            morningBodyList = [];
          });
        }
        if (response.data['bodyLog'][0]['nightBody'].length > 0) {
          for(int i = 0; i < response.data['bodyLog'][0]['nightBody'].length; i++) {
            nightBodyList.add(PictureCard(
                pictureUrl: response.data['bodyLog'][0]['nightBody'][i]
                    .toString()));
          }
        } else{
          setState(() {
            nightBodyList = [];
          });
        }
        if (response.data['bodyLog'][0]['morningFood'].length > 0) {
          for(int i = 0; i < response.data['bodyLog'][0]['morningFood'].length; i++) {
            morningFoodList.add(PictureCard(
                pictureUrl: response.data['bodyLog'][0]['morningFood'][i]
                    .toString()));
          }
        }else{
          setState(() {
            morningFoodList = [];
          });
        }
        if (response.data['bodyLog'][0]['afternoonFood'].length > 0) {
          for(int i = 0; i < response.data['bodyLog'][0]['afternoonFood'].length; i++) {
            afternoonFoodList.add(PictureCard(
                pictureUrl: response.data['bodyLog'][0]['afternoonFood'][i]
                    .toString()));
          }
        }else{
          setState(() {
            afternoonFoodList = [];
          });
        }
        if (response.data['bodyLog'][0]['nightFood'].length > 0) {
          for(int i = 0; i < response.data['bodyLog'][0]['nightFood'].length; i++) {
            nightFoodList.add(PictureCard(
                pictureUrl: response.data['bodyLog'][0]['nightFood'][i]
                    .toString()));
          }
        }else{
          setState(() {
            nightFoodList = [];
          });
        }
        if (response.data['bodyLog'][0]['snack'].length > 0) {
          for(int i = 0; i < response.data['bodyLog'][0]['snack'].length; i++) {
            snackList.add(PictureCard(
                pictureUrl: response.data['bodyLog'][0]['snack'][i]
                    .toString()));
          }
        }else{
          setState(() {
            snackList = [];
          });
        }
      });
    }

  }

  ///몸무게 업로드
  void _weight() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    Dio dio = new Dio();
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    userId = decodedToken['_id'];
    dio.options.headers["accesstoken"] = "$token";
    Response response = await dio.post('http://10.0.2.2:3000/premium/diary/weight/$userId',
        data: {"date": jsonEncode(widget.selectedDay.toIso8601String()), "morningWeight": myControllerMorningWeight.text, "nightWeight": myControllerNightWeight.text, "weightNumber": _weightNumber});
    myControllerMorningWeight = response.data['bodyLog'][0]['morningWeight'];
    myControllerNightWeight = response.data['bodyLog'][0]['nightWeight'];
  }

  ///음식 타이틀 업로드
  void _foodTitle() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    Dio dio = new Dio();
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    userId = decodedToken['_id'];
    dio.options.headers["accesstoken"] = "$token";
    Response response = await dio.post('http://10.0.2.2:3000/premium/diary/foodTitle/$userId',
        data: { "date": jsonEncode(widget.selectedDay.toIso8601String()),
          "morningFoodTitle" : myControllerMorningFoodTitle.text, "afternoonFoodTitle" : myControllerAfternoonFoodTitle.text,
          "nightFoodTitle" : myControllerNightFoodTitle.text, "snackTitle" : myControllerSnackTitle.text, "foodTitleNumber" : _foodTitleNumber
    });
    myControllerMorningFoodTitle = response.data['bodyLog'][0]['morningFoodTitle'];
    myControllerAfternoonFoodTitle = response.data['bodyLog'][0]['afternoonFoodTitle'];
    myControllerNightFoodTitle = response.data['bodyLog'][0]['nightFoodTitle'];
    myControllerSnackTitle = response.data['bodyLog'][0]['snackTitle'];
  }

  ///다이어리 사진 업로드
  void _upload(File file) async {
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
  void dispose() {
    myControllerMorningWeight.dispose();
    myControllerNightWeight.dispose();
    super.dispose();
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
        _buildSubtitle('공복 사진', 0),
        _buildSubtitle1('일어나시고 배변 후 몸 사진을 찍어 올려주세요'),
        const SizedBox(height: 24.0),
        _buildMorningWeight(0),
        const SizedBox(height: 16.0),
        (morningBodyList.length > 0) ? _buildUploadImages(morningBodyList, 0): Container(),
        const SizedBox(height: 24.0),
      ],
    );
  }

  /// 자기전 사진.
  Widget _buildBeforeBedPictures() {
    return Column(
      children: [
        const SizedBox(height: 24.0),
        _buildSubtitle('자기전 사진', 1),
        _buildSubtitle1('일어나시고 배변 후 몸 사진을 찍어 올려주세요'),
        const SizedBox(height: 24.0),
        _buildNightWeight(1),
        const SizedBox(height: 16.0),
        (nightBodyList.length > 0) ?  _buildUploadImages(nightBodyList, 1) : Container(),
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
            Text('사진업로드',
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
        const SizedBox(height: 40),
        _buildSubtitle3('사진업로드'),
        const SizedBox(height: 8.0),
        _buildFoodbutton(2,3,4,5),
        const SizedBox(height: 10.0),
        (morningFoodList.length > 0) ? _buildUploadMorningFoodSubtitle() : Container(),
        const SizedBox(height: 10.0),
        (morningFoodList.length > 0) ? _buildUploadMorningImages(morningFoodList, 2) : Container(),
        const SizedBox(height: 16.0),
        (morningFoodList.length > 0) ? _morningFoodTitle(0) : Container(),
        const SizedBox(height: 20.0),
        (afternoonFoodList.length > 0) ? _buildUploadAfternoonFoodSubtitle() : Container(),
        const SizedBox(height: 16.0),
        (afternoonFoodList.length > 0) ? _buildUploadAfteroonImages(afternoonFoodList, 3) : Container(),
        const SizedBox(height: 16.0),
        (afternoonFoodList.length > 0) ?_afternoonFoodTitle(1) : Container(),
        const SizedBox(height: 10.0),
        (nightFoodList.length > 0) ? _buildUploadNightFoodSubtitle() : Container(),
        const SizedBox(height: 10.0),
        (nightFoodList.length > 0) ? _buildUploadNightImages(nightFoodList, 4) : Container(),
        const SizedBox(height: 16.0),
        (nightFoodList.length > 0) ?  nightFoodTitle(2)  : Container(),
        const SizedBox(height: 16.0),
        (snackList.length > 0) ? _buildUploadSnackSubtitle() : Container() ,
        const SizedBox(height: 16.0),
        (snackList.length > 0) ? _buildUploadSnackImages(snackList, 5) : Container() ,
        const SizedBox(height: 16.0),
        (snackList.length > 0) ? snackFoodTitle(3): Container(),
        const SizedBox(height: 16.0),
      ],
    );

  }


  ///식단관리 사진 업로드 버튼
  Widget _buildFoodbutton(int pictureNumber2, int pictureNumber3, int pictureNumber4, int pictureNumber5) {
    return Row(
      children: [
        Expanded(
          child: OutlineButton(onPressed: (){
            showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
                backgroundColor: Colors.blue,
                context: context,
                builder: ((builder) => bottomSheet()));
            _pictureNumber = pictureNumber2;
          },
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Colors.black12,
            padding: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.1),
            ),
            child:
            Text('아침',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.black38
              ),),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: OutlineButton(onPressed: (){
            showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
                backgroundColor: Colors.blue,
                context: context,
                builder: ((builder) => bottomSheet()));
            _pictureNumber = pictureNumber3;
          },
            color: Colors.black38,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.1),
            ),
            child: Text('점심',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.black38
              ),),
            ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: OutlineButton(onPressed: (){
            showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
                backgroundColor: Colors.blue,
                context: context,
                builder: ((builder) => bottomSheet()));
            _pictureNumber = pictureNumber4;
          },
            color: Colors.black38,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.1),
            ),
            child: Text('저녁',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.black38
              ),
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: OutlineButton(onPressed: (){
            showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
                backgroundColor: Colors.blue,
                context: context,
                builder: ((builder) => bottomSheet()));
            _pictureNumber = pictureNumber5;
          },
            color: Colors.black12,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.1),
            ),
            child: Text('간식',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.black38
              ),),
            ),
        ),
        const SizedBox(width: 10.0),
      ],
    );
  }

  ///식단관리 서브 타이틀
  Widget _buildSubtitle3(String value) {
    return Row(
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 150.1),
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

  /// 체중 관리 이미지 업로드
  Widget _buildSubtitle(String value, int pictureNumber) {
    return Row(
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 130.1),
        FlatButton(onPressed: (){
          showModalBottomSheet(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
              ),
              backgroundColor: Colors.white,
              context: context,
              builder: ((builder) => bottomSheet()));
          _pictureNumber = pictureNumber;
        },
          padding: EdgeInsets.fromLTRB(34, 0, 34, 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9.1),
          ),
          child: Text('파일 업로드',
          style: TextStyle(
            fontSize: 11,
              fontWeight: FontWeight.bold,
            color: Colors.white
          ),),
        color: Colors.black12,),
        const SizedBox(width: 16.0),
      ],
    );
  }

  ///서브 타이틀 밑에 글씨
  Widget _buildSubtitle1(String value) {
    return Row(
      children: [
        Text(
            value,
          style: TextStyle(color: Color(0xFFFF9B70), fontSize: 12.0),
        )
      ],
    );
  }

  ///식단관리에서 사진업로드시 생기는 타이틀
  Widget _buildUploadMorningFoodSubtitle() {
    return Row(
      children: [
        Text(
          '아침',
          style: TextStyle(fontSize: 15, color: Colors.black54, fontWeight:  FontWeight.bold),
        )
      ],
    );
  }

  Widget _buildUploadNightFoodSubtitle() {
    return Row(
      children: [
        Text(
          '저녁',
          style: TextStyle(fontSize: 15, color: Colors.black54, fontWeight:  FontWeight.bold),
        )
      ],
    );
  }

  Widget _buildUploadAfternoonFoodSubtitle() {
    return Row(
      children: [
        Text(
          '점심',
          style: TextStyle(fontSize: 15, color: Colors.black54, fontWeight:  FontWeight.bold),
        )
      ],
    );
  }

  Widget _buildUploadSnackSubtitle() {
    return Row(
      children: [
        Text(
          '간식',
          style: TextStyle(fontSize: 15, color: Colors.black54, fontWeight:  FontWeight.bold),
        )
      ],
    );
  }

  ///식단관리 이미지 업로드 된후 생성

  Widget _buildUploadMorningImages(List<Widget> imageUrlWidgetList, int pictureNumber) {
    return InkWell(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              enableInfiniteScroll: false,
              aspectRatio: 80.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: imageUrlWidgetList.map((imageUrlWidget){
              return Builder(
                  builder:(BuildContext context){
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        color: Colors.blueAccent,
                        child: imageUrlWidget,
                      ),
                    );
                  }
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadAfteroonImages(List<Widget> imageUrlWidgetList, int pictureNumber) {
    return InkWell(
      child: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              enableInfiniteScroll: false,
              aspectRatio: 80.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: imageUrlWidgetList.map((imageUrlWidget){
              return Builder(
                  builder:(BuildContext context){
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        color: Colors.blueAccent,
                        child: imageUrlWidget,
                      ),
                    );
                  }
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadNightImages(List<Widget> imageUrlWidgetList, int pictureNumber) {
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
            items: imageUrlWidgetList.map((imageUrlWidget){
              return Builder(
                  builder:(BuildContext context){
                    return Container(
                      height: MediaQuery.of(context).size.height*0.30,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        color: Colors.blueAccent,
                        child: imageUrlWidget,
                      ),
                    );
                  }
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadSnackImages(List<Widget> imageUrlWidgetList, int pictureNumber) {
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
            items: imageUrlWidgetList.map((imageUrlWidget){
              return Builder(
                  builder:(BuildContext context){
                    return Container(
                      height: MediaQuery.of(context).size.height*0.30,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        color: Colors.blueAccent,
                        child: imageUrlWidget,
                      ),
                    );
                  }
              );
            }).toList(),
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
        // _pictureNumber = pictureNumber;
      },
    );
  }

  ///음식이름 적는 영역 빌드.
  Widget _morningFoodTitle(int foodTitleNumber) {
    return Row(
      children: [
        Image.asset('assets/ic_diet.png', width: 24.0, height: 24.0),
        const SizedBox(width: 16.0),
        Expanded(
          child: TextField(
            controller: myControllerMorningFoodTitle,
            onEditingComplete: (){
              _foodTitle();
              _foodTitleNumber = foodTitleNumber;
              print(myControllerMorningFoodTitle.text);
            },
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
    );
  }


  Widget _afternoonFoodTitle(int foodTitleNumber) {
    return Row(
      children: [
        Image.asset('assets/ic_diet.png', width: 24.0, height: 24.0),
        const SizedBox(width: 16.0),
        Expanded(
          child: TextField(
            controller: myControllerAfternoonFoodTitle,
            onEditingComplete: (){
              _foodTitle();
              _foodTitleNumber = foodTitleNumber;
              print(myControllerAfternoonFoodTitle.text);
            },
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
    );
  }

  Widget nightFoodTitle(int foodTitleNumber) {
    return Row(
      children: [
        Image.asset('assets/ic_diet.png', width: 24.0, height: 24.0),
        const SizedBox(width: 16.0),
        Expanded(
          child: TextField(
            controller: myControllerNightFoodTitle,
            onEditingComplete: (){
              _foodTitle();
              _foodTitleNumber = foodTitleNumber;
              print(myControllerNightFoodTitle.text);
            },
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
    );
  }

  Widget snackFoodTitle(int foodTitleNumber) {
    return Row(
      children: [
        Image.asset('assets/ic_diet.png', width: 24.0, height: 24.0),
        const SizedBox(width: 16.0),
        Expanded(
          child: TextField(
            controller: myControllerSnackTitle,
            onEditingComplete: (){
              _foodTitle();
              _foodTitleNumber = foodTitleNumber;
              print(myControllerSnackTitle.text);
            },
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
    );
  }

  /// 이미지 업로드 영역 빌드.
  Widget _buildUploadImages(List<Widget> imageUrlWidgetList, int pictureNumber) {
    return InkWell(
      child: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 300.0,
              enableInfiniteScroll: false,
              aspectRatio: 5.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: imageUrlWidgetList.map((imageUrlWidget){
              return Builder(
                  builder:(BuildContext context){
                    Positioned(
                      width: 0.0,
                      height: 0.0,
                      right: 5.0,
                      top: 7.0,
                      child: Container(
                        padding: EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.grey.shade400),
                        child: Icon(
                          Icons.close,
                          size: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    );
                    return Container(
                      height: MediaQuery.of(context).size.height*0.30,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        color: Colors.white,
                        child: imageUrlWidget,
                      ),
                    );
                  }
              );
            }).toList(),
          ),
        ],
      ),
      onTap: () {
        showModalBottomSheet(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
            ),
            // backgroundColor: Colors.white,
            context: context,
            builder: ((builder) => bottomSheet()));
        _pictureNumber = pictureNumber;
      },
    );
  }

  Widget getWidget(BuildContext context, Widget widget) {
    return Center(
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 40.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
            border: Border.all(color: Colors.black26, width: 1.0),
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 10.0,
                top: 8.5,
                child: Container(
                  height: 20.0,
                  width: 20.0,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                ),
              ),
              Align(
                widthFactor: 1.0,
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.only(left: 40.0, right: 20.0),
                  child: Text(
                    "Flutter",
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                  ),
                ),
              ),
              Positioned(
                width: 0.0,
                height: 0.0,
                right: 5.0,
                top: 7.0,
                child: Container(
                  padding: EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.grey.shade400),
                  child: Icon(
                    Icons.close,
                    size: 20.0,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  ///사진과 겔러리 선택 하단바
  Widget bottomSheet() {
    return Container(
        height: 170,
        width: 100,
        margin: EdgeInsets.fromLTRB(0,10,0,0),
        child: Column(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                FlatButton(
                  child: Text('Camera',
                    style: TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.w400),),
                  onPressed: () {
                    cameraImage();
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 8.0),
                Container( height: 0.5, width: 500.0, color: Colors.black12,),
                const SizedBox(height: 8.0),
                FlatButton(
                  child: Text('Gallery',
                    style: TextStyle(fontSize: 18, color: Colors.blueAccent, fontWeight: FontWeight.w400),) ,
                  onPressed: () {
                    galleryImage();
                    Navigator.pop(context);
                  },

                )
              ],
            )
          ],
        ));
  }

  /// 몸무게 입력 영역 빌드.
  Widget _buildMorningWeight(int weightNumber) {
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
            controller: myControllerMorningWeight,
            onEditingComplete: (){
              _weight();
              _weightNumber = weightNumber;
              print(myControllerMorningWeight.text);
            },
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
  Widget _buildNightWeight(int weightNumber) {
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
            controller: myControllerNightWeight,
            onEditingComplete: (){
              _weight();
              _weightNumber = weightNumber;
              print(myControllerNightWeight.text);
            },
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

 class PictureCard extends StatelessWidget {
  const PictureCard({
     Key key,
    this.pictureUrl
 }) : super(key: key);
  final String pictureUrl;
   @override
   Widget build(BuildContext context) {
     return Container(
         child: Image.network(pictureUrl, fit: BoxFit.fill,)
     );
   }
 }
