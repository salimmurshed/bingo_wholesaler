import '/const/all_const.dart';
import '/presentation/widgets/cards/shadow_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../app/locator.dart';
import '../../../data_models/models/logged_user_model/logged_user_model.dart';
import '../../../services/auth_service/auth_service.dart';

class AllLoggedUserSheet extends StatelessWidget {
  AllLoggedUserSheet({super.key});

  final _authServ = locator<AuthService>();

  List<LoggedUserModel> get allLoggedUser => _authServ.allLoggedUser.value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0.hp,
      color: AppColors.background,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (int i = 0; i < allLoggedUser.length; i++)
              GestureDetector(
                onTap: () {
                  Navigator.pop(context, allLoggedUser[i].email);
                },
                child: ShadowCard(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ShadowCard(
                            child: SizedBox(
                              height: 70.0,
                              width: 70.0,
                              child: CachedNetworkImage(
                                imageUrl: allLoggedUser[i].profileImage!,
                                fit: BoxFit.fitHeight,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                          10.0.giveWidth,
                          Text(
                            "${allLoggedUser[i].firstName!} ${allLoggedUser[i].lastName!}",
                            style: AppTextStyles.headerText,
                          ),
                        ],
                      ),
                      IconButton(
                          onPressed: () async {
                            // await _authServ
                            //     .removeUser(allLoggedUser[i].uniqueId!);
                            // _nav.pop();
                            // _nav.displayBottomSheet(AllLoggedUserSheet());
                          },
                          icon: const Icon(Icons.close_sharp))
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
