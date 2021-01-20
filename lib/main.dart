import 'package:fitwith/utils/utils_common.dart';
import 'package:fitwith/views/new_member_swipe/page_new_member_swipe.dart';
import 'package:fitwith/views/premium/repositories/repository_premium.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> tabNavKey1 = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> tabNavKey2 = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> tabNavKey3 = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> tabNavKey4 = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> tabNavKey5 = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      child: MyApp(),
      providers: [
        ChangeNotifierProvider<PremiumRepository>(create: (_) => PremiumRepository()),
      ],
    ),
  );
}

class MyApp extends StatelessWidget {
  /// App title.
  static const String _TITLE = 'FIT WITH';

  /// App default font.
  static const String _DEFAULT_FONT = 'SpoqaHanSansNeo';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _TITLE,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: _DEFAULT_FONT,
        primaryColor: CommonUtils.getPrimaryColor(),
      ),
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          child: child,
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        );
      },
      home: NewMemberSwipePage(),
    );
  }
}
