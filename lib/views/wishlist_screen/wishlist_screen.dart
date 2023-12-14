import 'package:app_xemay/consts/consts.dart';
import 'package:app_xemay/services/firestore_services.dart';
import 'package:app_xemay/widget_common/loading_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: "Danh Sách".text.color(darkFontGrey).make(),
        ),
        body: StreamBuilder(
            stream: FirestoreServices.getWishlists(),
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
                return Column(
                  children: [
                    ListView.builder(
                       shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(children: [
                            Expanded(
                              child: ListView.builder(
                                  itemCount: data.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return ListTile(
                                        leading: Image.network(
                                          '${data[index]['p_imgs'][0]}',
                                          width: 120,
                                          fit: BoxFit.contain,
                                        ),
                                        title: "${data[index]['p_name']}"
                                            .text
                                            .size(16)
                                            .make(),
                                        subtitle: "${data[index]['p_price']}"
                                            .numCurrency
                                            .text
                                            .color(redColor)
                                            .make(),
                                        trailing: const Icon(
                                          Icons.favorite,
                                          color: redColor,
                                        ).onTap(() {}));
                                  }),
                            )
                          ]);
                        }),
                  ],
                );
              }
            }));
  }
}
