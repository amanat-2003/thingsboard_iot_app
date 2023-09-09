// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iot_app/utils/ui/dark_mode_checker.dart';
import 'package:thingsboard_client/thingsboard_client.dart';

import 'package:iot_app/constants/app_colors.dart';
import 'package:iot_app/constants/assets_path.dart';
import 'package:iot_app/core/context/tb_context.dart';
import 'package:iot_app/core/context/tb_context_widget.dart';
import 'package:iot_app/core/entity/entities_base.dart';
import 'package:iot_app/utils/utils.dart';

mixin DashboardsBase on EntitiesBase<DashboardInfo, PageLink> {
  @override
  String get title => 'Dashboards';

  @override
  String get noItemsFoundText => 'No dashboards found';

  @override
  Future<PageData<DashboardInfo>> fetchEntities(PageLink pageLink) {
    if (tbClient.isTenantAdmin()) {
      return tbClient
          .getDashboardService()
          .getTenantDashboards(pageLink, mobile: true);
    } else {
      return tbClient.getDashboardService().getCustomerDashboards(
          tbClient.getAuthUser()!.customerId!, pageLink,
          mobile: true);
    }
  }

  @override
  void onEntityTap(DashboardInfo dashboard) {
    navigateToDashboard(dashboard.id!.id!, dashboardTitle: dashboard.title);
    // navigateTo('/fullscreenDashboard/${dashboard.id!.id}?title=${dashboard.title}');
    // navigateTo('/dashboard/${dashboard.id!.id}?title=${dashboard.title}');
  }

  @override
  Widget buildEntityListCard(BuildContext context, DashboardInfo dashboard) {
    return _buildEntityListCard(context, dashboard, false);
  }

  @override
  Widget buildEntityListWidgetCard(
      BuildContext context, DashboardInfo dashboard) {
    return _buildEntityListCard(context, dashboard, true);
  }

  @override
  EntityCardSettings entityGridCardSettings(DashboardInfo dashboard) =>
      EntityCardSettings(dropShadow: true); //dashboard.image != null);

  @override
  Widget buildEntityGridCard(BuildContext context, DashboardInfo dashboard) {
    return DashboardGridCard(tbContext, dashboard: dashboard);
  }

  Widget _buildEntityListCard(
    BuildContext context,
    DashboardInfo dashboard,
    bool listWidgetCard,
  ) {
    return Row(
        mainAxisSize: listWidgetCard ? MainAxisSize.min : MainAxisSize.max,
        children: [
          Flexible(
              fit: listWidgetCard ? FlexFit.loose : FlexFit.tight,
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: listWidgetCard ? 9 : 10, horizontal: 16),
                child: Row(
                  mainAxisSize:
                      listWidgetCard ? MainAxisSize.min : MainAxisSize.max,
                  children: [
                    Flexible(
                        fit: listWidgetCard ? FlexFit.loose : FlexFit.tight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                                fit: BoxFit.fitWidth,
                                alignment: Alignment.centerLeft,
                                child: Text('${dashboard.title}',
                                    style: TextStyle(
                                        color: Color(0xFF282828),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        height: 1.7))),
                            Text('${_dashboardDetailsText(dashboard)}',
                                style: TextStyle(
                                    color: Color(0xFFAFAFAF),
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    height: 1.33))
                          ],
                        )),
                    (!listWidgetCard
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                  entityDateFormat.format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          dashboard.createdTime!)),
                                  style: TextStyle(
                                      color: Color(0xFFAFAFAF),
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      height: 1.33))
                            ],
                          )
                        : Container())
                  ],
                ),
              ))
        ]);
  }

  String _dashboardDetailsText(DashboardInfo dashboard) {
    if (tbClient.isTenantAdmin()) {
      if (_isPublicDashboard(dashboard)) {
        return 'Public';
      } else {
        return dashboard.assignedCustomers.map((e) => e.title).join(', ');
      }
    }
    return '';
  }

  bool _isPublicDashboard(DashboardInfo dashboard) {
    return dashboard.assignedCustomers.any((element) => element.isPublic);
  }
}

class DashboardGridCard extends TbContextWidget {
  final DashboardInfo dashboard;

  DashboardGridCard(TbContext tbContext, {required this.dashboard})
      : super(tbContext);

  @override
  _DashboardGridCardState createState() => _DashboardGridCardState();
}

