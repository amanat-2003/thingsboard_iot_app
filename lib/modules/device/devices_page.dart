import 'package:flutter/material.dart';
import 'package:iot_app/constants/app_colors.dart';
import 'package:iot_app/core/context/tb_context.dart';
import 'package:iot_app/core/context/tb_context_widget.dart';
import 'package:iot_app/core/entity/entities_base.dart';
import 'package:iot_app/modules/device/device_profiles_grid.dart';
import 'package:iot_app/utils/ui/dark_mode_checker.dart';
import 'package:iot_app/widgets/tb_app_bar.dart';

class DevicesPage extends TbPageWidget {
  DevicesPage(TbContext tbContext) : super(tbContext);

  @override
  _DevicesPageState createState() => _DevicesPageState();
}

class _DevicesPageState extends TbPageState<DevicesPage> {
  final PageLinkController _pageLinkController = PageLinkController();

  @override
  Widget build(BuildContext context) {
    var deviceProfilesList = DeviceProfilesGrid(tbContext, _pageLinkController);
    return Scaffold(backgroundColor: isDarkMode(context)? AppColors.backgroundDarkMode: AppColors.backgroundLightMode,extendBody: true,
        appBar: TbAppBar(tbContext, title: Text(deviceProfilesList.title)),
        body: deviceProfilesList);
  }

  @override
  void dispose() {
    _pageLinkController.dispose();
    super.dispose();
  }
}
