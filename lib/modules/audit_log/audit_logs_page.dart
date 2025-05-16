import 'package:flutter/material.dart';
import 'package:iot_app/constants/app_colors.dart';
import 'package:iot_app/core/context/tb_context.dart';
import 'package:iot_app/core/context/tb_context_widget.dart';
import 'package:iot_app/core/entity/entities_base.dart';
import 'package:iot_app/modules/audit_log/audit_logs_list.dart';
import 'package:iot_app/utils/ui/dark_mode_checker.dart';
import 'package:iot_app/widgets/tb_app_bar.dart';

class AuditLogsPage extends TbPageWidget {
  final bool searchMode;

  AuditLogsPage(TbContext tbContext, {this.searchMode = false})
      : super(tbContext);

  @override
  _AuditLogsPageState createState() => _AuditLogsPageState();
}

class _AuditLogsPageState extends TbPageState<AuditLogsPage> {
  final TimePageLinkController _timePageLinkController =
      TimePageLinkController();

  @override
  Widget build(BuildContext context) {
    var auditLogsList = AuditLogsList(tbContext, _timePageLinkController,
        searchMode: widget.searchMode);
    PreferredSizeWidget appBar;
    if (widget.searchMode) {
      appBar = TbAppSearchBar(
        tbContext,
        onSearch: (searchText) =>
            _timePageLinkController.onSearchText(searchText),
      );
    } else {
      appBar = TbAppBar(tbContext, title: Text(auditLogsList.title), actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            navigateTo('/auditLogs?search=true');
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
      body: auditLogsList,
    );
  }

  @override
  void dispose() {
    _timePageLinkController.dispose();
    super.dispose();
  }
}