class _DashboardGridCardState extends TbContextState<DashboardGridCard> {
  _DashboardGridCardState() : super();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(DashboardGridCard oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    var hasImage = widget.dashboard.image != null;
    Widget image;
    if (hasImage) {
      image = Utils.imageFromBase64(
        widget.dashboard.image!,
        height: 150,
        width: 150,
      );
    } else {
      image = SvgPicture.asset(
        ThingsboardImage.dashboardPlaceholder,
        color: Theme.of(context).primaryColor,
        colorBlendMode: BlendMode.overlay,
        semanticsLabel: 'Dashboard',
        height: 150,
        width: 150,
      );
    }
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: isDarkMode(context)? AppColors.primaryContainerDarkMode : AppColors.primaryContainerLightMode,

      //   border: Border.all(
      //       color: Color.fromARGB(255, 254, 254, 254)), // Add the border
      //   // gradient: LinearGradient(
      //   //   colors: [
      //   //     // AppColors.onPrimaryContainerDarkMode,
      //   //     // AppColors.tertiaryDarkMode,
      //   //     AppColors.onTertiaryContainerDarkMode,
      //   //     // AppColors.surfaceTintDarkMode,
      //   //     AppColors.greyColor,
      //   //   ],
      //   //   begin: Alignment.topLeft,
      //   //   end: Alignment.bottomRight,
      //   // ),
      ),
      child: Stack(
        children: [
          Divider(height: 1),
          Container(
            height: 49,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 6),
                child: Center(
                    child: AutoSizeText(
                  widget.dashboard.title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  minFontSize: 12,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: isDarkMode(context)? AppColors.onPrimaryContainerDarkMode : AppColors.onTertiaryDarkMode,
                    fontSize: 16,
                    height: 20 / 14,
                  ),
                ))),
          ),
          Positioned(
            bottom: -40,
            right: -40,
            child: SizedBox(
              height: 150,
              width: 150,
              child: image,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomBox extends StatelessWidget {
  final double? side;
  final double? height;
  final double? width;
  final Widget? child;
  final String? text;
  final IconData? icon;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? borderColor;
  final Color? topLeftColor;
  final Color? bottomRightColor;
  final double? borderRadius;
  final double? borderRadiusTopLeft;
  final double? borderRadiusBottomLeft;
  final double? borderRadiusTopRight;
  final double? borderRadiusBottomRight;

  const CustomBox({
    Key? key,
    this.side,
    this.height,
    this.width,
    this.child,
    this.text,
    this.icon,
    this.foregroundColor,
    this.backgroundColor,
    this.iconColor,
    this.borderColor,
    this.topLeftColor,
    this.bottomRightColor,
    this.borderRadius,
    this.borderRadiusTopLeft,
    this.borderRadiusBottomLeft,
    this.borderRadiusTopRight,
    this.borderRadiusBottomRight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final goodBorderRadius = ((height ?? side!) / 6);
    var borderRadiusVar = (borderRadius != null)
        ? BorderRadius.circular(borderRadius ?? goodBorderRadius)
        : BorderRadius.only(
            bottomLeft: Radius.circular(
                borderRadiusBottomLeft ?? borderRadius ?? goodBorderRadius),
            topLeft: Radius.circular(
                borderRadiusTopLeft ?? borderRadius ?? goodBorderRadius),
            topRight: Radius.circular(
                borderRadiusTopRight ?? borderRadius ?? goodBorderRadius),
            bottomRight: Radius.circular(
                borderRadiusBottomRight ?? borderRadius ?? goodBorderRadius),
          );
    return Stack(children: [
      Container(
        height: height ?? side,
        width: width ?? side,
        decoration:
            BoxDecoration(borderRadius: borderRadiusVar, color: Colors.white),
      ),
      Container(
        height: height ?? side,
        width: width ?? side,
        decoration: BoxDecoration(
          borderRadius: borderRadiusVar,
          border: Border.all(
              color: borderColor ??
                  Color.fromARGB(255, 254, 254, 254)), // Add the border
          gradient: LinearGradient(
            colors: [
              topLeftColor ??
                  backgroundColor ??
                  Color.fromARGB(255, 226, 226, 226),
              bottomRightColor ??
                  backgroundColor ??
                  Color.fromARGB(255, 170, 170, 170)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: child ??
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null)
                  Icon(
                    icon,
                    size: (height ?? side!) * 3 / 5,
                    color: iconColor ?? foregroundColor ?? Colors.white,
                  ),
                if (icon != null && text != null)
                  SizedBox(
                    width: (width ?? side!) / 15,
                  ),
                if (text != null)
                  Text(
                    text ?? '',
                    style: TextStyle(
                      color: foregroundColor ?? const Color(0xff323232),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
              ],
            ),
      ),
    ]);
  }
}
