import 'package:fitwith/utils/utils_widget.dart';
import 'package:fitwith/views/premium/repositories/repository_premium.dart';
import 'package:fitwith/views/premium/widgets/widget_trainer_management.dart';
import 'package:fitwith/views/premium/widgets/widget_trainer_members.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

/// 프리미엄 - 트레이너 전용 페이지.
class PremiumTrainerPage extends StatefulWidget {
  @override
  _PremiumTrainerPageState createState() => _PremiumTrainerPageState();
}

class _PremiumTrainerPageState extends State<PremiumTrainerPage> {
  /// 애니메이션 키.
  final _key = GlobalKey();

  /// 캘린더 컨트롤러.
  final _calendarCtrl = CalendarController();

  /// 현재 날짜.
  var _current = DateTime.now();

  /// 저장소.
  PremiumRepository _repository;

  @override
  void initState() {
    this._repository = Provider.of<PremiumRepository>(context, listen: false);
    super.initState();
  }

  ///
  Widget _buildClearButton() {
    return InkWell(
      child: Icon(Icons.clear, color: Colors.grey),
      onTap: this._repository.clearSelected,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<PremiumRepository>(
        builder: (_, repository, __) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: WidgetUtils.buildAppBar(leading: (repository.member != null) ? _buildClearButton() : Container()),
            body: Column(
              children: [
                const SizedBox(height: 8.0),
                _buildDatePicker(),
                const SizedBox(height: 24.0),
                Expanded(
                  child: AnimatedSwitcher(
                    key: this._key,
                    duration: Duration(milliseconds: 200),
                    child: (repository.member != null) ? TrainerManagement(repository.member, _current) : TrainerMembers(repository),
                  ),
                ),
              ],
            ),
          );
        },
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
              calendarController: this._calendarCtrl,
              startingDayOfWeek: StartingDayOfWeek.monday,
              calendarStyle: const CalendarStyle(selectedColor: Color(0xff4781ec)),
            ),
          ),
          const SizedBox(height: 24.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetUtils.buildDefaultButton('이동', () => Navigator.pop(context)),
              const SizedBox(width: 24.0),
              WidgetUtils.buildDefaultButton('취소', () => Navigator.pop(context)),
            ],
          ),
          const SizedBox(height: 32.0),
        ],
      ),
    );
  }

  /// 날짜 선택 UI.
  Widget _buildDatePicker() {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return _buildCalendarDialog(context);
          },
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(child: Icon(Icons.chevron_left), onTap: () => _onTapPickerArrow(Icons.chevron_left)),
          const SizedBox(width: 8.0),
          Container(
            width: 160.0,
            padding: const EdgeInsets.only(top: 8.0, bottom: 6.0),
            alignment: Alignment.center,
            child: Text(
              '${this._current.year}.${this._current.month}.${this._current.day}. ${_convertWeekday(this._current.weekday)}',
              style: TextStyle(fontSize: 16.0),
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(6.0),
            ),
          ),
          const SizedBox(width: 8.0),
          InkWell(child: Icon(Icons.chevron_right), onTap: () => _onTapPickerArrow(Icons.chevron_right)),
        ],
      ),
    );
  }


  /// 데이트 피커 조작 이벤트.
  void _onTapPickerArrow(IconData icons) {
    setState(() {
      if (icons == Icons.chevron_left) {
        this._current = this._current.add(Duration(seconds: -86400));
        print(_onTapPickerArrow);
        // FIXME : 날짜 변경 처리.
      } else if (icons == Icons.chevron_right) {
        this._current = this._current.add(Duration(seconds: 86400));
        print(_onTapPickerArrow);
        // FIXME : 날짜 변경 처리.
      }
      print(_onTapPickerArrow);
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
}
