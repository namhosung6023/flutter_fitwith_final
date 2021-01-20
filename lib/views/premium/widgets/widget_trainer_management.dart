import 'package:fitwith/utils/utils_common.dart';
import 'package:fitwith/views/premium/models/model_member.dart';
import 'package:fitwith/views/premium/widgets/widget_trainer_checklist.dart';
import 'package:fitwith/views/premium/widgets/widget_trainer_diary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// 프리미엄 - 트레이너 root 위젯.
class TrainerManagement extends StatefulWidget {
  /// 선택된 멤버.
  final Member _member;

  TrainerManagement(this._member);

  @override
  _TrainerManagementState createState() => _TrainerManagementState();
}

class _TrainerManagementState extends State<TrainerManagement> with SingleTickerProviderStateMixin {
  /// Tab controller.
  TabController _tabCtrl;

  @override
  void initState() {
    this._tabCtrl = TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32.0, right: 32.0),
      child: Column(
        children: [
          _buildMemberInfo(this.widget._member),
          const SizedBox(height: 8.0),
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: this._tabCtrl,
              children: [
                TrainerChecklist(this.widget._member),
                TrainerDiary(this.widget._member),
              ],
            ),
          ),
        ],
      ),
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
