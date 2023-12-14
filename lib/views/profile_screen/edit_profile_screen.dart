import 'dart:io';

import 'package:app_xemay/consts/consts.dart';
import 'package:app_xemay/controllers/profile_controller.dart';
import 'package:app_xemay/widget_common/bg_widget.dart';
import 'package:app_xemay/widget_common/custom_textfield.dart';
import 'package:app_xemay/widget_common/our_button.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            data['imageUrl'] == '' && controller.profileImgPath.isEmpty
                ? Image.asset(imgProfile, width: 100, fit: BoxFit.cover)
                    .box
                    .roundedFull
                    .clip(Clip.antiAlias)
                    .make()
                : data['imageUrl'] != '' && controller.profileImgLink.isEmpty
                    ? Image.network(
                        data['imageUrl'],
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make()
                    : Image.file(
                        File(controller.profileImgPath.value),
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make(),
            10.heightBox,
            ourButton(
                color: Colors.orangeAccent,
                onPress: () {
                  controller.changeImage(context);
                },
                textColor: Colors.blue,
                title: "Thay Đổi"),
            const Divider(),
            20.heightBox,
            customTextField(
                controller: controller.nameController,
                hint: nameHint,
                title: name,
                isPass: false
                ),
            10.heightBox,
            customTextField(
                controller: controller.oldpassController,
                hint: passHint,
                title: oldpass,
                isPass: true
                ),
            10.heightBox,
            customTextField(
                controller: controller.newpassController,
                hint: passHint,
                title: newpass,
                isPass: true
                ),
            10.heightBox,
            controller.isloading.value
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  )
                : SizedBox(
                    width: context.screenWidth - 60,
                    child: ourButton(
                        color: redColor,
                        onPress: () async {
                          controller.isloading(true);
                          if (controller.profileImgPath.value.isNotEmpty) {
                            await controller.uploadProfileImage();
                          } else {
                            controller.profileImgLink = data['imageUrl'];
                          }

                          if (data['password'] == controller.oldpassController.text) {
                            await controller.changeAuthPassword(
                              email: data['email'],
                              password: controller.oldpassController.text,
                              newpassword: controller.newpassController.text,
                            );
                            await controller.updateProfile(
                                imgUrl: controller.profileImgLink,
                                name: controller.nameController.text,
                                password: controller.newpassController.text);
                            VxToast.show(context, msg: "Đã Cập Nhập");
                          }else{
                            VxToast.show(context, msg: "Sai Mật Khẩu Cũ");
                            controller.isloading(false);
                          }
                        },
                        textColor: Colors.blue,
                        title: "Lưu"))
          ],
        )
            .box
            .white
            .shadowSm
            .padding(const EdgeInsets.all(12))
            .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
            .rounded
            .make(),
      ),
    ));
  }
}
