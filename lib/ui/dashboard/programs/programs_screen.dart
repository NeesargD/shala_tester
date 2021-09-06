import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shala_yoga/base/utils/constants/string_res.dart';
import 'package:shala_yoga/base/utils/localization/app_localizations.dart';
import 'package:shala_yoga/base/utils/navigation/navigation_route_constants.dart';
import 'package:shala_yoga/base/utils/navigation/navigation_utils.dart';
import 'package:shala_yoga/blocs/programs/programs_bloc/programs_bloc.dart';
import 'package:shala_yoga/ui/classes_widgets/classes_card_widget.dart';
import 'package:shala_yoga/ui/program_widgets/program_grid_recommended.dart';
import 'package:shala_yoga/ui/widgets/failure_widget.dart';
import 'package:shala_yoga/ui/widgets/loading_widget.dart';
import '../../../base/extensions/scaffold_extension.dart';
import 'package:shala_yoga/base/utils/constants/color_constant.dart';
import 'package:shala_yoga/base/utils/constants/textstyle_constants.dart';

class ProgramsScreen extends StatefulWidget {
  @override
  _ProgramsScreenState createState() => _ProgramsScreenState();
}

class _ProgramsScreenState extends State<ProgramsScreen> {
  @override
  void initState() {
    context.read<ProgramsBloc>().add(GetAllPrograms());
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ProgramsScreen oldWidget) {
    context.read<ProgramsBloc>().add(GetAllPrograms());

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
        title: Text(AppLocalizations.of(context)!.translate('programs'), style: TextStyles.L2075),
      ),
      body: BlocBuilder<ProgramsBloc, ProgramsState>(
        builder: (context, state) {
          if(state is ProgramsSuccess){
            return ListView.separated(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              shrinkWrap: true,
              itemCount: state.programsModel.content!.programs.length,
              separatorBuilder: (context, index) =>
                  SizedBox(
                    height: 15,
                  ),
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsetsDirectional.only(start: 20, end: 20),
                  child: InkWell(
                    onTap: () {
                      NavigationUtils.push(context, routeProgramDetailsScreen,
                          arguments: {'id': state.programsModel.content!
                              .programs[index].id});
                    },
                    child: RecommendedProgramList(
                        coverImage: state.programsModel.content!.programs[index].coverImage,
                        languages: state.programsModel.content!.programs[index].languages,
                        title: state.programsModel.content!.programs[index].title,
                        style: state.programsModel.content!.programs[index].style,
                        level: state.programsModel.content!.programs[index].level,
                        width: 0.9,
                        countClass: 5),
                  ),
                );
              },
            );
          }
          if(state is ProgramsFailure){
            return FailureWidget(message: state.message);
          }
          return LoadingWidget();
        },
      ),
    );
  }
}
