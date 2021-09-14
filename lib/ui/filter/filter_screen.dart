import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shala_yoga/base/utils/constants/color_constant.dart';
import 'package:shala_yoga/base/utils/constants/textstyle_constants.dart';
import 'package:shala_yoga/base/utils/localization/app_localizations.dart';
import 'package:shala_yoga/base/utils/navigation/navigation_utils.dart';
import 'package:shala_yoga/blocs/filter/get_filter/get_filter_bloc.dart';
import 'package:shala_yoga/models/filter/get_filter.dart';
import 'package:shala_yoga/ui/widgets/custom_button.dart';
import 'package:shala_yoga/ui/widgets/failure_widget.dart';
import 'package:shala_yoga/ui/widgets/filter_selecter.dart';
import 'package:shala_yoga/ui/widgets/loading_widget.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  RangeValues value = const RangeValues(0, 90);
  late GetFilterModel _getFilterModel;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      context.read<GetFilterBloc>().add(GetAllFilter());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorRes.appBarColor,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.clear,
            color: ColorRes.greyText,
          ),
        ),
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.translate('filter'),
          style: TextStyles.L2075,
        ),
      ),
      body: BlocBuilder<GetFilterBloc, GetFilterState>(
        builder: (context, state) {
          if (state is GetFilterFailure) {
            return FailureWidget(message: state.message);
          }
          if (state is GetFilterSuccess) {
            _getFilterModel = state.getFilterModel;
            return SingleChildScrollView(
              child: Container(
                margin: EdgeInsetsDirectional.only(start: 19, end: 14, top: 17),
                color: ColorRes.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: ColorRes.greyIcon),
                          borderRadius: BorderRadius.circular(27),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(start: 25),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: AppLocalizations.of(context)!.translate('start_typing'),
                            hintStyle: TextStyles.R1575,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(AppLocalizations.of(context)!.translate('duration'), style: TextStyles.SB1575),
                    RangeSlider(
                      min: 0,
                      max: 90,
                      values: value,
                      inactiveColor: ColorRes.greyText,
                      activeColor: ColorRes.primaryColor,
                      onChanged: (values) {
                        setState(() {
                          value = values;
                        });
                      },
                    ),
                    SizedBox(height: 42),
                    Text(AppLocalizations.of(context)!.translate("language"), style: TextStyles.SB1575),
                    SizedBox(height: 7),
                    Wrap(
                      runSpacing: 10,
                      spacing: 10,
                      children: state.getFilterModel.content.language
                          .map(
                            (e) => FilterSelected(
                              filterSelector: e.language,
                              isSelected: e.isSelected,
                              onTap: () {
                                e.isSelected = !e.isSelected;
                                setState(() {});
                              },
                            ),
                          )
                          .toList(),
                    ),
                    SizedBox(height: 35),
                    Text(AppLocalizations.of(context)!.translate('level'), style: TextStyles.SB1575),
                    SizedBox(height: 7),
                    Wrap(
                      runSpacing: 10,
                      spacing: 10,
                      children: state.getFilterModel.content.level
                          .map(
                            (e) => FilterSelected(
                              filterSelector: e.level,
                              isSelected: e.isSelected,
                              onTap: () {
                                e.isSelected = !e.isSelected;
                                setState(() {});
                              },
                            ),
                          )
                          .toList(),
                    ),
                    SizedBox(height: 35),
                    Text(AppLocalizations.of(context)!.translate('style'), style: TextStyles.SB1575),
                    SizedBox(height: 7),
                    Wrap(
                      runSpacing: 10,
                      spacing: 10,
                      children: state.getFilterModel.content.style
                          .map(
                            (e) => FilterSelected(
                              filterSelector: e.styleTitle,
                              isSelected: e.isSelected,
                              onTap: () {
                                e.isSelected = !e.isSelected;
                                setState(() {});
                              },
                            ),
                          )
                          .toList(),
                    ),
                    SizedBox(height: 35),
                    Text(AppLocalizations.of(context)!.translate("focus"), style: TextStyles.SB1575),
                    SizedBox(height: 7),
                    Wrap(
                      runSpacing: 10,
                      spacing: 10,
                      children: state.getFilterModel.content.focus
                          .map(
                            (e) => FilterSelected(
                              filterSelector: e.focusTitle,
                              isSelected: e.isSelected,
                              onTap: () {
                                e.isSelected = !e.isSelected;
                                setState(() {});
                              },
                            ),
                          )
                          .toList(),
                    ),
                    SizedBox(height: 35),
                    Text(AppLocalizations.of(context)!.translate('instructor'), style: TextStyles.SB1575),
                    SizedBox(height: 7),
                    Wrap(
                      runSpacing: 10,
                      spacing: 10,
                      children: state.getFilterModel.content.instructor
                          .map(
                            (e) => FilterSelected(
                              filterSelector: e.firstname + ' ' + e.lastname,
                              isSelected: e.isSelected,
                              onTap: () {
                                e.isSelected = !e.isSelected;
                                setState(() {});
                              },
                            ),
                          )
                          .toList(),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            );
          }
          return LoadingWidget();
        },
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Padding(
          padding: EdgeInsetsDirectional.only(top: 30, bottom: 30, start: 25, end: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.only(end: 5),
                child: CustomButton(
                    onTap: () {
                      NavigationUtils.pop(context);
                    },
                    buttonText: AppLocalizations.of(context)!.translate("reset"),
                    backgroundColor: ColorRes.white,
                    foregroundColor: ColorRes.white,
                    height: 52,
                    widthPercent: 0.4,
                    borderColor: ColorRes.primaryColor,
                    textStyle: TextStyles.R1778),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(start: 5),
                child: CustomButton(
                    onTap: () {
                      List<String> languageList = [];
                      _getFilterModel.content.language.forEach((element) {
                        if (element.isSelected) {
                          languageList.add(element.language);
                        }
                      });
                      List<String> levelList = [];
                      _getFilterModel.content.level.forEach((element) {
                        if (element.isSelected) {
                          levelList.add(element.level);
                        }
                      });
                      List<String> styleList = [];
                      _getFilterModel.content.style.forEach((element) {
                        if (element.isSelected) {
                          styleList.add(element.styleTitle);
                        }
                      });
                      List<String> focusList = [];
                      _getFilterModel.content.focus.forEach((element) {
                        if (element.isSelected) {
                          focusList.add(element.focusTitle);
                        }
                      });
                      List<String> instructorList = [];
                      _getFilterModel.content.instructor.forEach((element) {
                        if (element.isSelected) {
                          instructorList.add(element.id.toString());
                        }
                      });
                      print(">>Language>> $languageList");
                      print(">>Level>> $levelList");
                      print(">>Style>> $styleList");
                      print(">>Focus>> $focusList");
                      print(">>Instructor>> $instructorList");
                    },
                    buttonText: AppLocalizations.of(context)!.translate('done'),
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
    );
  }
}
