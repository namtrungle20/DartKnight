import 'package:app_xemay/consts/consts.dart';

Widget homeButtons({width, height, icon, String? title, onPress}){
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(icon, width: 26),
        10.heightBox,
        title!.text.color(darkFontGrey).make()
      ],) .box.rounded.white.size(height, width).shadowSm.make()
    );
}