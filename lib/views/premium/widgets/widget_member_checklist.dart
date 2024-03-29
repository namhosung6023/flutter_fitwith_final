import 'package:dio/dio.dart';
import 'package:fitwith/utils/utils_common.dart';
import 'package:fitwith/views/premium/models/model_checklist.dart';
import 'package:fitwith/views/premium/models/model_member.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemberChecklist extends StatefulWidget {
  MemberChecklist({Key key, this.selectedDay}) : super(key: key);
  final DateTime selectedDay;
  @override
  _MemberChecklistState createState() => _MemberChecklistState();
}

class _MemberChecklistState extends State<MemberChecklist> {
  String userId;
  final TextEditingController _textController = new TextEditingController();
  final Member _member = Member('USER_NAME', Member.FEMALE, 20);

  Checklist workout = Checklist("", "", "", "", false);
  List<Checklist> checkList = [];
  List<String> commentList = [];
  String trainerComment;
  String checkListId;

  void _getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    userId = decodedToken['_id'];

    Dio dio = new Dio();
    dio.options.headers["accesstoken"] = "$token";
    Response response =
    await dio.get('http://10.0.2.2:3000/premium/checklist/user/$userId', queryParameters: {
      "date": widget.selectedDay
    });
    setState(() {
      if(response.data['checklist'].length > 0){
        for (int i = 0; i < response.data['checklist'][0]['userComment'].length; i++) {
          commentList.add(response.data['checklist'][0]['userComment'][i].toString());
        }
        trainerComment = response.data['checklist'][0]['trainerComment'];
        checkListId = response.data['checklist'][0]['_id'];
        List workoutList = response.data['checklist'][0]['workoutlist'];
        for (int i = 0; i < workoutList.length; i++) {
          Checklist workout = Checklist(
              workoutList[i]['name'],
              workoutList[i]['contents'],
              checkListId,
              workoutList[i]['_id'],
              workoutList[i]['isEditable']);
          checkList.add(workout);
        }
      }else{
        setState(() {
          checkList = [];
          _member.checklist = [];
          commentList = [];
          _member.commentList = [];
          trainerComment = "";
        });
      }
    });
  }

  void _putCheckboxData(bool isChecked, Checklist checklist) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    Dio dio = new Dio();
    dio.options.headers["accesstoken"] = "$token";

    Map<String, dynamic> data = {
      "name": checklist.name,
      "contents": checklist.contents,
      "checklistId": checklist.checklistId,
      "workoutId": checklist.workoutId,
      "isChecked": isChecked,
    };

    String stringData = jsonEncode(data);
    try {
      Response response = await dio.put(
          'http://10.0.2.2:3000/premium/checklist/user/checkbox/$userId',
          data: stringData);
      print(response);
    } catch (err) {
      print('error: $err');
    }
  }

  void _postUserComment(String comment) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    Dio dio = new Dio();
    dio.options.headers["accesstoken"] = "$token";

    Map<String, dynamic> data = {
      "userComment": comment,
      "checklistId": checkListId,
    };
    String stringData = jsonEncode(data);

    Response response = await dio.post('http://10.0.2.2:3000/premium/comment/user/$userId', data: stringData);
    print(response);
  }

  @override
  void initState() {
    CommonUtils.setKeyboardListener(context);
    super.initState();
    _getdata();
  }
  @override
  void didUpdateWidget(covariant MemberChecklist oldWidget) {
    _getdata();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (this._member.checklist.length == 0)
      this._member.checklist.addAll(checkList);
    if (this._member.commentList.length == 0)
      this._member.commentList.addAll(commentList);
    return ListView(
      padding: const EdgeInsets.only(left: 32.0, right: 32.0),
      children: [
        const SizedBox(height: 20.0),
        const SizedBox(height: 32.0),
        Text(
          '오늘의 체크리스트',
          style: TextStyle(
            color: Color(0xff222224),
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24.0),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            '운동',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        ...this._member.checklist.map((e) => _buildChecklistItem(e)).toList(),
        const SizedBox(height: 24.0),
        const SizedBox(height: CommonUtils.DEFAULT_PAGE_BOTTOM_PADDING),
      ],
    );
  }


  Widget _buildChecklistItem(Checklist checklist) {
    final color = (checklist.isEditable) ? CommonUtils.getPrimaryColor() : Colors.black54;

    final name = Text(
      checklist.name,
      style: TextStyle(color: color, fontWeight: FontWeight.bold),
    );

    final contents = Text(
      checklist.contents,
      style: TextStyle(color: color),
    );

    final checkbox = Transform.scale(
      scale: 1.2,
      child: Checkbox(
        value: checklist.isEditable,
        visualDensity: VisualDensity.compact,
        onChanged: (bool isChecked) {
          setState(() {
            checklist.isEditable = isChecked;
          });
          _putCheckboxData(isChecked, checklist);
        }),
    );

    return Column(
      children: [
        const SizedBox(height: 8.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 16.0),
            Padding(
              padding: const EdgeInsets.only(top: 6.0),
              // child: Image.asset('assets/ic_dumbbell.png', width: 32.0, fit: BoxFit.cover),
            ),
            const SizedBox(width: 24.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  name,
                  const SizedBox(height: 8.0),
                  contents,
                ],
              ),
            ),
            const SizedBox(width: 16.0),
            checkbox,
          ],
        ),
        const SizedBox(height: 8.0),
        Divider(),
      ],
    );
  }
}
