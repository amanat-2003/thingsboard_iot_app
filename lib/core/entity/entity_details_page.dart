import 'package:flutter/material.dart';
import 'package:iot_app/constants/app_colors.dart';
import 'package:iot_app/core/context/tb_context.dart';
import 'package:iot_app/core/context/tb_context_widget.dart';
import 'package:iot_app/utils/ui/dark_mode_checker.dart';
import 'package:iot_app/widgets/tb_app_bar.dart';
import 'package:iot_app/widgets/tb_progress_indicator.dart';
import 'package:thingsboard_client/thingsboard_client.dart';

abstract class EntityDetailsPage<T extends BaseData> extends TbPageWidget {
  final labelTextStyle = TextStyle(fontSize: 14, height: 20 / 14);

  final valueTextStyle = TextStyle(fontSize: 14, height: 20 / 14);

  final String _defaultTitle;
  final String _entityId;
  final String? _subTitle;
  final bool _showLoadingIndicator;
  final bool _hideAppBar;
  final double? _appBarElevation;

  EntityDetailsPage(TbContext tbContext,
      {required String defaultTitle,
      required String entityId,
      String? subTitle,
      bool showLoadingIndicator = true,
      bool hideAppBar = false,
      double? appBarElevation})
      : this._defaultTitle = defaultTitle,
        this._entityId = entityId,
        this._subTitle = subTitle,
        this._showLoadingIndicator = showLoadingIndicator,
        this._hideAppBar = hideAppBar,
        this._appBarElevation = appBarElevation,
        super(tbContext);

  @override
  _EntityDetailsPageState createState() => _EntityDetailsPageState();

  Future<T?> fetchEntity(String id);

  ValueNotifier<String>? detailsTitle() {
    return null;
  }

  Widget buildEntityDetails(BuildContext context, T entity);
}

class _EntityDetailsPageState<T extends BaseData>
    extends TbPageState<EntityDetailsPage<T>> {
  late Future<T?> entityFuture;
  late ValueNotifier<String> titleValue;

  @override
  void initState() {
    super.initState();
    entityFuture = widget.fetchEntity(widget._entityId);
    ValueNotifier<String>? detailsTitle = widget.detailsTitle();
    if (detailsTitle == null) {
      titleValue = ValueNotifier(widget._defaultTitle);
      entityFuture.then((value) {
        if (value is HasName) {
          titleValue.value = (value as HasName).getName();
        }
      });
    } else {
      titleValue = detailsTitle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode(context)
          ? AppColors.backgroundDarkMode
          : AppColors.backgroundLightMode,
      extendBody: true,
      appBar: widget._hideAppBar
          ? null
          : TbAppBar(
              tbContext,
              showLoadingIndicator: widget._showLoadingIndicator,
              elevation: widget._appBarElevation,
              title: ValueListenableBuilder<String>(
                valueListenable: titleValue,
                builder: (context, title, _widget) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.centerLeft,
                            child: Text(title,
                                style: widget._subTitle != null
                                    ? TextStyle(
                                        color: isDarkMode(context)
                                            ? AppColors.whiteColor
                                            : AppColors.blackColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      )
                                    : null)),
                        if (widget._subTitle != null)
                          Text(widget._subTitle!,
                              style: TextStyle(
                                  color: isDarkMode(context)
                                      ? AppColors.onSurfaceVariantDarkMode
                                      : Color(0xFF757575),
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  height: 16 / 12))
                      ]);
                },
              ),
            ),
      body: FutureBuilder<T?>(
        future: entityFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var entity = snapshot.data;
            if (entity != null) {
              return widget.buildEntityDetails(context, entity);
            } else {
              return Center(child: Text('Requested entity does not exists.'));
            }
          } else {
            return Center(
                child: TbProgressIndicator(
              size: 50.0,
            ));
          }
        },
      ),
    );
  }
}

