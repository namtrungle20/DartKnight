import 'package:app_xemay/consts/consts.dart';
import 'package:app_xemay/consts/lists.dart';
import 'package:app_xemay/services/firestore_services.dart';
import 'package:app_xemay/views/category_screen/item_details.dart';
import 'package:app_xemay/views/home_screen/components/featured_button.dart';
import 'package:app_xemay/views/home_screen/search_screen.dart';
import 'package:app_xemay/widget_common/home_buttons.dart';
import 'package:app_xemay/widget_common/loading_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller=Get.find<HomeController>();
    return Container(
      padding: const EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
          child: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            height: 100,
            color: lightGrey,
            child: TextFormField(
              controller: controller.SearchController,
              decoration:  InputDecoration(
                border: InputBorder.none,
                suffixIcon: Icon(Icons.search).onTap(() {
                  if(controller.SearchController.text.isNotEmptyAndNotNull){
                    Get.to(()=> SearchScreen(
                    title: controller.SearchController.text
                    ));
                  }
                 }),
                filled: true,
                fillColor: whiteColor,
                hintText: searchanything,
                hintStyle: TextStyle(color: textfieldGrey),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 170,
                      enlargeCenterPage: true,
                      itemCount: slidesList.length,
                      itemBuilder: (context, index) {
                        return Container(
                            child: Image.asset(
                          slidesList[index],
                          fit: BoxFit.fill,
                        )
                                .box
                                .rounded
                                .clip(Clip.antiAlias)
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 2))
                                .make());
                      }),
                  20.heightBox,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: featuredCategories.text
                        .color(darkFontGrey)
                        .size(20)
                        .make(),
                  ),
                  20.heightBox,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                          2,
                          (index) => Column(
                                children: [
                                  featuredButton(title: featuredTitle1[index]),
                                  10.heightBox,
                                  featuredButton(title: featuredTitle2[index]),
                                ],
                              )).toList(),
                    ),
                  ),
                  20.heightBox,
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: double.infinity,
                    decoration: const BoxDecoration(color: Vx.blue600),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        featuredProduct.text.white.size(18).make(),
                        10.heightBox,
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: FutureBuilder(
                              future: FirestoreServices.getFeaturedProducts(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: loadingIndicator(),
                                  );
                                } else if (snapshot.data!.docs.isEmpty) {
                                  return "Không có sản phẩm đặc trưng"
                                      .text
                                      .white
                                      .makeCentered();
                                } else {
                                  var featuredData = snapshot.data!.docs;
                                  return Row(
                                    children: List.generate(
                                        featuredData.length,
                                        (index) => Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Image.network(
                                                  featuredData[index]['p_imgs']
                                                      [0],
                                                  width: 150,
                                                  fit: BoxFit.cover,
                                                ),
                                                10.heightBox,
                                                "${featuredData[index]['p_name']}"
                                                    .text
                                                    .color(darkFontGrey)
                                                    .make(),
                                                10.heightBox,
                                                "${featuredData[index]['p_price']}"
                                                    .numCurrency
                                                    .text
                                                    .color(Vx.blue700)
                                                    .size(16)
                                                    .make()
                                              ],
                                            )
                                                .box
                                                .white
                                                .margin(
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4))
                                                .roundedSM
                                                .padding(
                                                    const EdgeInsets.all(8))
                                                .make()
                                                .onTap(() {
                                                  Get.to(() => ItemDetails(
                                      title:
                                          "${featuredData[index]['p_name']}",
                                      data: featuredData[index]));
                                                })),
                                  );
                                }
                              }),
                        )
                      ],
                    ),
                  ),
                  20.heightBox,
                  VxSwiper.builder(
                      aspectRatio: 12 / 1,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: secondSlidesList.length,
                      itemBuilder: (context, index) {
                        return Container(
                            child: Image.asset(
                          secondSlidesList[index],
                          fit: BoxFit.fill,
                        )
                                .box
                                .rounded
                                .clip(Clip.antiAlias)
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 8))
                                .make());
                      }),
                  20.heightBox,
                  StreamBuilder(
                      stream: FirestoreServices.allproducts(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return loadingIndicator();
                        } else {
                          var allproductsdata = snapshot.data!.docs;
                          return GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: allproductsdata.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 8,
                                      crossAxisSpacing: 8,
                                      mainAxisExtent: 300),
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      allproductsdata[index]['p_imgs'][0],
                                      width: 200,
                                      fit: BoxFit.cover,
                                    ),
                                    const Spacer(),
                                    "${allproductsdata[index]['p_name']}"
                                        .text
                                        .color(darkFontGrey)
                                        .make(),
                                    10.heightBox,
                                    "${allproductsdata[index]['p_price']}"
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
                                    .padding(const EdgeInsets.all(8))
                                    .make()
                                    .onTap(() {
                                  Get.to(() => ItemDetails(
                                      title:
                                          "${allproductsdata[index]['p_name']}",
                                      data: allproductsdata[index]));
                                });
                              });
                        }
                      })
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
