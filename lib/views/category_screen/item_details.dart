import 'package:app_xemay/consts/colors.dart';
import 'package:app_xemay/consts/consts.dart';
import 'package:app_xemay/consts/lists.dart';
import 'package:app_xemay/controllers/product_controller.dart';
import 'package:app_xemay/widget_common/our_button.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  final dynamic data;
  const ItemDetails({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return WillPopScope(
      onWillPop: ()async{
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          leading: IconButton(
            onPressed: (){
              controller.resetValues();
              Get.back();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: title!.text.color(darkFontGrey).make(),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
            Obx(
              ()=>
               IconButton(onPressed: () {
                if(controller.isFav.value){
                  controller.removeFromWishlish(data.id, context);
                }else{
                  controller.addToWishlish(data.id, context);
                }
              }, 
              icon: Icon(
                Icons.favorite_outline,
                color: controller.isFav.value? redColor:darkFontGrey,
                )),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VxSwiper.builder(
                        autoPlay: true,
                        height: 300,
                        itemCount: data['p_imgs'].length,
                        aspectRatio: 12 / 9,
                        viewportFraction: 1.0,
                        itemBuilder: (context, index) {
                          return Image.network(
                            data["p_imgs"][index],
                            width: double.infinity,
                            fit: BoxFit.cover,
                          );
                        }),
                    10.heightBox,
                    title!.text.size(16).color(darkFontGrey).make(),
                    10.heightBox,
                    VxRating(
                      isSelectable: false,
                      value: double.parse(data['p_rating']),
                      onRatingUpdate: (value) {},
                      normalColor: textfieldGrey,
                      selectionColor: golden,
                      count: 5,
                      size: 25,
                      stepInt: true,
                    ),
                    10.heightBox,
                    "${data['p_price']}"
                        .numCurrency
                        .text
                        .size(30)
                        .color(Vx.blue600)
                        .make(),
                    10.heightBox,
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: "Số Lượng: ".text.color(textfieldGrey).make(),
                        ),
                        Obx(
                          () => Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    controller.decreaseQuantity();
                                    controller.calculateTotalPrice(int.parse(data['p_price']));
                                  },
                                  icon: const Icon(Icons.remove)),
                              controller.quantity.value.text
                                  .size(16)
                                  .color(darkFontGrey)
                                  .make(),
                              IconButton(
                                  onPressed: () { 
                                    controller.increaseQuantity(int.parse(data['p_quantity']));
                                    controller.calculateTotalPrice(int.parse(data['p_price']));
                                  },
                                  icon: const Icon(Icons.add)),
                              10.heightBox,
                              "(${data['p_quantity']}có sẵn)" 
                                  .text
                                  .color(textfieldGrey)
                                  .make(),
                            ],
                          ),
                        )
                      ],
                    ).box.padding(const EdgeInsets.all(8)).make(),
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: "Tổng Cộng: ".text.color(textfieldGrey).make(),
                        ),
                        "${controller.totalPrice.value}"
                            .numCurrency
                            .text
                            .color(redColor)
                            .size(16)
                            .make(),
                      ],
                    ).box.padding(const EdgeInsets.all(8)).make(),
                    10.heightBox,
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Người bán".text.white.make(),
                            5.heightBox,
                            "${data['p_seller']}"
                                .text
                                .color(darkFontGrey)
                                .size(17)
                                .make(),
                          ],
                        )),
                        const CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.message_rounded, color: darkFontGrey),
                        ),
                      ],
                    )
                        .box
                        .height(70)
                        .padding(const EdgeInsets.symmetric(horizontal: 16))
                        .color(textfieldGrey)
                        .make(),
                    10.heightBox,
                    "MÔ TẢ".text.color(darkFontGrey).make(),
                    10.heightBox,
                    "${data['p_mota']}"
                        .text
                        .color(darkFontGrey)
                        .make(),
                    ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(
                          5,
                          (index) => ListTile(
                                title: itemDetailButtonsList[index]
                                    .text
                                    .color(darkFontGrey)
                                    .make(),
                                trailing: const Icon(Icons.arrow_forward),
                              )),
                    ),
                    productsyoumaylike.text.size(16).color(darkFontGrey).make(),
                    10.heightBox,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            6,
                            (index) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      imgP1,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                                    10.heightBox,
                                    "Laptop 4G/64GB"
                                        .text
                                        .color(darkFontGrey)
                                        .make(),
                                    10.heightBox,
                                    "\$600".text.color(Vx.blue700).size(16).make()
                                  ],
                                )
                                    .box
                                    .white
                                    .margin(
                                        const EdgeInsets.symmetric(horizontal: 4))
                                    .roundedSM
                                    .padding(const EdgeInsets.all(8))
                                    .make()),
                      ),
                    ),
                  ],
                ),
              ),
            )),
            SizedBox(
              width: 200,
              height: 50,
              child: ourButton(
                  color: const Color.fromARGB(255, 73, 13, 133),
                  onPress: () {
                    controller.addToCard(
                      context:context,
                      vendorID: data['vendor_id'],
                      img: data['p_imgs'][0],
                      qty:controller.quantity.value,
                      sellername:data['p_seller'],
                      title: data['p_name'],
                      tprice: controller.totalPrice.value
                    );
                    VxToast.show(context, msg: "Đã thêm vào giỏ hàng");
                  },
                  textColor: Vx.purple800,
                  title: "Thêm vào giỏ hàng"),
            )
          ],
        ),
      ),
    );
  }
}
