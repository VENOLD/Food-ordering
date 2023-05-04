import 'package:flutter/cupertino.dart';

class Util {
  BuildContext context;
  Util(this.context);

  Size get getScreenSize => MediaQuery.of(context).size;
}
