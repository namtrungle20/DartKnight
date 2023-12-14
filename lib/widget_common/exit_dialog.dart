import 'package:app_xemay/consts/consts.dart';
import 'package:app_xemay/widget_common/our_button.dart';
import 'package:flutter/services.dart';

Widget exitDialog(context){
  return Dialog(
    child: Column(
      children: [
        "Exits".text.size(18).color(darkFontGrey).make(),
        const Divider(),
        10.heightBox,
        "Bạn Có Muốn Thoát?".text.size(16).make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButton(
              color: redColor,
              onPress: (){
                SystemNavigator.pop();
              },
              textColor: Colors.black45,
              title: "Đồng Ý"
            ),
             ourButton(
              color: redColor,
              onPress: (){
                Navigator.pop(context);
              },
              textColor: Colors.black45,
              title: "Không"
            ),
          ],
        )
      ],
    ).box.color(lightGrey).padding(const EdgeInsets.all(12)).roundedSM.make(),
  );
}