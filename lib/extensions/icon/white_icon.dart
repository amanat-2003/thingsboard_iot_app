import 'package:flutter/material.dart';
import 'package:iot_app/constants/app_colors.dart';

extension on Icon {
  // ignore: unused_element
  Icon get whiteIcon {
    return Icon(this.icon, color: AppColors.backgroundColor,);
  }
}
