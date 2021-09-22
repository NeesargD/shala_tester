import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shala_yoga/base/utils/toast_utils.dart';
import '../../base/utils/constants/color_constant.dart';
import '../../base/utils/constants/textstyle_constants.dart';
import '../../base/utils/localization/app_localizations.dart';
import '../../base/utils/navigation/navigation_route_constants.dart';
import '../../base/utils/navigation/navigation_utils.dart';
import '../../blocs/filter/get_filter/get_filter_bloc.dart';
import '../../models/filter/get_filter.dart';
import '../widgets/custom_button.dart';
import '../widgets/failure_widget.dart';
import '../widgets/filter_selecter.dart';
import '../widgets/loading_widget.dart';

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
                            hintText: AppLocalizations.of(context)!
                                .translate('start_typing'),
                            hintStyle: TextStyles.R1575,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.translate('duration'),
                          style: TextStyles.SB1575,
                        ),
                        Spacer(),
                        Text(
                          '${value.start.round().toString()} - ${value.end.round().toString()} Min',
                          style: TextStyles.SB1575
                              .copyWith(color: ColorRes.primaryColor),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    RangeSlider(
                      min: 0,
                      max: 90,
                      values: value,
                      inactiveColor: ColorRes.greyText.withOpacity(0.5),
                      activeColor: ColorRes.primaryColor,
                      labels: RangeLabels(
                        value.start.round().toString(),
                        value.end.round().toString(),
                      ),
                      onChanged: (values) {
                        setState(() {
                          value = values;
                        });
                      },
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        Text(
                          '0 min',
                          style: TextStyles.R1575.copyWith(
                            color: ColorRes.greyText.withOpacity(0.5),
                          ),
                        ),
                        Spacer(),
                        Text(
                          '90 min',
                          style: TextStyles.R1575.copyWith(
                            color: ColorRes.greyText.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                    const SizedBox(height: 23),
                    Text(AppLocalizations.of(context)!.translate("language"),
                        style: TextStyles.SB1575),
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
                    const SizedBox(height: 35),
                    Text(AppLocalizations.of(context)!.translate('level'),
                        style: TextStyles.SB1575),
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
                    Text(AppLocalizations.of(context)!.translate('style'),
                        style: TextStyles.SB1575),
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
                    Text(AppLocalizations.of(context)!.translate("focus"),
                        style: TextStyles.SB1575),
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
                    Text(AppLocalizations.of(context)!.translate('instructor'),
                        style: TextStyles.SB1575),
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
          padding: EdgeInsetsDirectional.only(
              top: 30, bottom: 30, start: 25, end: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                  onTap: () {
                    _getFilterModel.content.language.forEach((element) {
                      element.isSelected = false;
                    });
                    _getFilterModel.content.level.forEach((element) {
                      element.isSelected = false;
                    });
                    _getFilterModel.content.style.forEach((element) {
                      element.isSelected = false;
                    });
                    _getFilterModel.content.focus.forEach((element) {
                      element.isSelected = false;
                    });
                    _getFilterModel.content.instructor.forEach((element) {
                      element.isSelected = false;
                    });
                    setState(() {});
                  },
                  buttonText: AppLocalizations.of(context)!.translate("reset"),
                  backgroundColor: ColorRes.white,
                  foregroundColor: ColorRes.white,
                  height: 52,
                  widthPercent: 0.4,
                  borderColor: ColorRes.primaryColor,
                  textStyle: TextStyles.R1778),
              CustomButton(
                  onTap: () {
                    List<String> languageList = [];
                    _getFilterModel.content.language.forEach((element) {
                      if (element.isSelected) {
                        languageList.add(element.id.toString());
                      }
                    });
                    List<String> levelList = [];
                    _getFilterModel.content.level.forEach((element) {
                      if (element.isSelected) {
                        levelList.add(element.id.toString());
                      }
                    });
                    List<String> styleList = [];
                    _getFilterModel.content.style.forEach((element) {
                      if (element.isSelected) {
                        styleList.add(element.id.toString());
                      }
                    });
                    List<String> focusList = [];
                    _getFilterModel.content.focus.forEach((element) {
                      if (element.isSelected) {
                        focusList.add(element.id.toString());
                      }
                    });
                    List<String> instructorList = [];
                    _getFilterModel.content.instructor.forEach((element) {
                      if (element.isSelected) {
                        instructorList.add(element.id.toString());
                      }
                    });
                    if (levelList.isEmpty &&
                        languageList.isEmpty &&
                        focusList.isEmpty &&
                        styleList.isEmpty &&
                        instructorList.isEmpty) {
                      ToastUtils.showFailed(
                          message: AppLocalizations.of(context)!
                              .translate("applyFilter"));
                    } else {
                      NavigationUtils.push(context, routeSearchResult,
                          arguments: {
                            "language": languageList,
                            "style": styleList,
                            "focus": focusList,
                            "instructor": instructorList,
                            "level": levelList,
                            'startDuration': value.start.round().toInt(),
                            'endDuration': value.end.round().toInt()
                          });
                    }
                  },
                  buttonText: AppLocalizations.of(context)!.translate('done'),
                  backgroundColor: ColorRes.primaryColor,
                  foregroundColor: ColorRes.white,
                  height: 52,
                  widthPercent: 0.4,
                  borderColor: ColorRes.primaryColor,
                  textStyle: TextStyles.R17FF),
            ],
          ),
        ),
      ),
    );
  }
}
