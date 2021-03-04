import 'package:fitwith/utils/utils_widget.dart';
import 'package:fitwith/views/premium/models/model_member.dart';
import 'package:fitwith/views/premium/repositories/repository_premium.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

/// 회원 목록 위젯.
class TrainerMembers extends StatefulWidget {
  /// 저장소.
  final PremiumRepository _repository;

  TrainerMembers(this._repository);

  @override
  _TrainerMembersState createState() => _TrainerMembersState();
}

class _TrainerMembersState extends State<TrainerMembers> {
  List _memberList = [];
  int page = 1;
  String username = '';

  // List<Member> _memberList = [];
  bool _loading = true;

  String userId;

  // ///회원리스트 불러오는 api
  // void _getMember() async {
  //   print('안녕');
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString('token');
  //
  //   Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
  //   // userId = decodedToken['_id'];
  //   userId = "602b7cef9f096b3794247178";
  //   String decodedToken2 = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MDJiNzk0MjlmMDk2YjM3OTQyNDcxNzciLCJlbWFpbCI6Im1pbGtAbmF2ZXIuY29tIiwiaWF0IjoxNjEzNjMxODc4LCJleHAiOjE2Mzk1NTE4Nzh9.GeJ0AYGfzRcgVotIsTSRJDFusYoKoPiEdoeADNKynEg';
  //   Dio dio = new Dio();
  //   dio.options.headers["accesstoken"] = "$decodedToken2";
  //
  //   Response response = await dio.get(
  //     djfksfsksjfjsdafsakjffajskh
  //       'http://10.0.2.2:3000/premium/userlist/$userId');
  //   print(response.data['data'][0]);
  //   if (response.data['data'].length > 0)
  //     setState(() {
  //       if (response.data['data'][0]['user']['username'].length > 0) {
  //         for (int i = 0; i < response.data['data'].length; i++) {
  //           Member _member = Member(
  //               response.data['data'][i]['user']['username'],
  //               response.data['data'][i]['user']['gender'],
  //               response.data['data'][i]['user']['age']);
  //           _memberList.add(_member);
  //         }
  //         if (response.data['data'][0]['user']['username'].length > 0){
  //           for(int i = 0; i < response.[data'data'].length; i++) {
  //             Member _member = Member (
  //               response.data['data'][i]['user']['profileImages']);
  //             _memberList.add(_member);
  //           }
  //         }
  //       }
  //       print('dfaf');
  //     });
  //   _loading = false;
  // }

  /// 한 페이지에 그려질 아이템 개 수.
  // static const int _LIMIT = 7;

  /// 임시 멤버 리스트.
  final _temporary = List.generate(
      34, (i) => Member('NAME $i', Member.FEMALE, 20 + i));

  /// 페이지 인덱스.
  // var _index = 0;

  @override
  void initState() {
    // _getMember();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // _getMember();
    return _loading ? Container() : ListView(
      padding: const EdgeInsets.only(left: 32.0, right: 32.0),
      children: [
        Text(
          '회원 관리',
          style: TextStyle(
            color: Color(0xff222224),
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 25.0),
        // member counter.
        Text(
          '(전체 ${this._temporary.length}명)',
          style: TextStyle(
            color: Color(0xff999999),
            fontSize: 12.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 16.0),
        // ...ListTile.divideTiles(
        //   context: context,
        //   tiles: _buildMembers(),
        // ),
        // ..._buildMembers(),
        _buildMemberItem2(),
        const SizedBox(height: 24.0),
        // _buildPageCtrl(),
        const SizedBox(height: 64.0),
      ],
    );
  }


  Widget _buildMemberItem2() {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: EdgeInsets.all(7),
      itemCount: _memberList.length,
        separatorBuilder: (context, index)
        { return Divider(); },
      itemBuilder: (context, index) {
        Member member = _memberList[index];
        print(_memberList.length);
        return Text('${member.name}',
          style: TextStyle (
              fontSize: 20, height: 2.0),
        );
        // return ListView(
        //   children: [
        //     // final profile = ClipOval(
        //     // child: Image.asset(member.url, fit: BoxFit.cover, width: 40.0, height: 40.0),
        //     // );
        //
        //     // 이름.
        //     Text(
        //       member.name,
        //       style: TextStyle(fontSize: 18.0),
        //     ),
        //
        //     // 성별 및 나이.
        //     Text(
        //       '${member.gender}, ${member.age}세',
        //       style: TextStyle(fontSize: 17.0),
        //     ),
        //
        //     // return ListTile(
        //     // onTap: () {
        //     // this.widget._repository.selectMember(member);
        //     // },
        //     // leading: profile,
        //     // title: Row(
        //     // crossAxisAlignment: CrossAxisAlignment.center,
        //     // children: [
        //     // name,
        //     // const SizedBox(width: 12.0),
        //     // ],
        //     // ),
        //     // trailing: info,
        //     // );
        //     // }
        //   ],
        // );
      },
    );
  }

  /// 회원 목록 아이템 위젯 빌드.
  Widget _buildMemberItem(Member member, int index) {
    //프로필 사진.
    final profile = ClipOval(
      child: Image.asset(
          member.url, fit: BoxFit.cover, width: 40.0, height: 40.0),
    );

    // 이름.
    final name = Text(
      _memberList[index].name,
      style: TextStyle(fontSize: 18.0),
    );

    // 성별 및 나이.
    final info = Text(
      '${_memberList[index].gender}, ${_memberList[index].age}세',
      style: TextStyle(fontSize: 17.0),
    );

    return ListTile(
      onTap: () {
        this.widget._repository.selectMember(member);
      },
      leading: profile,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          name,
          const SizedBox(width: 12.0),
        ],
      ),
      trailing: info,
    );
  }

