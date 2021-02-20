import 'package:fitwith/utils/utils_common.dart';
import 'package:fitwith/utils/utils_widget.dart';
import 'package:fitwith/views/premium/models/model_checklist.dart';
import 'package:fitwith/views/premium/models/model_member.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 회원 관리 페이지 - 체크리스트.
class TrainerChecklist extends StatefulWidget {
  final Member _member;
  final DateTime _current;
  TrainerChecklist(this._member, this._current);

  @override
  _TrainerChecklistState createState() => _TrainerChecklistState();
}

class _TrainerChecklistState extends State<TrainerChecklist> {
  List<Checklist> workoutlist = [];
  /// animation widget key.
  final _key = GlobalKey();
  String trainerId;

  /// 수정 여부.
  bool _isEdit = false;

  void _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    Dio dio = new Dio();
    print('디아이오 실행');
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    // trainerId = decodedToken['_id'];
    trainerId = "602e0a670f0e1f2478599666";
    String decodedToken2 = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MDJiNzk0MjlmMDk2YjM3OTQyNDcxNzciLCJlbWFpbCI6Im1pbGtAbmF2ZXIuY29tIiwiaWF0IjoxNjEzNjMxODc4LCJleHAiOjE2Mzk1NTE4Nzh9.GeJ0AYGfzRcgVotIsTSRJDFusYoKoPiEdoeADNKynEg';
    dio.options.headers["accesstoken"] = "$decodedToken2";
    print('진행중');
    Response response = await dio.post('http://10.0.2.2:3000/premium/checklist/trainer/$trainerId',
        data: {"date" : ( this.widget._current.toIso8601String()),
          "workoutlist" : workoutlist
    });
    print(response.data['workoutlist']);
    print('안녕');
    workoutlist = response.data['workoutlist'];
  }

  @override
  void initState() {
    CommonUtils.setKeyboardListener(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
      children: [
        const SizedBox(height: 24.0),
        Text(
          '오늘의 체크리스트',
          style: TextStyle(
            color: Color(0xff222224),
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 32.0),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Text(
            '운동',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        AnimatedSwitcher(
          key: this._key,
          duration: Duration(milliseconds: 200),
          child: (this._isEdit) ? _buildEditMode() : _buildViewMode(),
        ),
      ],
    );
  }

  /// 코멘트 필드 빌드.
  // Widget _buildComment() {
  //   return TextField(
  //     enabled: this._isEdit,
  //     style: TextStyle(fontSize: 13.0),
  //     decoration: InputDecoration(
  //       isDense: true, // Added this
  //       contentPadding: EdgeInsets.all(16.0),
  //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
  //     ),
  //   );
  // }

  /// 회원의 메세지 위젯 빌드.
  // Widget _buildMemberComment(Member target) {
  //   final profile = ClipOval(
  //     child: Image.asset(target.url, fit: BoxFit.cover, width: 40.0, height: 40.0),
  //   );
  //
  //   final message = Container(
  //     padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
  //     child: Text(
  //       'message message message message message message message message ',
  //       style: TextStyle(fontSize: 12.0, height: 1.5),
  //     ),
  //     decoration: BoxDecoration(
  //       border: Border.all(color: Colors.black12),
  //       borderRadius: BorderRadius.circular(8.0),
  //     ),
  //   );
  //
  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       const SizedBox(width: 16.0),
  //       profile,
  //       const SizedBox(width: 16.0),
  //       Expanded(child: message),
  //       const SizedBox(width: 16.0),
  //     ],
  //   );
  // }

  /// 뷰어 모드.
  Widget _buildViewMode() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(height: 16.0),
          ...ListTile.divideTiles(
            context: context,
            tiles: this.widget._member.checklist.map((e) => _buildViewItem(e)),
          ),
          const SizedBox(height: 16.0),
          InkWell(
            onTap: () => setState(() => this._isEdit = true),
            child: Text(
              '수정',
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 뷰어 모드 아이템.
  Widget _buildViewItem(Checklist checklist) {
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
        onChanged: (bool isChecked) => setState(() => checklist.isEditable = isChecked),
      ),
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
              child: Image.asset('assets/ic_dumbbell.png', width: 32.0, fit: BoxFit.cover),
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

  /// 편집 모드.
  Widget _buildEditMode() {
    final addItem = InkWell(
      child: Icon(Icons.add_circle_outline, size: 32.0, color: Colors.grey),
      onTap: () {
        setState(() {
          this.widget._member.checklist.add(Checklist('name', 'contents','','',false));
        });
      },
    );
print (widget._member.checklist.length);
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(height: 16.0),
        // for(int i=0; i < widget._member.checklist.length; i++) {
        //   return _buildEditItem(widget._member.checklist[i]);
        // }
        _buildEditItem(widget._member.checklist[0]),
        _buildEditItem(widget._member.checklist[1]),
        ...this.widget._member.checklist.map((e) {print(e.name); return _buildEditItem(e);}),
        // (widget._member.checklist.length > 0 ) ? ...this.widget._member.checklist.map((e) {print(e.name); return _buildEditItem(e);}) : Text ('체크리스트 없음'),
          const SizedBox(height: 16.0),
          Align(
            alignment: Alignment.center,
            child: addItem,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: WidgetUtils.buildDefaultButton('저장', () {
              _getData();
              setState(() => this._isEdit = false,);
            }),
          ),
        ],
      ),
    );
  }

  /// 편집모드 아이템 빌드.
  Widget _buildEditItem(Checklist checklist) {
    final nameCtrl = TextEditingController();
    final contentsCtrl = TextEditingController();

    if (checklist.name != null) nameCtrl.text = checklist.name;
    if (checklist.contents != null) contentsCtrl.text = checklist.contents;

    final name = TextField(
      controller: nameCtrl,
      onChanged: (String value) => checklist.name = value,
      style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: Colors.black54),
      decoration: InputDecoration(
        isDense: true, // Added this
        contentPadding: EdgeInsets.all(8.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
      ),
    );

    final contents = TextField(
      controller: contentsCtrl,
      onChanged: (String value) => checklist.contents = value,
      style: TextStyle(fontSize: 13.0, color: Colors.black54),
      decoration: InputDecoration(
        isDense: true, // Added this
        contentPadding: EdgeInsets.all(8.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
      ),
    );

    final checkbox = Transform.scale(
      scale: 1.2,
      child: Checkbox(
        value: checklist.isEditable,
        visualDensity: VisualDensity.compact,
        onChanged: (bool isChecked) => setState(() => checklist.isEditable = isChecked),
      ),
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
              child: Image.asset('assets/ic_dumbbell.png', width: 32.0, fit: BoxFit.cover),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
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
