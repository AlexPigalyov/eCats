import 'package:ecats/models/enums/app_bar_enum.dart';
import 'package:ecats/models/enums/page_enum.dart';

class PageModel {
  PageModel({required this.page, required this.appBar, this.args});

  PageEnum page;
  AppBarEnum appBar;
  dynamic? args;
}
