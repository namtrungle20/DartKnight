import 'package:app_xemay/consts/consts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartController extends GetxController {
  var totalP = 0.obs;
  var addressController=TextEditingController();
  var cityController=TextEditingController();
  var phoneController=TextEditingController();
  var paymentIndex=0.obs;
  late dynamic productSnapShot;
  var products=[];
  var placingOrder=false.obs;

  calculate(data) {
    totalP.value=0;
    for (var i = 0; i < data.length; i++) {
      totalP.value = totalP.value + int.parse(data[i]['tprice'].toString());
    }
  }
  changePaymentIndex(index){
    paymentIndex.value=index;
  }
  placeMyOrder({required orderPaymentMethod,required totalAmount})async{
    placingOrder(true);
    await getProductDetails();
    await firestore.collection(ordersCollection).doc().set({
      'order_code':"1231243441",
      'order_by':currentUser!.uid,
      'order_by_name': Get.find<HomeController>().username,
      'order_by_email':currentUser!.email,
      'order_by_andress':addressController.text,
      'order_by_city':cityController.text,
      'order_by_phone':phoneController.text,
      'shipping_method': "Giao Hàng Tận Nhà",
      'payment_method':orderPaymentMethod,
      'order_place':true,
      'order_confirmed':false,
      'order_delivered':false,
      'order_on_delivered':false,
      'total_amount':totalAmount,
      'orders':FieldValue.arrayUnion(products)
    });
    placingOrder(false);
  }
  getProductDetails(){
    products.clear();
    for (var i=0; i<productSnapShot.length;i++){
      products.add({
        'img':productSnapShot[i]['img'],
        'vendor_id': productSnapShot[i]['vendor_id'],
        'tprice':productSnapShot[i]['tprice'],
        'qty':productSnapShot[i]['qty'],
        'title':productSnapShot[i]['title'],
      });
    }
  }

  clearCart(){
    for(var i=0; i< productSnapShot.length; i++){
      firestore.collection(carCollection).doc(productSnapShot[i].id).delete();
    }
  }
}
