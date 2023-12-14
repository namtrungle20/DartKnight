import 'package:app_xemay/controllers/product_controller.dart';
import 'package:app_xemay/services/firestore_services.dart';
import 'package:app_xemay/views/category_screen/item_details.dart';
import 'package:app_xemay/consts/consts.dart';
import 'package:app_xemay/widget_common/bg_widget.dart';
import 'package:app_xemay/widget_common/loading_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class CategoryDetails extends StatelessWidget {
  final String? title;
  const CategoryDetails({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();

    return bgWidget(
        child: Scaffold(
            appBar: AppBar(
              title: title!.text.white.make(),
            ),
            body: StreamBuilder(
                stream: FirestoreServices.getProducts(title),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: loadingIndicator(),
                    );
                  } else if (snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: "Không Thấy Sản Phẩm!"
                          .text
                          .color(darkFontGrey)
                          .make(),
                    );
                  } else {
                    var data = snapshot.data!.docs;

                    return Container(
                      padding: const EdgeInsets.all(12),
                      child: Column(children: [
                        SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                                controller.subcat.length,
                                (index) => "${controller.subcat[index]}"
                                    .text
                                    .size(15)
                                    .color(darkFontGrey)
                                    .makeCentered()
                                    .box
                                    .white
                                    .roundedSM
                                    .size(120, 60)
                                    .margin(const EdgeInsets.symmetric(
                                        horizontal: 4))
                                    .make()
                                    ),
                          ),
                        ),
                        10.heightBox,
                        Expanded(
                            child: GridView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: data.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisExtent: 250,
                                        mainAxisSpacing: 8,
                                        crossAxisSpacing: 8),
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.network(
                                        data[index]['p_imgs'][0],
                                        height: 121,
                                        width: 150,
                                        fit: BoxFit.cover,
                                      ),
                                      10.heightBox,
                                      "${data[index]['p_name']}"
                                          .text
                                          .color(darkFontGrey)
                                          .make(),
                                      10.heightBox,
                                      "${data[index]['p_price']}"
                                          .numCurrency
                                          .text
                                          .color(Vx.blue700)
                                          .size(16)
                                          .make()
                                    ],
                                  )
                                      .box
                                      .white
                                      .margin(const EdgeInsets.symmetric(
                                          horizontal: 4))
                                      .roundedSM
                                      .outerShadowSm
                                      .padding(const EdgeInsets.all(8))
                                      .make()
                                      .onTap(() {
                                        controller.checkIfFav(data[index]);
                                    Get.to(
                                      () => ItemDetails(
                                          title: "${data[index]['p_name']}",
                                          data: data[index]),
                                    );
                                  });
                                }))
                      ]),
                    );
                  }
                })));
  }
}
