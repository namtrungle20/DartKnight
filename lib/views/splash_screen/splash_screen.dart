import 'package:app_xemay/consts/consts.dart';
import 'package:app_xemay/views/auth_screen/login_screen.dart';
import 'package:app_xemay/views/home_screen/home.dart';
import 'package:app_xemay/widget_common/applogo_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


changeScreen(){
  Future.delayed(const Duration(seconds: 3),() {
    //Get.to(() => const LoginScreen());
    auth.authStateChanges().listen((User? user) {
      if(user==null && mounted){
        Get.to(()=> const LoginScreen());
      }else{
        Get.to(()=> const Home());
      }
     });
  });
}

@override
 initState() {
 changeScreen();
 super.initState();
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 227, 83, 17),   
      body: Center(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft, child:Image.asset(icSplashBg,width: 300),),
              20.heightBox,
              applogoWidget(),
              10.heightBox,
              appname.text.size(28).white.make(), 
          ],)
         ),
    );
  }
}
