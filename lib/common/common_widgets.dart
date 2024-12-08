import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:miles_sample/generated/assets.dart';
import 'package:miles_sample/theme/color_utils.dart';
import 'package:miles_sample/theme/font_properties.dart';
import 'package:miles_sample/utils/constants.dart';

class CommonWidgets {
  static Widget smallLoader() {
    return Container(
      color: Colors.black87,
      child: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.white),
          strokeWidth: 1,
        ),
      ),
    );
  }

  static Widget goodMorningHomeWidget({required BuildContext context}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Constants.goodMorningUser,
                maxLines: 2,
                style: FontProperties.headLineNormal.copyWith(
                  color: ColorUtils.appTextColor,
                  fontSize: 16,
                ),
              ),
              Text(
                Constants.user,
                maxLines: 2,
                style: FontProperties.headLineNormal.copyWith(
                  color: ColorUtils.appTextColor,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          InkWell(onTap: (){
displaySheet(context: context);
          },
            child: Lottie.asset(
              Assets.gifTalk2us,
              height: 100,
              width: 100,
              errorBuilder: (context, error, stackTrace) {
                print(error);
                print(stackTrace);
                return const SizedBox();
              },
            ),
          )
        ],
      ),
    );
  }

  static SnackBar customToast({required String toastMessage}) {
    return SnackBar(duration: const Duration(seconds: 1),
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey,
            border: Border.all(color: ColorUtils.appTextColor, width: 3),
            boxShadow: const [
              BoxShadow(
                color: Color(0x19000000),
                spreadRadius: 2.0,
                blurRadius: 8.0,
                offset: Offset(2, 4),
              )
            ],
            borderRadius: BorderRadius.circular(4),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(toastMessage,maxLines: 5,
                style: FontProperties.headLineNormal
                    .copyWith(color: ColorUtils.appTextColor)),
          )),
    );
  }
  static void displaySheet({required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container( padding: const EdgeInsets.all(8.0),height: 400,
          color: Colors.black,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [


                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.close,color: ColorUtils.appTextColor,),
                  )
                ],
              ),
               const Divider(color: Colors.white),
              Expanded(
                child: Lottie.asset(Assets.gifTalkToUs,
                ),

              ),
              Text(
                Constants.thankYou,
                maxLines: 2,
                style: FontProperties.headLineNormal.copyWith(fontWeight: FontWeight.w300,
                  color:  "#D5DBE2".toColor(),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        );

      },
    );
  }
}
