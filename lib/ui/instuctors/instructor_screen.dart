import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shala_yoga/base/utils/constants/color_constant.dart';
import 'package:shala_yoga/base/utils/constants/string_res.dart';
import 'package:shala_yoga/base/utils/constants/textstyle_constants.dart';
import 'package:shala_yoga/blocs/instructor_bloc/instructor_bloc.dart';
import 'package:shala_yoga/models/instructor_models.dart';
import 'package:shala_yoga/ui/widgets/failure_widget.dart';
import 'package:shala_yoga/ui/widgets/loading_widget.dart';

class InstructorScreen extends StatefulWidget {
  const InstructorScreen({Key? key}) : super(key: key);

  @override
  _InstructorScreenState createState() => _InstructorScreenState();
}

class _InstructorScreenState extends State<InstructorScreen> {

  @override
  void initState() {
    context.read<InstructorBloc>().add(GetInstructorScreen());
    super.initState();
}

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InstructorBloc, InstructorState>(
      builder: (context, state) {
        if (state is InstructorFailure) {
          return FailureWidget(message: state.message);
        }
        if (state is InstructorSuccess) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                toolbarHeight: 80,
                backgroundColor: ColorRes.appBarColor,
                title: Center(
                    child: Text(StringRes.instructor, style: TextStyles.L2075)),
              ),
              body: Container(
                margin: EdgeInsetsDirectional.only(start: 20, top:  34, end: 20),
                child: ListView.separated(
                  itemCount: state.instructorModel.content!.instructors.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      color: ColorRes.appBarColor,
                      padding: EdgeInsetsDirectional.only(
                          start: 10, end: 10, top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(radius: 25),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                                start: 20),

                            child: RichText(
                              text: TextSpan(
                                text: '${state.instructorModel.content!
                                    .instructors[index].firstname}' + ' ${state
                                    .instructorModel.content!
                                    .instructors[index].lastname}\n',
                                style: TextStyles.SB1578,
                                children: [
                                  TextSpan(
                                      text: '${state.instructorModel.content!
                                      .instructors[index].style}',
                                      style: TextStyles.R1375)
                                ],
                              ),
                            ),
                          ),
                               Spacer(),
                               Icon(Icons.mic),
                                ListView.builder(shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.instructorModel.content!
                                      .instructors[index].languages.length,
                                  itemBuilder: (BuildContext context, int
                                  index) { return Padding(
                                    padding: const EdgeInsetsDirectional.only(end: 5),
                                    child: CircleAvatar(
                                      backgroundColor: ColorRes.lightGrey,
                                      radius: 12,
                                      child: Text('${state.instructorModel.content!
                                          .instructors[index].languages[index]
                                          .substring(0,2)}',
                                          style: TextStyles.R10FF),
                                    ),
                                  );},
                                ),
                          ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 16);
                  },
                ),
              ),
            ),
          );
        }
        return LoadingWidget();
      },
    );
  }
}
