import 'package:app_xemay/consts/consts.dart';
import 'package:app_xemay/views/category_screen/category_details.dart';

Widget featuredButton({String? title}) {
  return Row(
    children: [
      10.widthBox,
      title!.text.size(20).color(darkFontGrey).make(),
    ],
  )
      .box
      .width(200)
      .margin(const EdgeInsets.symmetric(horizontal: 4))
      .white
      .padding(const EdgeInsets.all(4))
      .roundedSM
      .outerShadow
      .make()
      .onTap(() {
        Get.to(()=>CategoryDetails(title: title));
      });
}
