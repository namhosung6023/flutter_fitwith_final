import 'package:fitwith/utils/utils_common.dart';
import 'package:fitwith/utils/utils_widget.dart';
import 'package:fitwith/views/premium/widgets/widget_member_checklist.dart';
import 'package:fitwith/views/premium/widgets/widget_member_diary.dart';
import 'package:fitwith/views/premium/widgets/widget_member_checklist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 프리미엄 - 회원 전용 페이지.
class PremiumMemberPage extends StatefulWidget {
  @override
  _PremiumMemberPageState createState() => _PremiumMemberPageState();
}

class _PremiumMemberPageState extends State<PremiumMemberPage> with SingleTickerProviderStateMixin {

  String userId;
  String trainerComment;

  /// 캘린더 컨트롤러.
  final _calendarCtrl = CalendarController();
  DateTime _selectedDay = DateTime.now();
  // DateTime _selectedDay;

  /// tab widget controller.
  TabController _tabCtrl;
  void _getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    userId = decodedToken['_id'];

    Dio dio = new Dio();
    dio.options.headers["accesstoken"] = "$token";
    Response response =
    await dio.get('http://10.0.2.2:3000/premium/checklist/user/$userId', queryParameters: {
      "date": _selectedDay
    });
    setState(() {
      if(response.data['checklist'].length > 0){
        trainerComment = response.data['checklist'][0]['trainerComment'];
      }else{
        setState(() {
          trainerComment = "";
        });
      }
    });
  }

  @override
  void initState() {
    this._tabCtrl = TabController(vsync: this, length: 2);
    super.initState();
    _getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: WidgetUtils.buildAppBar(trailing: _buildNotification()),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        padding: const EdgeInsets.only(left: 32.0, right: 32.0),
        children: [
          const SizedBox(height: 8.0),
          _buildDatePicker(),
          const SizedBox(height: 24.0),
          Text(
            '오늘의 코멘트',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 21.0),
          _buildTrainerComment(),
          const SizedBox(height: 40.0),
          Padding(
            padding: const EdgeInsets.only(left: 32.0, right: 32.0),
            child: _buildTabBar(),
          ),
          Expanded(
            child: TabBarView(
              controller: this._tabCtrl,
              children: [
                MemberChecklist(selectedDay: _selectedDay,),
                MemberDiary(selectedDay: _selectedDay,),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildTrainerComment() {
    final profile = ClipOval(
      child: Image.asset('assets/img_sample.png', fit: BoxFit.cover, width: 50.0, height: 40.0),
    );

    final message = Container(
      padding: const EdgeInsets.fromLTRB(5.0, 16.0, 5.0, 16.0),
      child: Text(
        trainerComment ?? '',
        style: TextStyle(fontSize: 12.0, height: 1.5),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(8.0),
      ),
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 16.0),
        profile,
        const SizedBox(width: 16.0),
        Expanded(child: message),
        const SizedBox(width: 16.0),
      ],
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

  /// 앱바 노티피케이션 아이콘 빌드.
  Widget _buildNotification() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) =>
                  _buildNotificationDialog(context),
            );
          },
          child: WidgetUtils.buildNotificationIcon(isNew: true, size: 24.0),
        ),
        const SizedBox(width: 24.0),
      ],
    );
  }

  /// 날짜 선택 UI.
  Widget _buildDatePicker() {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => _buildCalendarDialog(context),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(child: Icon(Icons.chevron_left),
              onTap: () => _onTapPickerArrow(Icons.chevron_left)),
          const SizedBox(width: 8.0),
          Container(
            width: 160.0,
            padding: const EdgeInsets.only(top: 8.0, bottom: 6.0),
            alignment: Alignment.center,
            child: Text(
              '${this._selectedDay.year}.${this._selectedDay.month}.${this._selectedDay
                  .day}. ${_convertWeekday(this._selectedDay.weekday)}',
              style: TextStyle(fontSize: 16.0),
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(6.0),
            ),
          ),
          const SizedBox(width: 8.0),
          InkWell(child: Icon(Icons.chevron_right),
              onTap: () => _onTapPickerArrow(Icons.chevron_right)),
        ],
      ),
    );
  }

  /// 다이얼로그 캘린더 빌드.
  Widget _buildCalendarDialog(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          WidgetUtils.buildAppBar(),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: TableCalendar(
              initialSelectedDay: _selectedDay,
                calendarController: this._calendarCtrl,
                startingDayOfWeek: StartingDayOfWeek.sunday,
                calendarStyle: const CalendarStyle(
                    selectedColor: Color(0xff4781ec)),
                onDaySelected: (DateTime day, List events, List holidays) {
                  print(day);
                  setState(() {
                    _selectedDay = day;
                  });
                  Navigator.pop(context);
                }
            ),
          ),
          const SizedBox(height: 32.0),
        ],
      ),
    );
  }

  /// 노티피케이션 이력 다이얼로그 빌드.
  Widget _buildNotificationDialog(BuildContext context) {
    final header = Text(
      '알림',
      style: TextStyle(color: Color(0xff222224),
          fontSize: 18.0,
          fontWeight: FontWeight.bold),
    );

    return Dialog(
      insetPadding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          WidgetUtils.buildAppBar(),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: Column(
              children: [
                Align(alignment: Alignment.centerLeft, child: header),
                const SizedBox(height: 8.0),
                ...ListTile.divideTiles(
                  color: Colors.grey,
                  tiles: List.generate(3, (index) => _buildNotificationItem()),
                ),
                WidgetUtils.buildDefaultButton(
                    '확인', () => Navigator.of(context).pop()),
                const SizedBox(height: 32.0),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 노티피케이션 이력 아이템 빌드.
  Widget _buildNotificationItem() {
    // 사진.
    final profile = ClipOval(
      child: Image.asset('assets/img_sample.png', fit: BoxFit.cover,
          width: 40.0,
          height: 40.0),
    );

    final message = RichText(
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        style: TextStyle(fontSize: 13.0, color: Colors.black),
        children: [
          TextSpan(
            text: 'Trainer',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: ' 님의 Message message message'),
        ],
      ),
    );

    // 시간.
    final date = Text(
      '07:23',
      textAlign: TextAlign.end,
      style: TextStyle(fontSize: 12.0),
    );

    return ListTile(
      leading: profile,
      title: message,
      isThreeLine: true,
      subtitle: date,
    );
  }

  /// 데이트 피커 조작 이벤트.
  void _onTapPickerArrow(IconData icons) {
    setState(() {
      if (icons == Icons.chevron_left) {
        this._selectedDay = this._selectedDay.add(Duration(seconds: -86400));
        // FIXME : 날짜 변경 처리.
      } else if (icons == Icons.chevron_right) {
        this._selectedDay = this._selectedDay.add(Duration(seconds: 86400));
        // FIXME : 날짜 변경 처리.
      }
    });
  }

  /// 주일 리턴.
  String _convertWeekday(int index) {
    switch (index) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return null;
    }
  }

 //   void _onDaySelected(DateTime day, List events, List holidays) {
 //    print(day);
 //     _selectedDay = day;
 //     Navigator.pop(context);
 //  }
 // }
}