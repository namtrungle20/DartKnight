import 'package:app_xemay/controllers/product_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore=FirebaseFirestore.instance;
User? currentUser=auth.currentUser;

const usersCollection="users";
const productsController="products";
const carCollection='cart';
const ordersCollection='orders';
