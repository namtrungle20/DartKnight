import 'package:app_xemay/controllers/product_controller.dart';
import 'package:app_xemay/views/category_screen/category_details.dart';
import 'package:app_xemay/consts/consts.dart';
import 'package:app_xemay/consts/lists.dart';
import 'package:app_xemay/widget_common/bg_widget.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller= Get.put(ProductController());

    return bgWidget(
        child: Scaffold(
      appBar: AppBar(
        title: category.text.white.make(),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
            shrinkWrap: true,
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                mainAxisExtent: 200),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Image.asset(categoryImages[index],
                  height: 120,
                  width: 200,
                  fit: BoxFit.cover,
                  ),
                  10.heightBox,
                  categoryList[index].text.color(darkFontGrey).align(TextAlign.center).make()
                ],
              ).box.white.roundedSM.clip(Clip.antiAlias).outerShadowSm.make().onTap(() {
                controller.getSubCategory(categoryList[index]);
                Get.to(()=> CategoryDetails(title: categoryList[index]));
              });
            }),
      ),
    ));
  }
}
