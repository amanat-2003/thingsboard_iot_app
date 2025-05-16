import 'package:flutter/material.dart';
import 'package:iot_app/constants/app_colors.dart';
import 'package:iot_app/core/context/tb_context.dart';
import 'package:iot_app/core/context/tb_context_widget.dart';
import 'package:iot_app/modules/dashboard/dashboard.dart' as dashboardUi;
import 'package:iot_app/modules/dashboard/dashboards_grid.dart';
import 'package:iot_app/modules/tenant/tenants_widget.dart';
import 'package:iot_app/utils/ui/dark_mode_checker.dart';
import 'package:iot_app/widgets/tb_app_bar.dart';
import 'package:thingsboard_client/thingsboard_client.dart';

class HomePage extends TbContextWidget {
  HomePage(TbContext tbContext) : super(tbContext);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends TbContextState<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  bool get wantKeepAlive {
    return true;
  }

  @override
  void dispose() {
    super.dispose();
  }

  String _getUserDisplayName() {
    var user = tbContext.userDetails;
    var name = '';
    if (user != null) {
      if ((user.firstName != null && user.firstName!.isNotEmpty) ||
          (user.lastName != null && user.lastName!.isNotEmpty)) {
        if (user.firstName != null) {
          name += user.firstName!;
        }
        if (user.lastName != null) {
          if (name.isNotEmpty) {
            name += ' ';
          }
          name += user.lastName!;
        }
      } else {
        name = user.email;
      }
    }
    return name;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var homeDashboard = tbContext.homeDashboard;
    var dashboardState = homeDashboard != null;
    return Scaffold(
      backgroundColor: isDarkMode(context)
          ? AppColors.backgroundDarkMode
          : AppColors.backgroundLightMode,
      extendBody: true,
      appBar: TbAppBar(
        tbContext,
        // elevation: dashboardState ? 0 : 8,
        showLoadingIndicator: true,
        title: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Hi ${_getUserDisplayName()}',
                style: TextStyle(
                  color: isDarkMode(context)
                      ? AppColors.whiteColor
                      : AppColors.onPrimaryContainerLightMode,
                  fontSize: 22,
                ),
              ),
              GestureDetector(
                onTap: tbClient.isSystemAdmin()
                    ? () {
                        navigateTo('/tenants?search=true');
                      }
                    : () async {
                        setState(() async {
                          await navigateTo('/profile');
                        });
                      },
                child: CircleAvatar(
                  radius: 17,
                  backgroundColor: isDarkMode(context)
                      ? AppColors.whiteColor
                      : AppColors.onPrimaryContainerLightMode,
                  child: Icon(
                    tbClient.isSystemAdmin()
                        ? Icons.search
                        : Icons.account_circle,
                    size: 32,
                    color: AppColors.primaryDarkMode,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Container(
        //   width: double.infinity, // Set the width of the container
        //   height: 45, // Set the height of the container
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(25.0), // Set the border radius
        //     border: Border.all(
        //       color:
        //           AppColors.whiteColor.withOpacity(0.1), // Set the border color
        //       width: 1.0, // Set the border width
        //     ),
        //   ),
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 5),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         Expanded(
        //           flex: 3,
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.start,
        //             children: [
        //               CircleAvatar(
        //                 radius: 17,
        //                 backgroundColor: AppColors.whiteColor,
        //                 child: SvgPicture.asset(
        //                   ThingsboardImage.aquaCare,
        //                   // height: 90,
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //         Expanded(
        //           flex: 4,
        //           child: Row(
        //             // crossAxisAlignment: CrossAxisAlignment.start,
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               Center(
        //                 // height: double.infinity,
        //                 child: Text(
        //                   ThingsboardImage.aquaCraftWithTitle,
        //                   style: TextStyle(
        //                     fontSize: 16,
        //                     color: AppColors.whiteColor.withOpacity(0.8),
        //                   ),
        //                 ),
        //               ),
        //               GestureDetector(
        //                 onTap: tbClient.isSystemAdmin()
        //                     ? () {
        //                         navigateTo('/tenants?search=true');
        //                       }
        //                     : () async {
        //                         setState(() async {
        //                           await navigateTo('/profile');
        //                         });
        //                       },
        //                 child: CircleAvatar(
        //                   radius: 17,
        //                   backgroundColor: AppColors.whiteColor,
        //                   child: Icon(
        //                     tbClient.isSystemAdmin()
        //                         ? Icons.search
        //                         : Icons.account_circle,
        //                     size: 30,
        //                     color: AppColors.primaryDarkMode,
        //                   ),
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ),
      body: Builder(builder: (context) {
        if (dashboardState) {
          return _buildDashboardHome(context, homeDashboard!);
        } else {
          return _buildDefaultHome(context);
        }
      }),
    );
  }

  Widget _buildDashboardHome(
      BuildContext context, HomeDashboardInfo dashboard) {
    return HomeDashboard(tbContext, dashboard);
  }

  Widget _buildDefaultHome(BuildContext context) {
    if (tbClient.isSystemAdmin()) {
      return _buildSysAdminHome(context);
    } else {
      return DashboardsGridWidget(tbContext);
    }
  }

  Widget _buildSysAdminHome(BuildContext context) {
    return TenantsWidget(tbContext);
  }
}

class HomeDashboard extends TbContextWidget {
  final HomeDashboardInfo dashboard;

  HomeDashboard(TbContext tbContext, this.dashboard) : super(tbContext);

  @override
  _HomeDashboardState createState() => _HomeDashboardState();
}

class _HomeDashboardState extends TbContextState<HomeDashboard> {
  @override
  Widget build(BuildContext context) {
    return dashboardUi.Dashboard(tbContext, home: true,
        controllerCallback: (controller) {
      controller.openDashboard(widget.dashboard.dashboardId!.id!,
          hideToolbar: widget.dashboard.hideDashboardToolbar);
    });
  }
}
