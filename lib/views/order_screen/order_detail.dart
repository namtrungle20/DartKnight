import 'package:app_xemay/consts/consts.dart';
import 'package:app_xemay/views/order_screen/compoment/order_place_detail.dart';
import 'package:app_xemay/views/order_screen/compoment/order_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetail extends StatelessWidget {
  final dynamic data;
  const OrderDetail({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Chi Tiết Đơn Hàng".text.color(darkFontGrey).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              orderStatus(
                color: redColor,
                icon: Icons.done,
                title: "Đã Đặt Hàng",
                showDone: "${data['order_place']}",
              ),
              orderStatus(
                color: Colors.blue,
                icon: Icons.thumb_up,
                title: "Xác Nhận Đặt Hàng",
                showDone: "${data['order_confirmed']}",
              ),
              orderStatus(
                color: Colors.yellow,
                icon: Icons.car_crash,
                title: "Được Giao Hàng",
                showDone: "${data['order_on_delivered']}",
              ),
              orderStatus(
                color: Colors.purple,
                icon: Icons.done_all_rounded,
                title: "Đã Giao Hàng",
                showDone: "${data['order_delivered']}",
              ),
              const Divider(),
              10.heightBox,
              Column(
                children: [
                  orderPlaceDetail(
                    d1: "${data['order_code']}",
                    d2: "${data['shipping_method']}",
                    title1: "Mã Đơn Hàng",
                    title2: "Hình Thức Vận Chuyển",
                  ),
                  orderPlaceDetail(
                    d1: intl.DateFormat()
                        .add_yMd()
                        .format((data['order_date'].toDate())),
                    d2: "${data['payment_method']}",
                    title1: "Ngày Đặt Hàng",
                    title2: "Hình Thức Thanh Toán",
                  ),
                  orderPlaceDetail(
                    d1: "Chưa Thanh Toán",
                    d2: "Đã Đặt Hàng",
                    title1: "Tình Hình Thanh Toán",
                    title2: "Tình Hình Giao Hàng",
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Địa Chỉ Giao Hàng".text.make(),
                            "${data['order_by_name']}".text.make(),
                            "${data['order_by_email']}".text.make(),
                            "${data['order_by_andress']}".text.make(),
                            "${data['order_by_city']}".text.make(),
                            "${data['order_by_phone']}".text.make(),
                          ],
                        ),
                        SizedBox(
                          width: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Tổng Cộng".text.make(),
                              "${data['total_amount']}".text.color(redColor).make()
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ).box.outerShadowSm.white.make(),
              10.heightBox,
              "Sản Phẩm Đã Đặt".text.size(16).color(darkFontGrey).makeCentered(),
              10.heightBox,
              ListView(
                shrinkWrap: true,
                children: List.generate(data['order'].length, (index){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      orderPlaceDetail(
                        title1: data['orders'][index]['title'],
                        title2: data['orders'][index]['tprice'],
                        d1:"${data['orders'][index]['qty']}x",
                        d2: "Hoàn Tiền",
                      ),
                    ],
                  );
                }).toList(),  
              ).box.outerShadowSm.white.margin(const EdgeInsets.only(bottom: 4)).make(),
              10.heightBox,
             
            ],
          ),
        ),
      ),
    );
  }
}
