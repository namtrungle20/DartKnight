import 'package:app_xemay/consts/consts.dart';

class HomeController extends GetxController {
  @override
  void onInit(){
    getUsername();
    super.onInit();
  }

  var currentNavIndex = 0.obs;
  var username = '';
  var SearchController=TextEditingController();

  getUsername() async {
    var n = await firestore
        .collection(usersCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['name'];
      }
    });
    username=n;
  }
}
