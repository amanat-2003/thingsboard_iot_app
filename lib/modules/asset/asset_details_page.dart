import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iot_app/constants/app_colors.dart';
import 'package:iot_app/core/context/tb_context.dart';
import 'package:iot_app/core/entity/entity_details_page.dart';
import 'package:iot_app/generated/l10n.dart';
import 'package:iot_app/utils/ui/dark_mode_checker.dart';
import 'package:thingsboard_client/thingsboard_client.dart';

class AssetDetailsPage extends EntityDetailsPage<AssetInfo> {
  AssetDetailsPage(TbContext tbContext, String assetId)
      : super(tbContext,
            entityId: assetId,
            defaultTitle: 'Asset',
            subTitle: 'Asset details');

  @override
  Future<AssetInfo?> fetchEntity(String assetId) {
    return tbClient.getAssetService().getAssetInfo(assetId);
  }

  @override
  Widget buildEntityDetails(BuildContext context, AssetInfo asset) {
    return Padding(
        padding: EdgeInsets.all(16),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text('${S.of(context).assetName}',
                  style: labelTextStyle.copyWith(
                    color: isDarkMode(context)
                        ? AppColors.onSurfaceVariantDarkMode
                        : Color(0xFF757575),
                    fontWeight: FontWeight.bold,
                  )),
              Text(asset.name,
                  style: valueTextStyle.copyWith(
                    color: isDarkMode(context)
                        ? AppColors.whiteColor
                        : Color(0xFF282828),
                  )),
              SizedBox(height: 16),
              Text('${S.of(context).type}',
                  style: labelTextStyle.copyWith(
                    color: isDarkMode(context)
                        ? AppColors.onSurfaceVariantDarkMode
                        : Color(0xFF757575),
                    fontWeight: FontWeight.bold,
                  )),
              Text(asset.type,
                  style: valueTextStyle.copyWith(
                    color: isDarkMode(context)
                        ? AppColors.whiteColor
                        : Color(0xFF282828),
                  )),
              SizedBox(height: 16),
              Text('${S.of(context).label}',
                  style: labelTextStyle.copyWith(
                    color: isDarkMode(context)
                        ? AppColors.onSurfaceVariantDarkMode
                        : Color(0xFF757575),
                    fontWeight: FontWeight.bold,
                  )),
              Text(asset.label ?? '',
                  style: valueTextStyle.copyWith(
                    color: isDarkMode(context)
                        ? AppColors.whiteColor
                        : Color(0xFF282828),
                  )),
              SizedBox(height: 16),
              Text('${S.of(context).assignedToCustomer}',
                  style: labelTextStyle.copyWith(
                    color: isDarkMode(context)
                        ? AppColors.onSurfaceVariantDarkMode
                        : Color(0xFF757575),
                    fontWeight: FontWeight.bold,
                  )),
              Text(asset.customerTitle ?? '',
                  style: valueTextStyle.copyWith(
                    color: isDarkMode(context)
                        ? AppColors.whiteColor
                        : Color(0xFF282828),
                  )),
            ]));
  }
}
