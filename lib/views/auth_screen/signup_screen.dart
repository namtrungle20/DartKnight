import 'package:app_xemay/consts/consts.dart';
import 'package:app_xemay/controllers/auth_controller.dart';
import 'package:app_xemay/views/home_screen/home.dart';
import 'package:flutter/material.dart';


import '../../widget_common/applogo_widget.dart';
import '../../widget_common/bg_widget.dart';
import '../../widget_common/custom_textfield.dart';
import '../../widget_common/our_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>{
  bool? isCheck= false;
  var controller=Get.put(AuthController());

  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var passwordRetypeController=TextEditingController();

  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              applogoWidget(),
              10.heightBox,
              "Đăng Ký Vào $appname".text.white.size(20).make(),
              20.heightBox,
              Obx(()=> Column(
                  children: [
                    customTextField(hint: nameHint, title: name, controller: nameController, isPass: false),
                    customTextField(hint: emailHint, title: email, controller: emailController, isPass: false),
                    customTextField(hint: passHint, title: password, controller: passwordController, isPass: true),
                    customTextField(hint: passHint, title: retypePassword, controller: passwordRetypeController, isPass: true),
                
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(onPressed: (){}, child: forgetPass.text.make())),
                
                      Row(
                        children: [
                          Checkbox(
                            activeColor: whiteColor,
                            checkColor: Vx.blue400,
                            value: isCheck, 
                            onChanged: (newValue){
                              setState(() {
                                 isCheck=newValue;
                              });
                            },
                          ),
                          10.heightBox,
                          Expanded(
                            child: RichText(text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: "Tôi đồng ý các ", 
                                  style: TextStyle(
                                  color: fontGrey,
                                  )),
                                TextSpan(
                                  text: TermAndCond, 
                                  style: TextStyle(
                                  color: Vx.blue600,
                                )),
                                TextSpan(
                                  text: " & ", 
                                  style: TextStyle(
                                  color: fontGrey,
                                )),
                                TextSpan(
                                  text: privacyPolicy, 
                                  style: TextStyle(
                                  color: Vx.blue600,
                                )),
                              ]
                               )),
                          )
                        ],
                      ),
                      5.heightBox,
                      //ourButton().box.width(context.screenWidth -50).make(),
                      controller.isLoading.value? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Vx.blue700),
                      ):
                      ourButton(color: isCheck == true? redColor : lightGrey,
                       title: signup, textColor: const Color.fromARGB(235, 9, 13, 221),
                       onPress: () async{
                        if(isCheck !=false){
                          controller.isLoading(true);
                          try{
                             controller.signupMethod(
                              context: context, email: emailController.text, password: passwordController.text).then((value){
                                return controller.storeUserData(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text 
                                );
                              }).then((value) {
                                VxToast.show(context, msg: loggedin);
                                Get.offAll(()=>const Home());
                              });
                          }catch(e) {
                            auth.signOut();
                            VxToast.show(context, msg: e.toString());
                            controller.isLoading(false);
                          }
                        }
                       },
                       ).box.width(context.screenWidth -50).make(),

                      10.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                             alreadyHaveAccont.text.color(fontGrey).make(),
                             login.text.color(Vx.blue600).make().onTap(() {
                              Get.back();
                             })
                            ]
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