abstract class ContactBasedDetailsPage<T extends ContactBased>
    extends EntityDetailsPage<T> {
  ContactBasedDetailsPage(TbContext tbContext,
      {required String defaultTitle,
      required String entityId,
      String? subTitle,
      bool showLoadingIndicator = true,
      bool hideAppBar = false,
      double? appBarElevation})
      : super(tbContext,
            defaultTitle: defaultTitle,
            entityId: entityId,
            subTitle: subTitle,
            showLoadingIndicator: showLoadingIndicator,
            hideAppBar: hideAppBar,
            appBarElevation: appBarElevation);

  @override
  Widget buildEntityDetails(BuildContext context, T contact) {
    return Padding(
        padding: EdgeInsets.all(16),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Title',
                style: labelTextStyle.copyWith(
                  color: isDarkMode(context)
                      ? AppColors.onSurfaceVariantDarkMode
                      : Color(0xFF757575),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(contact.getName(),
                  style: valueTextStyle.copyWith(
                    color: isDarkMode(context)
                        ? AppColors.whiteColor
                        : Color(0xFF282828),
                  )),
              SizedBox(height: 16),
              Text('Country',
                  style: labelTextStyle.copyWith(
                    color: isDarkMode(context)
                        ? AppColors.onSurfaceVariantDarkMode
                        : Color(0xFF757575),
                    fontWeight: FontWeight.bold,
                  )),
              Text(contact.country ?? '',
                  style: valueTextStyle.copyWith(
                    color: isDarkMode(context)
                        ? AppColors.whiteColor
                        : Color(0xFF282828),
                  )),
              SizedBox(height: 16),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                      fit: FlexFit.tight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text('City',
                              style: labelTextStyle.copyWith(
                                color: isDarkMode(context)
                                    ? AppColors.onSurfaceVariantDarkMode
                                    : Color(0xFF757575),
                                fontWeight: FontWeight.bold,
                              )),
                          Text(contact.city ?? '',
                              style: valueTextStyle.copyWith(
                                color: isDarkMode(context)
                                    ? AppColors.whiteColor
                                    : Color(0xFF282828),
                              )),
                        ],
                      )),
                  Flexible(
                      fit: FlexFit.tight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text('State / Province',
                              style: labelTextStyle.copyWith(
                                color: isDarkMode(context)
                                    ? AppColors.onSurfaceVariantDarkMode
                                    : Color(0xFF757575),
                                fontWeight: FontWeight.bold,
                              )),
                          Text(contact.state ?? '',
                              style: valueTextStyle.copyWith(
                                color: isDarkMode(context)
                                    ? AppColors.whiteColor
                                    : Color(0xFF282828),
                              )),
                        ],
                      )),
                ],
              ),
              SizedBox(height: 16),
              Text('Zip / Postal Code',
                  style: labelTextStyle.copyWith(
                    color: isDarkMode(context)
                        ? AppColors.onSurfaceVariantDarkMode
                        : Color(0xFF757575),
                    fontWeight: FontWeight.bold,
                  )),
              Text(contact.zip ?? '',
                  style: valueTextStyle.copyWith(
                    color: isDarkMode(context)
                        ? AppColors.whiteColor
                        : Color(0xFF282828),
                  )),
              SizedBox(height: 16),
              Text('Address',
                  style: labelTextStyle.copyWith(
                    color: isDarkMode(context)
                        ? AppColors.onSurfaceVariantDarkMode
                        : Color(0xFF757575),
                    fontWeight: FontWeight.bold,
                  )),
              Text(contact.address ?? '',
                  style: valueTextStyle.copyWith(
                    color: isDarkMode(context)
                        ? AppColors.whiteColor
                        : Color(0xFF282828),
                  )),
              SizedBox(height: 16),
              Text('Address 2',
                  style: labelTextStyle.copyWith(
                    color: isDarkMode(context)
                        ? AppColors.onSurfaceVariantDarkMode
                        : Color(0xFF757575),
                    fontWeight: FontWeight.bold,
                  )),
              Text(contact.address2 ?? '',
                  style: valueTextStyle.copyWith(
                    color: isDarkMode(context)
                        ? AppColors.whiteColor
                        : Color(0xFF282828),
                  )),
              SizedBox(height: 16),
              Text('Phone',
                  style: labelTextStyle.copyWith(
                    color: isDarkMode(context)
                        ? AppColors.onSurfaceVariantDarkMode
                        : Color(0xFF757575),
                    fontWeight: FontWeight.bold,
                  )),
              Text(contact.phone ?? '',
                  style: valueTextStyle.copyWith(
                    color: isDarkMode(context)
                        ? AppColors.whiteColor
                        : Color(0xFF282828),
                  )),
              SizedBox(height: 16),
              Text('Email',
                  style: labelTextStyle.copyWith(
                    color: isDarkMode(context)
                        ? AppColors.onSurfaceVariantDarkMode
                        : Color(0xFF757575),
                    fontWeight: FontWeight.bold,
                  )),
              Text(contact.email ?? '',
                  style: valueTextStyle.copyWith(
                    color: isDarkMode(context)
                        ? AppColors.whiteColor
                        : Color(0xFF282828),
                  )),
            ]));
  }
}
