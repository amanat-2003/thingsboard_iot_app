import 'package:flutter/material.dart';
import 'package:iot_app/constants/app_colors.dart';
import 'package:iot_app/core/context/tb_context.dart';
import 'package:iot_app/core/context/tb_context_widget.dart';
import 'package:iot_app/core/entity/entities_base.dart';
import 'package:iot_app/utils/ui/dark_mode_checker.dart';
import 'package:iot_app/widgets/tb_app_bar.dart';

import 'assets_list.dart';

class AssetsPage extends TbPageWidget {
  final bool searchMode;

  AssetsPage(TbContext tbContext, {this.searchMode = false}) : super(tbContext);

  @override
  _AssetsPageState createState() => _AssetsPageState();
}

class _AssetsPageState extends TbPageState<AssetsPage> {
  final PageLinkController _pageLinkController = PageLinkController();

  @override
  Widget build(BuildContext context) {
    var assetsList = AssetsList(tbContext, _pageLinkController,
        searchMode: widget.searchMode);
    PreferredSizeWidget appBar;
    if (widget.searchMode) {
      appBar = TbAppSearchBar(
        tbContext,
        onSearch: (searchText) => _pageLinkController.onSearchText(searchText),
      );
    } else {
      appBar = TbAppBar(tbContext, title: Text(assetsList.title), actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            navigateTo('/assets?search=true');
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
        body: assetsList);
  }

  @override
  void dispose() {
    _pageLinkController.dispose();
    super.dispose();
  }
}
