import 'package:app_xemay/consts/consts.dart';
import 'package:app_xemay/controllers/cart_controller.dart';
import 'package:app_xemay/views/cart_screen/payment_method.dart';
import 'package:app_xemay/widget_common/custom_textfield.dart';
import 'package:app_xemay/widget_common/our_button.dart';
import 'package:flutter/material.dart';

class ShippingScreen extends StatelessWidget {
  const ShippingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller=Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Thông tin vận chuyển".text.color(darkFontGrey).make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
          onPress: (){
            if(controller.addressController.text.length >5){
              Get.to(()=>const PaymentMethod());
            }else 
            {
              VxToast.show(context, msg: "Hãy Điền Thông Tin");
            }
          },
          color: redColor,
          textColor: whiteColor,
          title: "Thanh Toán"
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            customTextField(hint: "Đường", isPass: false, title: "Đường", controller: controller.addressController),
            customTextField(hint: "Thành Phố", isPass: false, title: "Thành Phố", controller: controller.cityController),
            customTextField(hint: "Số Điện Thoại", isPass: false, title: "Số Điện Thoại", controller: controller.phoneController),
          ],
        ),
      )
    );
  }
}