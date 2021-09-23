import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shala_yoga/base/utils/constants/color_constant.dart';
import 'package:shala_yoga/base/utils/constants/textstyle_constants.dart';
import 'package:shala_yoga/base/utils/localization/app_localizations.dart';
import 'package:shala_yoga/blocs/faq/faq_bloc.dart';
import 'package:shala_yoga/ui/setting/support/support_model.dart';
import 'package:shala_yoga/ui/widgets/custom_button.dart';
import 'package:shala_yoga/ui/widgets/failure_widget.dart';
import 'package:shala_yoga/ui/widgets/loading_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  _SupportScreenState createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  String contactUs = "";
  String whatsApp = "";

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      context.read<FaqBloc>().add(GetAllFaq());
    });
  }

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
        body: BlocBuilder<FaqBloc, FaqState>(
          builder: (context, state) {
            if (state is FaqSuccess) {
              contactUs = state.faqModel.contact!.supportcontact!;
              whatsApp = state.faqModel.contact!.whatsappcontact!;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                          start: 20, end: 20, top: 28, bottom: 34),
                      child: Text(
                          AppLocalizations.of(context)!
                              .translate('dear_yoga_creative_faq'),
                          style: TextStyles.R1875),
                    ),
                    ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.faqModel.content!.length,
                        itemBuilder: (c, index) {
                          return Padding(
                            padding:
                                EdgeInsetsDirectional.only(start: 20, end: 20),
                            child: Column(
                              children: [
                                SizedBox(height: 30),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: ColorRes.appBarColor,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.only(
                                        start: 25, top: 12, bottom: 14),
                                    child: Text(
                                        state.faqModel.content![index].title!,
                                        style: TextStyles.SB1578),
                                  ),
                                ),
                                SizedBox(height: 30),
                                ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    itemCount: state.faqModel.content![index]
                                        .questionAnswer!.length,
                                    itemBuilder: (c, i) {
                                      return SupportModel(
                                        question: state.faqModel.content![index]
                                            .questionAnswer![i].question!,
                                        answer: state.faqModel.content![index]
                                            .questionAnswer![i].answer!,
                                      );
                                    }),
                              ],
                            ),
                          );
                        }),
                    const SizedBox(
                      height: 30,
                    )
                  ],
                ),
              );
            }
            if (state is FaqFailure) {
              return FailureWidget(message: state.message);
            }
            return LoadingWidget();
          },
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          child: Padding(
            padding: EdgeInsetsDirectional.only(
                top: 30, bottom: 30, start: 27, end: 27),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                    onTap: () async {
                      var phoneUrl = 'tel:$contactUs';
                      print(await canLaunch(phoneUrl));
                      if(await canLaunch(phoneUrl)){
                        await launch(phoneUrl);
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                              Text(AppLocalizations.of(context)!.translate(
                                  "phone_couldnt_be_launch"))
                          ),
                        );
                      }
                      /*await canLaunch(phoneUrl)
                          ? await launch(phoneUrl):
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                            Text(AppLocalizations.of(context)!.translate(
                                "phone_couldnt_be_launch"))
                        ),
                      );*/
                    },
                    buttonText:
                        AppLocalizations.of(context)!.translate('contact_us'),
                    backgroundColor: ColorRes.white,
                    foregroundColor: ColorRes.white,
                    height: 52,
                    widthPercent: 0.40,
                    borderColor: ColorRes.primaryColor,
                    textStyle: TextStyles.R1778),
                SizedBox(width: 10),
                CustomButton(
                    onTap: () async {
                      var whatsappUrl = "whatsapp://send?phone=$whatsApp";
                      if(await canLaunch(whatsappUrl)) {
                        launch(whatsappUrl);
                      }
                      else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(AppLocalizations.of(context)!
                                .translate("whatsapp_couldnt_be_launch"))));
                      }
                      },
                    buttonText:
                        AppLocalizations.of(context)!.translate('whats_app'),
                    backgroundColor: ColorRes.primaryColor,
                    foregroundColor: ColorRes.white,
                    height: 52,
                    widthPercent: 0.40,
                    borderColor: ColorRes.primaryColor,
                    textStyle: TextStyles.R17FF),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
