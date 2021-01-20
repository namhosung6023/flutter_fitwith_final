import 'package:fitwith/utils/utils_common.dart';
import 'package:fitwith/views/training/page_daily_exercise_all_curriculum.dart';
import 'package:fitwith/views/training/page_management_reservation_upload.dart';
import 'package:fitwith/views/training/page_management_student.dart';
import 'package:fitwith/views/training/page_online_consulting.dart';
import 'package:fitwith/views/training/page_premium_member_management.dart';
import 'package:fitwith/views/training/page_search_around_trainer.dart';
import 'package:fitwith/views/training/page_weekly_tarining.dart';
import 'package:fitwith/views/training/page_training_main.dart';
import 'package:flutter/material.dart';

/// 드로워 메뉴
Widget buildDrawer(BuildContext context) {
  return Container(
    width: 250.0,
    child: Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 80.0,
            child: DrawerHeader(
              child: Text(
                '트레이닝 페이지',
                style: TextStyle(color: Colors.white),
              ),
              decoration: BoxDecoration(
                color: CommonUtils.getPrimaryColor(),
              ),
            ),
          ),
          ListTile(
            trailing: Icon(Icons.arrow_forward_ios),
            title: Text('트레이너 메인 페이지_회원'),
            onTap: () => CommonUtils.movePageDrawer(context, TrainingMainPage(userType: CommonUtils.TYPE_MEMBER)),
          ),
          ListTile(
            trailing: Icon(Icons.arrow_forward_ios),
            title: Text('트레이너 메인 페이지_트레이너'),
            onTap: () => CommonUtils.movePageDrawer(context, TrainingMainPage(userType: CommonUtils.TYPE_TRAINER)),
          ),
          ListTile(
            trailing: Icon(Icons.arrow_forward_ios),
            title: Text('트레이너_프리미엄 회원 관리_일정입력페이지'),
            onTap: () => CommonUtils.movePageDrawer(context, PremiumUserManagementPage()),
          ),
          ListTile(
            trailing: Icon(Icons.arrow_forward_ios),
            title: Text('트레이너_프리미엄 회원 관리_일정편집'),
            onTap: () => CommonUtils.movePageDrawer(context, PremiumUserManagementPage(pageType: CommonUtils.PAGE_TYPE_EDIT)),
          ),
          ListTile(
            trailing: Icon(Icons.arrow_forward_ios),
            title: Text('트레이너_프리미엄 회원 관리_일정 완료'),
            onTap: () => CommonUtils.movePageDrawer(context, PremiumUserManagementPage(pageType: CommonUtils.PAGE_TYPE_COMPLETE)),
          ),
          ListTile(
            trailing: Icon(Icons.arrow_forward_ios),
            title: Text('일별 운동 페이지_트레이너 / X - 19'),
            onTap: () => CommonUtils.movePageDrawer(context, WeeklyTrainingPage(userType: CommonUtils.TYPE_TRAINER)),
          ),
          ListTile(
            trailing: Icon(Icons.arrow_forward_ios),
            title: Text('일별 운동 페이지_트레이너 / X - 20'),
            onTap: () => CommonUtils.movePageDrawer(context, WeeklyTrainingPage(userType: CommonUtils.TYPE_TRAINER)),
          ),
          ListTile(
            trailing: Icon(Icons.arrow_forward_ios),
            title: Text('일별 운동 페이지_전체 커리큘럼'),
            onTap: () => CommonUtils.movePageDrawer(context, DailyExerciseAllCurriculumPage()),
          ),
          ListTile(
            trailing: Icon(Icons.arrow_forward_ios),
            title: Text('일별 운동 페이지_수강생관리'),
            onTap: () => CommonUtils.movePageDrawer(context, ManagementStudentPage()),
          ),
          ListTile(
            trailing: Icon(Icons.arrow_forward_ios),
            title: Text('일별 운동 페이지_예약업로드관리'),
            onTap: () => CommonUtils.movePageDrawer(context, ManagementReservationUploadPage()),
          ),
          ListTile(
            trailing: Icon(Icons.arrow_forward_ios),
            title: Text('내 주변 트레이너 찾기'),
            onTap: () => CommonUtils.movePageDrawer(context, SearchAroundTrainerPage()),
          ),
          ListTile(
            trailing: Icon(Icons.arrow_forward_ios),
            title: Text('일별 운동페이지_회원'),
            onTap: () => CommonUtils.movePageDrawer(context, WeeklyTrainingPage(userType: CommonUtils.TYPE_MEMBER)),
          ),
          ListTile(
            trailing: Icon(Icons.arrow_forward_ios),
            title: Text('일별 운동 페이지_전체 커리큘럼_회원'),
            onTap: () => CommonUtils.movePageDrawer(context, DailyExerciseAllCurriculumPage(userType: CommonUtils.TYPE_MEMBER)),
          ),
          ListTile(
            trailing: Icon(Icons.arrow_forward_ios),
            title: Text('온라인 상담신청'),
            onTap: () => CommonUtils.movePageDrawer(context, OnlineConsultingPage()),
          ),
        ],
      ),
    ),
  );
}
