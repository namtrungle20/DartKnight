import 'package:app_xemay/consts/consts.dart';
import 'package:app_xemay/services/firestore_services.dart';
import 'package:app_xemay/views/order_screen/order_detail.dart';
import 'package:app_xemay/widget_common/loading_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: "Đơn Hàng".text.color(darkFontGrey).make(),
        ),
        body: StreamBuilder(
            stream: FirestoreServices.getAllOrders(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: loadingIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return "Chưa Đặt Hàng!".text.color(darkFontGrey).makeCentered();
              } else {
                var data = snapshot.data!.docs;
                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: "${index + 1}".text.color(darkFontGrey).xl.make(),
                        title: data[index]['order_code']
                            .toString()
                            .text
                            .color(redColor)
                            .make(),
                        subtitle: data[index]['total_amount']
                            .toString()
                            .numCurrency
                            .text
                            .make(),
                        trailing: IconButton(
                          onPressed: () {
                            Get.to(()=>const OrderDetail());
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: darkFontGrey,
                          ),
                        ),
                      );
                    });
              }
            }));
  }
}
