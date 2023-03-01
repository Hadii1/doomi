import 'package:doomi/models/database%20models/project.dart';
import 'package:doomi/models/response.dart';
import 'package:doomi/providers/projects_provider.dart';
import 'package:doomi/providers/theme_provider.dart';
import 'package:doomi/providers/user_provider.dart';
import 'package:doomi/services/navigation_service.dart';
import 'package:doomi/utils/enums.dart';
import 'package:doomi/utils/general_functions.dart';
import 'package:doomi/utils/router.dart';
import 'package:doomi/utils/styles/spacings.dart';
import 'package:doomi/widgets/error_widget.dart';
import 'package:doomi/widgets/loader.dart';
import 'package:doomi/widgets/project_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final user = ref.watch(userProvider);
    final Response<List<Project>> projects = ref.watch(projectsProvider);
    return Scaffold(
      backgroundColor: theme.background,
      body: Column(
        children: [
          SizedBox(
            height: 110,
            child: CupertinoNavigationBar(
              backgroundColor: theme.background,
              automaticallyImplyLeading: false,
              leading: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  '${translate('welcome', context)} ${capitalizeFirstLetter(user!.firstName)}',
                  style: theme.body3,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      onTap: () =>
                          NavigatorService.navigateTo(Routes.settings, context),
                      child: Icon(
                        CupertinoIcons.settings,
                        size: 26,
                        color: theme.accentColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: Spacings.spacingFactor,
                  ),
                  Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      onTap: () => NavigatorService.navigateTo(
                          Routes.writeProject, context),
                      child: const Icon(
                        CupertinoIcons.add,
                        size: 28,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: projects.status == NetworkCallStatus.loading
                  ? const Loader()
                  : projects.status == NetworkCallStatus.error
                      ? CustomErrorWidget(onActionPressed: () {})
                      : projects.data!.isEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  translate('noProjectsFound', context),
                                  style: theme.title2,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: Spacings.spacingBetweenElements,
                                ),
                                Text(
                                  translate('createYourFirstProject', context),
                                  style: theme.body3,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: Spacings.spacingFactor * 8,
                                )
                              ],
                            )
                          : ListView.builder(
                              padding: EdgeInsets.symmetric(
                                horizontal: Spacings.horizontalPadding.left,
                                vertical: Spacings.spacingFactor * 3,
                              ),
                              itemCount: projects.data!.length,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.only(
                                    bottom: Spacings.spacingBetweenElements),
                                child: ProjectCard(
                                  project: projects.data![index],
                                ),
                              ),
                            ),
            ),
          )
        ],
      ),
    );
  }
}
