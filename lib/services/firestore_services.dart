import 'package:app_xemay/consts/consts.dart';
import 'package:app_xemay/controllers/product_controller.dart';

class FirestoreServices {
  static getUser(uid) {
    return firestore
        .collection(usersCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  static getProducts(category) {
    return firestore
        .collection(productsController)
        .where('p_category', isEqualTo: category)
        .snapshots();
  }

  static getCart(uid) {
    return firestore
        .collection(carCollection)
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }

  static deleteDocument(docId) {
    return firestore.collection(carCollection).doc(docId).delete();
  }

  static getAllOrders() {
    return firestore
        .collection(ordersCollection)
        .where('order_by', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getWishlists() {
    return firestore
        .collection(productsController)
        .where('p_wishlist', arrayContains: currentUser!.uid)
        .snapshots();
  }
  static allproducts(){
    return firestore.collection(productsController).snapshots();
  }
  static getFeaturedProducts(){
    return firestore.collection(productsController).where('is_featured',isEqualTo: true).get();
  }
  static searchProducts(title){
    return firestore.collection(productsController).get();
  }
}
