import 'package:fitwith/utils/utils_common.dart';
import 'package:fitwith/views/premium/models/model_member.dart';
import 'package:fitwith/views/premium/widgets/widget_trainer_checklist.dart';
import 'package:fitwith/views/premium/widgets/widget_trainer_diary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

/// 프리미엄 - 트레이너 root 위젯.
class TrainerManagement extends StatefulWidget {
  /// 선택된 멤버.
  final Member _member;
  final DateTime _current;

  TrainerManagement(this._member, this._current);

  @override
  _TrainerManagementState createState() => _TrainerManagementState();
}

class _TrainerManagementState extends State<TrainerManagement> with SingleTickerProviderStateMixin {
  bool _isEdit = false;
  /// Tab controller.
  TabController _tabCtrl;
  String trainerId;
  var myControllerTrainerComment = TextEditingController();

  void _trainerCommentUpload () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    Dio dio = new Dio();
    print('코멘트 업로드 dio실행');
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    // trainerId = decodedToken['_id'];
    trainerId = "602e0a670f0e1f2478599666";
    String decodedToken2 = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MDJiNzk0MjlmMDk2YjM3OTQyNDcxNzciLCJlbWFpbCI6Im1pbGtAbmF2ZXIuY29tIiwiaWF0IjoxNjEzNjMxODc4LCJleHAiOjE2Mzk1NTE4Nzh9.GeJ0AYGfzRcgVotIsTSRJDFusYoKoPiEdoeADNKynEg';
    dio.options.headers["accesstoken"] = "$decodedToken2";
    Response response = await dio.post('http://10.0.2.2:3000/premium/comment/update/$trainerId',
    data: {"date" : (this.widget._current.toIso8601String()), "comment" : myControllerTrainerComment.text});
    // myControllerTrainerComment = response.data['trainerComment'][0]['comment'];
  }

  @override
  void initState() {
    this._tabCtrl = TabController(vsync: this, length: 2);
    super.initState();
  }
  Size _deviceSize;
  @override
  Widget build(BuildContext context) {
    _deviceSize = MediaQuery
        .of(context)
        .size;
    return Padding(
      padding: const EdgeInsets.only(left: 32.0, right: 32.0),
      child: Column(
        children: [
          _commentTitle(),
          const SizedBox(height: 20.0),
          _buildComment(),
          const SizedBox(height: 14.0),
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: this._tabCtrl,
              children: [
                TrainerChecklist(this.widget._member, this.widget._current),
                TrainerDiary(this.widget._member),
              ],
            ),
          ),
        ],
      ),
    );
  }
 ///트레이너가 코멘트 남기는 부분
  Widget _buildComment() {
    return _isEdit ? TextField(
      controller: myControllerTrainerComment,
      onEditingComplete: (){
        _trainerCommentUpload ();
        print(myControllerTrainerComment.text);
      },
      style: TextStyle(fontSize: 13.0),
      decoration: InputDecoration(
        hintText: '내용을 입력하세요.',
        isDense: true, // Added this
        contentPadding: EdgeInsets.all(45.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    ): Container(
      width: _deviceSize.width,
      child : Card (
        child: Padding(
          padding: EdgeInsets.all(45),
          child: Text(myControllerTrainerComment.text),
      ),
    ),
    );
  }

  /// 트레이너 코멘트 위에 타이틀
  Widget _commentTitle() {
    return Row(
      children: [
        Text(
          '오늘의 코멘트 입력하기',
          style: TextStyle(
            color: Colors.black38,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 170.0),
        InkWell(
          onTap: (){
            print('저장, 수정을 누름');
            setState(() {
              _trainerCommentUpload ();
              _isEdit = !_isEdit;
            });
            // setState(() => _trainerCommentUpload());

            },
          child: _isEdit ? Text(
            '저장',
            style: TextStyle(
              color: Colors.redAccent,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ) : Text(
            '수정',
            style: TextStyle(
              color: Colors.black38,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  /// 선택된 회원 정보 영역.
  Widget _buildMemberInfo(Member target) {
    final profile = ClipOval(
      child: Image.asset(target.url, fit: BoxFit.cover, width: 40.0, height: 40.0),
    );

    final name = Text(
      target.name,
      style: TextStyle(fontSize: 20.0),
    );

    final info = Text(
      '${(target.gender == Member.FEMALE) ? '여' : '남'}, ${target.age}세',
      style: TextStyle(fontSize: 18.0),
    );

    return ListTile(
      leading: profile,
      title: name,
      trailing: info,
    );
  }

  /// 탭 바 위젯 빌드.
  Widget _buildTabBar() {
    final border = Container(height: 1.0, color: Colors.grey);

    final tabBar = TabBar(
      controller: this._tabCtrl,
      labelColor: CommonUtils.getPrimaryColor(),
      unselectedLabelColor: Colors.grey,
      labelStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      tabs: [
        Tab(text: '체크리스트'),
        Tab(text: '관리 일지'),
      ],
    );

    return Stack(
      children: [
        Positioned(left: 0.0, right: 0.0, bottom: 0.0, child: border),
        tabBar,
      ],
    );
  }
}
