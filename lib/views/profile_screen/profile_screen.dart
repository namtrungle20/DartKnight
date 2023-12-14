import 'package:app_xemay/consts/consts.dart';
import 'package:app_xemay/consts/lists.dart';
import 'package:app_xemay/controllers/auth_controller.dart';
import 'package:app_xemay/controllers/profile_controller.dart';
import 'package:app_xemay/services/firestore_services.dart';
import 'package:app_xemay/views/auth_screen/login_screen.dart';
import 'package:app_xemay/views/order_screen/order_screen.dart';
import 'package:app_xemay/views/profile_screen/components/details_card.dart';
import 'package:app_xemay/views/profile_screen/edit_profile_screen.dart';
import 'package:app_xemay/views/wishlist_screen/wishlist_screen.dart';
import 'package:app_xemay/widget_common/bg_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var controller=Get.put(ProfileController());

    return bgWidget(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirestoreServices.getUser(currentUser!.uid),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
                );
            }
            else{
              var data=snapshot.data!.docs[0];
              return SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: const Align(alignment: Alignment.topRight,child: Icon(Icons.edit, color: whiteColor)).onTap(() { 

                  controller.nameController.text=data['name'];
                  
                  Get.to(()=> EditProfileScreen(data: data));
                }),
              ),
          
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:7.5),
                child: Row(
                  children:[
                  data['imageUrl']==''
                ?Image.asset(imgProfile2, width: 100, fit: BoxFit.cover).box.roundedFull.clip(Clip.antiAlias).make()
                :Image.network(data['imageUrl'], width: 100, fit: BoxFit.cover).box.roundedFull.clip(Clip.antiAlias).make(),
                Expanded(
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "${data['name']}".text.size(20).white.make(), 
                    5.heightBox,
                    "${data['email']}".text.white.make(),
                  ],
                )),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: whiteColor,
                    )
                  ),
                  onPressed: ()async{
                    await Get.put(AuthController()).signoutMethod(context);
                    Get.offAll(()=> const LoginScreen());
                  }, 
                child: logout.text.white.make(),
                )
                  ],
                ),
              ),
          20.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              detailsCard(count: data['cart_count'], title: "Ví Của Tôi", width: context.screenWidth/3.4),
              detailsCard(count: data['wishlist_count'], title: "Danh Sách", width: context.screenWidth/3.4),
              detailsCard(count: data['order_count'], title: "Hàng Đặt", width: context.screenWidth/3.4),
            ],
          ),
          
          ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (context, index){
              return const Divider(
                color: lightGrey
              );
            },
            itemCount: profileButtonsList.length,
            itemBuilder: (BuildContext context, int index){
              return ListTile(
                onTap: (){
                  switch(index){
                    case 0:
                    Get.to(()=>const OrderScreen());
                     break;
                     case 1: Get.to(()=> const WishlistScreen());
                     break;
                     default:

                  }
                },
                leading: Image.asset(profileButtonsIcon[index],
                width: 20,
                ),
                title: profileButtonsList[index].text.color(darkFontGrey).make(),
              );
            }
          
          ).box.white.rounded.margin(const EdgeInsets.all(12)).padding(const EdgeInsets.symmetric(horizontal: 16)).shadowSm.make().box.color(redColor).make()
          ],
          ));
            }
           
          }
          )
      ),
    );
  }
}