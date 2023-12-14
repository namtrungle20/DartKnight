import 'package:app_xemay/consts/consts.dart';

Widget customTextField({String? title,String? hint, controller, isPass}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.color(const Color.fromARGB(255, 75, 51, 19)).size(17).make(),
      5.heightBox,
      TextFormField(
        obscureText: isPass,
        controller: controller,
        decoration: InputDecoration(
          hintStyle: const TextStyle(
            color: textfieldGrey,
          ),
          hintText: hint,
          isDense: true,
          fillColor: lightGrey,
          filled: true,
          border: InputBorder.none,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(30, 255, 153, 0))
          )
        ),
      )
    ],
  );
}
