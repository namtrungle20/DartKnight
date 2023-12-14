import 'package:app_xemay/consts/consts.dart';

Widget orderPlaceDetail({data, title1, title2, d1, d2}){
  return  Padding(
              padding: const EdgeInsets.symmetric(horizontal:16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "$title1".text.make(),
                      "$d1".text.color(redColor).make()
                    ],
                  ),
                  SizedBox(
                    width: 130,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "$title2".text.make(),
                        "$d2".text.make(),
                      ],
                    ),
                  )
                ],
              ),
            );
}