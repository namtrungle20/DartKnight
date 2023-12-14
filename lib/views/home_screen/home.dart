import 'dart:io';

import 'package:app_xemay/views/cart_screen/cart_screen.dart';
import 'package:app_xemay/views/category_screen/category_screen.dart';
import 'package:app_xemay/consts/consts.dart';
import 'package:app_xemay/views/profile_screen/profile_screen.dart';
import 'package:app_xemay/views/home_screen/home_screen.dart';
import 'package:app_xemay/widget_common/exit_dialog.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    var navbarItem = [
      BottomNavigationBarItem(
          icon: Image.asset(
            icHome,
            width: 26,
          ),
          label: home),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCategories,
            width: 26,
          ),
          label: category),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCart,
            width: 26,
          ),
          label: cart),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProfile,
            width: 26,
          ),
          label: account),
    ];

    var navBody = [
      const HomeScreen(),
      const CategoryScreen(),
      const CartScreen(),
      const ProfileScreen(),
    ];

    return WillPopScope(
      onWillPop: ()async{
        showDialog(
          barrierDismissible: false,
          context: context, 
          builder: (context)=>exitDialog(context));
        return false;
      },
      child: Scaffold(
        body:
            Obx(() =>  Expanded(child: navBody.elementAt(controller.currentNavIndex.value))),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            selectedItemColor: const Color.fromARGB(255, 142, 47, 214),
            type: BottomNavigationBarType.fixed,
            backgroundColor: whiteColor,
            items: navbarItem,
            onTap: (value) {
              controller.currentNavIndex.value = value;
            },
          ),
        ),
      ),
    );
  }
}
