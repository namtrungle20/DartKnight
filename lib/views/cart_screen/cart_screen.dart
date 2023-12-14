import 'package:app_xemay/consts/consts.dart';
import 'package:app_xemay/controllers/cart_controller.dart';
import 'package:app_xemay/services/firestore_services.dart';
import 'package:app_xemay/views/cart_screen/shipping_screen.dart';
import 'package:app_xemay/widget_common/loading_indicator.dart';
import 'package:app_xemay/widget_common/our_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
        backgroundColor: whiteColor,
        bottomNavigationBar: SizedBox(
          height: 60,
          child: ourButton(
              color: Colors.blueAccent,
              onPress: () {
                Get.to(() => const ShippingScreen());
              },
              textColor: whiteColor,
              title: "Thanh Toán"),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: "Giỏ Hàng".text.color(darkFontGrey).make(),
        ),
        body: StreamBuilder(
            stream: FirestoreServices.getCart(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: loadingIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: "Giỏ Rỗng".text.color(darkFontGrey).make(),
                );
              } else {
                var data = snapshot.data!.docs;
                controller.calculate(data);
                controller.productSnapShot = data;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                                leading: Image.network(
                                  '${data[index]['img']}',
                                  width: 120,
                                  fit: BoxFit.contain,
                                ),
                                title:
                                    "${data[index]['title']} (x${data[index]['qty']})"
                                        .text
                                        .size(16)
                                        .make(),
                                subtitle: "${data[index]['tprice']}"
                                    .numCurrency
                                    .text
                                    .color(redColor)
                                    .make(),
                                trailing: const Icon(
                                  Icons.delete,
                                  color: redColor,
                                ).onTap(() {
                                  FirestoreServices.deleteDocument(
                                      data[index].id);
                                }));
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Tổng Giá".text.color(darkFontGrey).make(),
                        Obx(() => "${controller.totalP.value}"
                            .numCurrency
                            .text
                            .color(redColor)
                            .make()),
                      ],
                    )
                        .box
                        .padding(const EdgeInsets.all(12))
                        .color(lightGolden)
                        .roundedSM
                        .make(),
                    10.heightBox,
                  ]),
                );
              }
            }));
  }
}