/// 회원 타임라인 이력 위젯 빌드.
// Widget _buildMemberHistory(Member member) {
//   // 사진.
//   final profile = ClipOval(
//     child: Image.asset(member.url, fit: BoxFit.cover, width: 40.0, height: 40.0),
//   );
//
//   final message = RichText(
//     maxLines: 2,
//     overflow: TextOverflow.ellipsis,
//     text: TextSpan(
//       style: TextStyle(fontSize: 13.0, color: Colors.black),
//       children: [
//         TextSpan(
//           text: member.name,
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         TextSpan(text: ' 님의 Message message message'),
//       ],
//     ),
//   );
//
//   // 시간.
//   final date = Text(
//     '07:23',
//     textAlign: TextAlign.end,
//     style: TextStyle(fontSize: 13.0),
//   );
//
//   // 정보.
//   final info = Text(
//     '48.3Kg',
//     style: TextStyle(
//       color: Colors.grey,
//       fontSize: 18.0,
//       fontWeight: FontWeight.bold,
//     ),
//   );
//
//   return ListTile(
//     leading: profile,
//     title: message,
//     isThreeLine: true,
//     subtitle: date,
//     trailing: info,
//   );
// }

/// 리스트 인디케이터 빌드.
// List<Widget> _buildIndicator() {
//   final List<Widget> result = [];
//   for (var i = 0; i <= (this._temporary.length / _LIMIT).floor(); i++) {
//     result.add(
//       Text(
//         '$i',
//         style: TextStyle(fontSize: 16.0, fontWeight: (this._index == i) ? FontWeight.bold : null),
//       ),
//     );
//     if (i != (this._temporary.length / _LIMIT).floor()) result.add(Text('·', style: TextStyle(fontSize: 16.0)));
//   }
//   return result;
// }

/// 회원 리스트 위젯 빌드.
// List<Widget> _buildMembers() {
//   final List<Widget> result = [];
//   for (var i = 0; i < _LIMIT; i++) {
//     final index = (this._index * _LIMIT) + i;
//     if (this._temporary.length > index) {
//       final target = this._temporary[index];
//       result.add(_buildMemberItem(target, index));
//     }
//   }
//   return result;
// }
// List<Widget> _buildMembers() {
//   final List<Widget> result = [];
//       result.add(_buildMemberItem(target, index));
//   return result;
// }

/// 페이지 컨트롤러 빌드.
// Widget _buildPageCtrl() {
//   return Row(
//     mainAxisSize: MainAxisSize.max,
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       InkWell(child: Icon(Icons.chevron_left), onTap: () => _pageCtrl(Icons.chevron_left)),
//       Row(children: _buildIndicator()),
//       InkWell(child: Icon(Icons.chevron_right), onTap: () => _pageCtrl(Icons.chevron_right)),
//     ],
//   );
// }

/// 페이지 컨트롤러 이벤트 처리.
//   void _pageCtrl(IconData iconData) {
//     setState(() {
//       if (iconData == Icons.chevron_left) {
//         if (this._index > 0) this._index--;
//       } else if (iconData == Icons.chevron_right) {
//         if ((this._temporary.length / _LIMIT).floor() > this._index) this._index++;
//       }
//     });
//   }

}