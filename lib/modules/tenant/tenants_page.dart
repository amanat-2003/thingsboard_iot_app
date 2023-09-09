import 'package:flutter/material.dart';
import 'package:iot_app/constants/app_colors.dart';
import 'package:iot_app/core/context/tb_context.dart';
import 'package:iot_app/core/context/tb_context_widget.dart';
import 'package:iot_app/core/entity/entities_base.dart';
import 'package:iot_app/utils/ui/dark_mode_checker.dart';
import 'package:iot_app/widgets/tb_app_bar.dart';

import 'tenants_list.dart';

class TenantsPage extends TbPageWidget {
  final bool searchMode;

  TenantsPage(TbContext tbContext, {this.searchMode = false})
      : super(tbContext);

  @override
  _TenantsPageState createState() => _TenantsPageState();
}

class _TenantsPageState extends TbPageState<TenantsPage> {
  final PageLinkController _pageLinkController = PageLinkController();

  @override
  Widget build(BuildContext context) {
    var tenantsList = TenantsList(tbContext, _pageLinkController,
        searchMode: widget.searchMode);
    PreferredSizeWidget appBar;
    if (widget.searchMode) {
      appBar = TbAppSearchBar(
        tbContext,
        onSearch: (searchText) => _pageLinkController.onSearchText(searchText),
      );
    } else {
      appBar = TbAppBar(tbContext, title: Text(tenantsList.title), actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            navigateTo('/tenants?search=true');
          },
        )
      ]);
    }
    return Scaffold(
        backgroundColor: isDarkMode(context)
            ? AppColors.backgroundDarkMode
            : AppColors.backgroundLightMode,
        extendBody: true,
        appBar: appBar,
        body: tenantsList);
  }

  @override
  void dispose() {
    _pageLinkController.dispose();
    super.dispose();
  }
}
