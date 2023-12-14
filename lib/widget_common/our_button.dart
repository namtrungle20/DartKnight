import 'package:app_xemay/consts/consts.dart';

Widget ourButton({onPress, color, textColor, String? title}){
  return ElevatedButton(
  style: ElevatedButton.styleFrom(
    padding: const EdgeInsets.all(12),
  ),
  onPressed: onPress, 
  child: title!.text.make());
}