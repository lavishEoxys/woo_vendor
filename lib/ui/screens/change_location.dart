import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:woo_vendor/ui/widgets/custom_text_field.dart';

import '../../resources/theme/theme.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_button.dart';
import 'app_routes/app_routes.dart';

class ChangeLocationScreen extends StatefulWidget {
  const ChangeLocationScreen({Key? key}) : super(key: key);

  @override
  State<ChangeLocationScreen> createState() => _ChangeLocationScreenState();
}

class _ChangeLocationScreenState extends State<ChangeLocationScreen> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(26.9112472, 75.7296486),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = const CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(26.9112472, 75.7296486),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  final _cityController = TextEditingController();
  final _DistrictController = TextEditingController();
  final _addressController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(MediaQuery.of(context).size.height * .11),
            child:  CustomAppbar(
              data: 'LOGO',
              leading: InkWell(
                  onTap: ()=>Get.toNamed(MyRoutes.restaurantLocationScreen),
                  child: const Icon(Icons.arrow_back_ios)),
            )),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppTheme.whiteColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset:
                                const Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            constraints: BoxConstraints(
                              minWidth: MediaQuery.of(context).size.width,
                              maxWidth: MediaQuery.of(context).size.width,
                              maxHeight: MediaQuery.of(context).size.height * .4,
                              minHeight: MediaQuery.of(context).size.height * .4,
                            ),
                            child: GoogleMap(
                              myLocationEnabled: true,
                              myLocationButtonEnabled: true,
                              mapType: MapType.normal,
                              initialCameraPosition: _kGooglePlex,
                              onMapCreated: (GoogleMapController controller) {
                                _controller.complete(controller);
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "City",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    CustomTextField(
                                      validator: MultiValidator([
                                        RequiredValidator(errorText: 'Enter a city'),
                                        MinLengthValidator(3, errorText: "Minimum length is 3"),
                                      ]),
                                      controller: _cityController,
                                      prefixChildIcon: const Icon(
                                        Icons.location_on_outlined,
                                        color: AppTheme.orangeColor,
                                      ),
                                      hintText: "Select",
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "District",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    CustomTextField(
                                      validator: MultiValidator([
                                        RequiredValidator(errorText: 'Enter a district'),
                                        MinLengthValidator(3, errorText: "Minimum length is 3"),
                                      ]),
                                      controller: _DistrictController,
                                      prefixChildIcon: const Icon(
                                        Icons.location_on_outlined,
                                        color: AppTheme.orangeColor,
                                      ),
                                      hintText: "District",
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Address",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    CustomTextField(
                                      validator: MultiValidator([
                                        RequiredValidator(errorText: 'Enter address'),
                                        MinLengthValidator(3, errorText: "Minimum length is 3"),
                                      ]),
                                      controller: _addressController,
                                      prefixChildIcon: const Icon(
                                        Icons.location_on_outlined,
                                        color: AppTheme.orangeColor,
                                      ),
                                      hintText: "Write here",
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomButton(
                            width: 150,
                            buttonText: "Confirm",
                            primaryColor: AppTheme.orangeColor,
                            buttonTextColor: AppTheme.whiteColor,
                            onPress: () {
                              if (_formKey.currentState!.validate()) {
                                Get.toNamed(MyRoutes.bottomNavBarScreen);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Processing Data')),
                                );
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ));
  }
}
