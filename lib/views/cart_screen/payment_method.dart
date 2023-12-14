import 'package:app_xemay/consts/consts.dart';
import 'package:app_xemay/consts/lists.dart';
import 'package:app_xemay/controllers/cart_controller.dart';
import 'package:app_xemay/views/home_screen/home.dart';
import 'package:app_xemay/widget_common/loading_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../widget_common/our_button.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Obx(
      ()=>
       Scaffold(
        backgroundColor: whiteColor,
        bottomNavigationBar: SizedBox(
          height: 60,
          child: controller.placingOrder.value ? Center(
            child: loadingIndicator(),
          ): ourButton(
              onPress: () async {
                controller.placeMyOrder(
                    orderPaymentMethod:paymentMethodList[controller.paymentIndex.value],
                    totalAmount: controller.totalP.value);
                    await controller.clearCart();
                    VxToast.show(context, msg: "Đặt Hàng Thành Công");

                    Get.offAll(const Home() );
              },
              color: redColor,
              textColor: whiteColor,
              title: "Đặt Hàng Ngay"),
        ),
        appBar: AppBar(
          title: "Đã Chọn Thanh Toán".text.color(darkFontGrey).make(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(
            () => Column(
                children: List.generate(paymentMethodImg.length, (index) {
              return GestureDetector(
                onTap: () {
                  controller.changePaymentIndex(index);
                },
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        style: BorderStyle.solid,
                        color: controller.paymentIndex.value == index
                            ? redColor
                            : Colors.transparent,
                        width: 1,
                      )),
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Image.asset(paymentMethodImg[index],
                          width: double.infinity,
                          colorBlendMode: controller.paymentIndex.value == index
                              ? BlendMode.darken
                              : BlendMode.color,
                          color: controller.paymentIndex.value == index
                              ? Colors.black.withOpacity(0.5)
                              : Colors.transparent,
                          height: 100,
                          fit: BoxFit.cover),
                      controller.paymentIndex.value == index
                          ? Transform.scale(
                              scale: 1.2,
                              child: Checkbox(
                                activeColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                value: true,
                                onChanged: (value) {},
                              ),
                            )
                          : Container(),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child:
                            paymentMethodList[index].text.white.size(16).make(),
                      ),
                    ],
                  ),
                ),
              );
            })),
          ),
        ),
      ),
    );
  }
}
