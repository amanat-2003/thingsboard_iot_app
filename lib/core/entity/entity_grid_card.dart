import 'package:flutter/material.dart';
import 'package:iot_app/constants/app_colors.dart';
import 'package:iot_app/utils/ui/dark_mode_checker.dart';

import 'entities_base.dart';

class EntityGridCard<T> extends StatelessWidget {
  final T _entity;
  final EntityTapFunction<T>? _onEntityTap;
  final EntityCardWidgetBuilder<T> _entityCardWidgetBuilder;
  // ignore: unused_field
  final EntityCardSettings _settings;

  EntityGridCard(T entity,
      {Key? key,
      EntityTapFunction<T>? onEntityTap,
      required EntityCardWidgetBuilder<T> entityCardWidgetBuilder,
      required EntityCardSettings settings})
      : this._entity = entity,
        this._onEntityTap = onEntityTap,
        this._entityCardWidgetBuilder = entityCardWidgetBuilder,
        this._settings = settings,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Card(
          margin: EdgeInsets.zero,
          color: isDarkMode(context)
              ? AppColors.primaryContainerDarkMode
              : AppColors.primaryContainerLightMode,
          // color: isDarkMode(context)
          //     ? AppColors.backgroundDarkMode
          //     : AppColors.backgroundLightMode,
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(4),
          // ),
          elevation: 5,
          child: _entityCardWidgetBuilder(context, _entity),
        ),
        onTap: () {
          if (_onEntityTap != null) {
            _onEntityTap!(_entity);
          }
        });
  }
}
