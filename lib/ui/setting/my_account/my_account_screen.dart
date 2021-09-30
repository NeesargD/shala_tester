import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../../../base/utils/constants/color_constant.dart';
import '../../../base/utils/constants/image_constant.dart';
import 'package:shala_yoga/base/utils/constants/textstyle_constants.dart';
import 'package:shala_yoga/base/utils/localization/app_localizations.dart';
import 'package:shala_yoga/ui/widgets/common_list_tile_widget.dart';
import 'package:shala_yoga/ui/widgets/custom_button.dart';
import 'package:country_picker/country_picker.dart';


class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({Key? key}) : super(key: key);

  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {

  TextEditingController countryController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  String? initialCountry;
  PhoneNumber number = PhoneNumber(isoCode: 'AE');


  void clearText() {
    phoneController.clear();
    emailController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          iconTheme: IconThemeData(color: ColorRes.greyText),
          elevation: 0,
          centerTitle: true,
          title: Text(AppLocalizations.of(context)!.translate('my_account'),
              style: TextStyles.L2075),
          backgroundColor: ColorRes.appBarColor,
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          child: Padding(
            padding: EdgeInsetsDirectional.only(start: 27, end: 27),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CommonListTileWidget(
                    titleText: AppLocalizations.of(context)!
                        .translate("my_subscriptions"),
                    imagePath: ImageRes.my_account_subscription,
                    onTap: () {},
                    itemSpace: 9),
                CommonListTileWidget(
                  titleText:
                      AppLocalizations.of(context)!.translate('reset_password'),
                  imagePath: ImageRes.my_account_reset_password,
                  onTap: () {},
                  itemSpace: 9,
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsDirectional.only(start: 20, end: 20, top: 33),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Opacity(
                  opacity: 0.50,
                  child: Text(
                      AppLocalizations.of(context)!.translate("your_mail"),
                      style: TextStyles.R1675),
                ),
                TextFormField(
                  controller: emailController,
                  style: TextStyles.R1675,
                  decoration: InputDecoration(
                    focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: ColorRes.red)),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorRes.primaryColor),
                    ),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r'^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+')
                            .hasMatch(value)) {
                      return AppLocalizations.of(context)!.translate("enter_a_valid_email");
                    }
                    return null;
                  },
                ),
                SizedBox(height: 37),
                // Opacity(
                //     opacity: 0.50,
                //     child: Text(
                //         AppLocalizations.of(context)!.translate('location'),
                //         style: TextStyles.R1675)),
                // TextFormField(
                //   decoration: InputDecoration(
                //     focusedBorder: UnderlineInputBorder(
                //       borderSide: BorderSide(color: ColorRes.primaryColor),
                //     ),
                //   ),
                //   onTap: (){
                //     showCountryPicker(showPhoneCode: false,
                //         context: context,
                //         onSelect: (Country country) {
                //           countryController.text = country.name;
                //         }
                //         );
                //   },
                //   readOnly: true,
                //   controller: countryController,
                // ),
                Opacity(
                  opacity: 0.50,
                  child: Text(
                      AppLocalizations.of(context)!.translate('phone_number'),
                      style: TextStyles.R1675),
                ),
                InternationalPhoneNumberInput(
                  initialValue: number,
                  onInputChanged: (PhoneNumber number) {
                    print(number.phoneNumber);
                  },searchBoxDecoration: InputDecoration(
                    enabled: false
                ),
                  selectorConfig: SelectorConfig(
                    trailingSpace: false,
                    setSelectorButtonAsPrefixIcon: true,
                  ),
                  inputDecoration: InputDecoration(
                    enabled: false,
                  ),
                  countrySelectorScrollControlled: false,
                  formatInput: true,
                  keyboardType: TextInputType.phone,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 37),
                CustomButton(
                    widthPercent: 1,
                    onTap: () {},
                    buttonText:
                        AppLocalizations.of(context)!.translate('save_changes'),
                    backgroundColor: ColorRes.primaryColor,
                    foregroundColor: Colors.transparent,
                    borderColor: Colors.transparent,
                    textStyle: TextStyles.SB18FF),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}