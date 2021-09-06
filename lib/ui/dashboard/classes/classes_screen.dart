import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shala_yoga/base/utils/constants/string_res.dart';
import 'package:shala_yoga/base/utils/localization/app_localizations.dart';
import 'package:shala_yoga/base/utils/navigation/navigation_route_constants.dart';
import 'package:shala_yoga/base/utils/navigation/navigation_utils.dart';
import 'package:shala_yoga/blocs/classes/classes_bloc/classes_bloc.dart';
import 'package:shala_yoga/ui/classes_widgets/classes_card_widget.dart';
import 'package:shala_yoga/ui/widgets/failure_widget.dart';
import 'package:shala_yoga/ui/widgets/loading_widget.dart';
import '../../../base/extensions/scaffold_extension.dart';
import 'package:shala_yoga/base/utils/constants/color_constant.dart';
import 'package:shala_yoga/base/utils/constants/textstyle_constants.dart';

class ClassesScreen extends StatefulWidget {
  @override
  _ClassesScreenState createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen> {

  @override
  void initState() {
    context.read<ClassesBloc>().add(GetAllClasses());
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ClassesScreen oldWidget) {
    context.read<ClassesBloc>().add(GetAllClasses());

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 80,
        centerTitle: true,
        elevation: 0,
        backgroundColor: ColorRes.appBarColor,
        title: Text(AppLocalizations.of(context)!.translate('classes'), style: TextStyles.L2075),
      ),
      body: BlocBuilder<ClassesBloc, ClassesState>(
        builder: (context, state) {
          if (state is ClassesSuccess) {
            return ListView.separated(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              shrinkWrap: true,
              itemCount: state.classesModel.content!.classes.length,
              separatorBuilder: (context, index) => SizedBox(
                height: 10,
              ),
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsetsDirectional.only(start: 20, end: 20),
                  child: InkWell(
                    onTap: () {
                      NavigationUtils.push(context, routeClassDetailsScreen,
                          arguments: {'id': state.classesModel.content!.classes[index].id});
                    },
                    child: ClassesCardWidget(
                        image: state.classesModel.content!.classes[index].coverImage,
                        day: "TUESDAY",
                        title: state.classesModel.content!.classes[index].title,
                        style: state.classesModel.content!.classes[index].style[0],
                        isLock: state.classesModel.content!.classes[index].isLock,
                        level: state.classesModel.content!.classes[index].level,
                        duration: appState.parseDuration(state.classesModel.content!.classes[index].durations).inMinutes.toString(),
                        language: state.classesModel.content!.classes[index].language),
                  ),
                );
              },
            );
          }

          if (state is ClassesFailure) {
            return FailureWidget(message: state.message);
          }
          return LoadingWidget();
        },
      ),
    );
  }
}
