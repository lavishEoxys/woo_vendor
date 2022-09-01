import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woo_vendor/ui/widgets/custom_container.dart';

import '../../resources/theme/theme.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_button.dart';
import 'app_routes/app_routes.dart';

class FoodLicenceScreen extends StatefulWidget {
  const FoodLicenceScreen({Key? key}) : super(key: key);

  @override
  State<FoodLicenceScreen> createState() => _FoodLicenceScreenState();
}

class _FoodLicenceScreenState extends State<FoodLicenceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(MediaQuery.of(context).size.height * .11),
            child:  CustomAppbar(
              data: 'Food Licence',
              leading: InkWell(
                  onTap: ()=> Get.toNamed(MyRoutes.profileScreen),
                  child: Icon(Icons.arrow_back_ios)),
            )),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Stack(children: [
                    CustomContainer(
                        child: Image.asset("assets/images/add.png")),
                    Positioned(
                        top: 10,
                        right: 10,
                        child: Image.asset("assets/images/edit.png"))
                  ]),
                  const SizedBox(
                    height: 150,
                  ),
                  CustomButton(
                    height: 40,
                    width: 120,
                    buttonText: "Submit",
                    buttonTextColor: AppTheme.whiteColor,
                    primaryColor: AppTheme.orangeColor,
                    onPress: ()=> Get.toNamed(MyRoutes.profileScreen),)
                ],
              )),
        ));
  }
}
