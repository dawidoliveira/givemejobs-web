import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:give_me_jobs_web/app/core/app_responsive.dart';
import 'package:give_me_jobs_web/app/core/app_text_styles.dart';
import 'package:give_me_jobs_web/app/modules/home/home_store.dart';
import 'package:give_me_jobs_web/app/modules/home/widgets/content/widgets/dashboard_item/dashboard_item_widget.dart';
import 'package:shimmer/shimmer.dart';

class ContentWidget extends StatelessWidget {
  const ContentWidget({
    Key? key,
    required this.store,
    required this.scaffoldKey,
  }) : super(key: key);

  final HomeStore store;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dashboard',
                  style: AppTextStyles.title.copyWith(fontSize: 24),
                ),
                const SizedBox(
                  height: 20,
                ),
                Wrap(
                  children: [
                    ScopedBuilder(
                      store: store,
                      onLoading: (context) => SizedBox(
                        width: AppResponsive.isWeb(context)
                            ? MediaQuery.of(context).size.width * .2
                            : MediaQuery.of(context).size.width,
                        height: 160,
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.white,
                          child: Container(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      onState: (context, state) => DashboardItemWidget(
                        icon: Icons.work_outline_rounded,
                        labelButton: 'Mais informações',
                        labelCount: store.state.totalVacancies.toString(),
                        labelDescription: 'Vagas postadas',
                        onPressed: () => store.changePage(2),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
