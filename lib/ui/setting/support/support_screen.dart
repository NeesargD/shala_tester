import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shala_yoga/base/utils/constants/color_constant.dart';
import 'package:shala_yoga/base/utils/constants/textstyle_constants.dart';
import 'package:shala_yoga/base/utils/enum_utils.dart';
import 'package:shala_yoga/base/utils/localization/app_localizations.dart';
import 'package:shala_yoga/ui/setting/support/support_model.dart';
import 'package:shala_yoga/ui/widgets/custom_button.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  _SupportScreenState createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorRes.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ColorRes.appBarColor,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: ColorRes.greyText,
            ),
          ),
          centerTitle: true,
          title: Text(
           AppLocalizations.of(context)!.translate('support'),
            style: TextStyles.L2075,
          ),
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsetsDirectional.only(start: 20, end: 20, top: 28),
          children: [
            Text(
                AppLocalizations.of(context)!.translate('dear_yoga_creative_faq'),
                style: TextStyles.R1875),
            SizedBox(height: 30),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: ColorRes.appBarColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Padding(
                padding:
                    EdgeInsetsDirectional.only(start: 25, top: 12, bottom: 14),
                child: Text(AppLocalizations.of(context)!.translate("most_frequently_asked"), style: TextStyles
                    .SB1578),
              ),
            ),
            SizedBox(height: 30),
            SupportModel(
                supportQuestion: 'What is pro ' '(Sliver and Gold)?'),
            SizedBox(height: 30),
            SupportModel(
                supportQuestion:
                    'How to cancel the Pro subscription/free trial?'),
            SizedBox(height: 30),
            SupportModel(supportQuestion: 'What is pro (Sliver and Gold)?'),
            SizedBox(height: 30),
            SupportModel(
                supportQuestion:
                    'Why I can’t load/open the videos/ audios successfully?'),
            SizedBox(height: 33),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: ColorRes.appBarColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Padding(
                padding:
                    EdgeInsetsDirectional.only(start: 25, top: 12, bottom: 14),
                child: Text(AppLocalizations.of(context)!.translate("app_support"), style: TextStyles
                    .SB1578),
              ),
            ),
            SizedBox(height: 33),
            SupportModel(supportQuestion: 'App Support'),
            SizedBox(height: 30),
            SupportModel(supportQuestion: 'Account & Profile settings'),
            SizedBox(height: 30),
            SupportModel(
                supportQuestion: 'Subscriptions & Billing  and refunds'),
            SizedBox(height: 18),
          ],
        ),
        bottomNavigationBar: BottomAppBar(elevation: 0,
          child: Padding(
            padding: EdgeInsetsDirectional.only(
                top: 30, bottom: 30, start: 25, end: 25),
            child: Row(
              children: [
                SizedBox(width: 5),
                Expanded(
                  flex: 1,
                  child: CustomButton(
                      onTap: () {},
                      buttonText: AppLocalizations.of(context)!.translate('contact_us'),
                      backgroundColor: ColorRes.white,
                      foregroundColor: ColorRes.white,
                      height: 52,
                      widthPercent: 0.4,
                      borderColor: ColorRes.primaryColor,
                      textStyle: TextStyles.R1778),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: CustomButton(
                      onTap: () {},
                      buttonText: AppLocalizations.of(context)!.translate('whats_app'),
                      backgroundColor: ColorRes.primaryColor,
                      foregroundColor: ColorRes.white,
                      height: 52,
                      widthPercent: 0.4,
                      borderColor: ColorRes.primaryColor,
                      textStyle: TextStyles.R17FF),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
