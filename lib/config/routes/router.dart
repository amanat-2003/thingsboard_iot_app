import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/constants/app_colors.dart';
import 'package:iot_app/core/auth/auth_routes.dart';
import 'package:iot_app/core/context/tb_context.dart';
import 'package:iot_app/core/init/init_routes.dart';
import 'package:iot_app/modules/alarm/alarm_routes.dart';
import 'package:iot_app/modules/asset/asset_routes.dart';
import 'package:iot_app/modules/audit_log/audit_logs_routes.dart';
import 'package:iot_app/modules/customer/customer_routes.dart';
import 'package:iot_app/modules/dashboard/dashboard_routes.dart';
import 'package:iot_app/modules/device/device_routes.dart';
import 'package:iot_app/modules/home/home_routes.dart';
import 'package:iot_app/modules/profile/profile_routes.dart';
import 'package:iot_app/modules/tenant/tenant_routes.dart';
import 'package:iot_app/utils/ui/dark_mode_checker.dart';
import 'package:iot_app/utils/ui_utils_routes.dart';

class ThingsboardAppRouter {
  final router = FluroRouter();
  late final _tbContext = TbContext(router);

  ThingsboardAppRouter() {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      var settings = context!.settings;
      return Scaffold(
        backgroundColor: isDarkMode(context)
            ? AppColors.backgroundDarkMode
            : AppColors.backgroundLightMode,
        extendBody: true,
        appBar: AppBar(title: Text('Not Found')),
        body: Center(child: Text('Route not defined: ${settings!.name}')),
      );
    });
    InitRoutes(_tbContext).registerRoutes();
    AuthRoutes(_tbContext).registerRoutes();
    UiUtilsRoutes(_tbContext).registerRoutes();
    HomeRoutes(_tbContext).registerRoutes();
    ProfileRoutes(_tbContext).registerRoutes();
    AssetRoutes(_tbContext).registerRoutes();
    DeviceRoutes(_tbContext).registerRoutes();
    AlarmRoutes(_tbContext).registerRoutes();
    DashboardRoutes(_tbContext).registerRoutes();
    AuditLogsRoutes(_tbContext).registerRoutes();
    CustomerRoutes(_tbContext).registerRoutes();
    TenantRoutes(_tbContext).registerRoutes();
  }

  TbContext get tbContext => _tbContext;
}

abstract class TbRoutes {
  final TbContext _tbContext;

  TbRoutes(this._tbContext);

  void registerRoutes() {
    doRegisterRoutes(_tbContext.router);
  }

  void doRegisterRoutes(FluroRouter router);

  TbContext get tbContext => _tbContext;
}
