import 'package:app_xemay/consts/consts.dart';
import 'package:app_xemay/models/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class ProductController extends GetxController {
  var quantity = 0.obs;
  var totalPrice = 0.obs;
  var subcat = [];
  var isFav=false.obs;

  getSubCategory(title) async {
    subcat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decoded = categoryModelFromJson(data);
    var s = decoded.category.where((element) => element.name == title).toList();

    for (var e in s[0].subcategory) {
      subcat.add(e);
    }
  }

  increaseQuantity(totalQuantity) {
    if (quantity.value < totalQuantity) {
      quantity.value++;
    }
  }

  decreaseQuantity() {
    if (quantity.value > 0) {
      quantity.value--;
    }
  }

  calculateTotalPrice(price) {
    totalPrice.value = price * quantity.value;
  }

  addToCard({title, img, sellername, qty, tprice, context, vendorID}) async {
    await firestore.collection(carCollection).doc().set({
      'title': title,
      'img': img,
      'sellername': sellername,
      'qty': qty,
      'vendor_id':vendorID,
      'tprice': tprice,
      'added_by': currentUser!.uid
    }).catchError((error) {
      VxToast.show(context, msg: error.toString());
    });
  }
  resetValues(){
    totalPrice.value=0;
    quantity.value=0;
  }
  addToWishlish(docId, context)async{
    await firestore.collection(productsController).doc(docId).set({
      'p_wishlist':FieldValue.arrayUnion([currentUser!.uid])
    },SetOptions(merge: true));
    isFav(true);
    VxToast.show(context, msg: "Đã Thêm Vào");
  }
  removeFromWishlish(docId, context)async{
    await firestore.collection(productsController).doc(docId).set({
      'p_wishlist': FieldValue.arrayRemove([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(false);
    VxToast.show(context, msg: "Đã Hủy Thêm");
  }
  checkIfFav(data)async{
    if(data['p_wishlist'].contains(currentUser!.uid)){
      isFav(true);
    }else{
      isFav(false);
    }
  }
}
