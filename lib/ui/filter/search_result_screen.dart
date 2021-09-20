import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shala_yoga/base/utils/toast_utils.dart';
import 'package:shala_yoga/blocs/filter/post_filter/post_filter_bloc.dart';
import '../../base/utils/constants/color_constant.dart';
import '../../base/utils/constants/textstyle_constants.dart';
import '../../base/utils/localization/app_localizations.dart';
import '../classes_widgets/classes_recommendation_widgets.dart';


class SearchResult extends StatefulWidget {
  const SearchResult({Key? key}) : super(key: key);

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult>
    with SingleTickerProviderStateMixin {

  TabController? _tabController;
  int? counter;

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
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
          "Search Result",
          style: TextStyles.L2075,
        ),
      ),
      body: BlocListener<PostFilterBloc, PostFilterState>(
        listener: (context, state) {
          if(state is PostFilterLoading){
            EasyLoading.show();
          }if(state is PostFilterFailure){
            EasyLoading.dismiss();
            ToastUtils.showFailed(message: state.message);
          } if(state is PostFilterSuccess){
            EasyLoading.dismiss();
            ToastUtils.showSuccess(message: state.message);
          }
        },
        child: Column(
          children: [
            Text(''),
          ],
        ),
      ),
    );
  }
}
