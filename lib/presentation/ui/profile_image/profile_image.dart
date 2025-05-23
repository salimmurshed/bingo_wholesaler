import 'dart:io';

import '../../../data_models/enums/user_type_for_web.dart';
import '/const/all_const.dart';
import '/const/utils.dart';
import '/data_models/models/user_model/user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app/locator.dart';
import '../../../services/auth_service/auth_service.dart';
import '../../widgets/buttons/submit_button.dart';
import '../../widgets/cards/app_bar_text.dart';

class PickImage extends StatefulWidget {
  const PickImage({super.key});

  @override
  _PickImageState createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  @override
  void initState() {
    super.initState();
  }

  final _authService = locator<AuthService>();
  final ImagePicker _picker = ImagePicker();
  XFile? image;

  UserModel get user => _authService.user.value;

  // bool get isRetailer => _authService.isRetailer.value;
  UserTypeForWeb get enrollment => locator<AuthService>().enrollment.value;

  void picImage() async {
    image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  void deletePickImage() async {
    image = null;
    setState(() {});
  }

  bool isLoading = false;

  void uploadImage() async {
    setState(() {
      isLoading = true;
    });
    await _authService.uploadImage(image!.path);
    setState(() {
      image = null;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: enrollment == UserTypeForWeb.retailer
            ? AppColors.appBarColorRetailer
            : AppColors.appBarColorWholesaler,
        title: AppBarText(
          AppLocalizations.of(context)!.imageLoading.toUpperCase(),
        ),
      ),
      body: SizedBox(
        width: 100.0.wp,
        height: 100.0.hp,
        child: isLoading
            ? Utils.loaderBusy()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 200.0,
                        width: 200.0,
                        decoration: BoxDecoration(
                          color: AppColors.messageColorSuccess,
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        child: Center(
                          child:
                              Text(AppLocalizations.of(context)!.imageLoading),
                        ),
                      ),
                      SizedBox(
                        height: 200.0,
                        width: 200.0,
                        child: image != null
                            ? Stack(
                                children: [
                                  SizedBox(
                                    height: 200.0,
                                    width: 200.0,
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(160.0),
                                      child: Image.file(
                                        File(image!.path),
                                        height: 200.0,
                                        width: 200.0,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 0.0,
                                    top: 0.0,
                                    child: InkWell(
                                      onTap: deletePickImage,
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        margin: const EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(
                                          color: AppColors.loader3,
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                        ),
                                        child: const Icon(
                                          Icons.clear_outlined,
                                          color: AppColors.whiteColor,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : user.data!.profileImage!.isEmpty
                                ? Image.asset(
                                    AppAsset.profileImage,
                                    height: 159.0,
                                    width: 159.0,
                                    fit: BoxFit.cover,
                                  )
                                : SizedBox(
                                    height: 200.0,
                                    width: 200.0,
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(160.0),
                                      child: CachedNetworkImage(
                                        imageUrl: user.data!.profileImage!,
                                        height: 159.0,
                                        width: 159.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                      ),
                    ],
                  ),
                  SubmitButton(
                    onPressed: picImage,
                    color: AppColors.borderColors,
                    active: false,
                    width: 167.0,
                    height: 45.0,
                    text:
                        AppLocalizations.of(context)!.chooseYourProfilePicture,
                  ),
                  image != null
                      ? SubmitButton(
                          onPressed: uploadImage,
                          active: true,
                          width: 167.0,
                          height: 45.0,
                          text: AppLocalizations.of(context)!
                              .uploadProfilePicture,
                        )
                      : const SizedBox(
                          width: 167.0,
                          height: 52.0,
                          child: SizedBox(),
                        )
                ],
              ),
      ),
    );
  }
}
