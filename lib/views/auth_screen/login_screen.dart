import 'package:app_xemay/consts/consts.dart';
import 'package:app_xemay/consts/lists.dart';
import 'package:app_xemay/controllers/auth_controller.dart';
import 'package:app_xemay/views/auth_screen/signup_screen.dart';
import 'package:app_xemay/views/home_screen/home.dart';
import 'package:app_xemay/widget_common/applogo_widget.dart';
import 'package:app_xemay/widget_common/bg_widget.dart';
import 'package:app_xemay/widget_common/custom_textfield.dart';
import 'package:app_xemay/widget_common/our_button.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(AuthController());

    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              applogoWidget(),
              10.heightBox,
              "Đăng Nhập Vào $appname".text.white.size(20).make(),
              20.heightBox,
              Obx(()=> Column(
                  children: [
                    customTextField(hint: emailHint, title: email, isPass: false, controller: controller.emailController),
                    customTextField(hint: passHint, title: password, isPass: true, controller: controller.passwordController),
                
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(onPressed: (){}, child: forgetPass.text.make())),
                      5.heightBox,
                      //ourButton().box.width(context.screenWidth -50).make(),
                      controller.isLoading.value? 
                      const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Vx.blue700),
                      ): ourButton(color: const Color.fromARGB(255, 158, 29, 181), title: login, textColor: const Color.fromARGB(237, 237, 116, 116),onPress: ()async{
                        controller.isLoading(true);
                        await controller.loginMethod(context: context).then((value){
                          if(value !=null){
                            VxToast.show(context, msg: loggedin);
                            Get.offAll(()=> const Home());
                          }else{
                            controller.isLoading(false);
                          }
                        });
                      })
                      .box
                      .width(context.screenWidth -50)
                      .make(),
                
                      5.heightBox,
                      createNewAccount.text.color(fontGrey).make(),
                      5.heightBox,
                      ourButton(color:lightGolden, title: signup, textColor: const Color.fromARGB(235, 39, 0, 138),onPress: () {
                        Get.to(()=> const SignupScreen());
                      }
                      )
                      .box
                      .width(context.screenWidth -50)
                      .make(),
                
                      10.heightBox,
                      loginWith.text.color(fontGrey).make(),
                
                      5.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(3, (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: lightGrey,
                            radius: 25,
                            child: Image.asset(socialIconList[index],
                            width: 30,
                            ),
                          ),
                        )),
                      ),
                  ],
                ).box.white.rounded.padding(const EdgeInsets.all(16)).width(context.screenWidth - 70).shadowSm.make(),
              ),
            ]),
        ),
      )
    );
  }
}