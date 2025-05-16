import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:iot_app/constants/app_colors.dart';
import 'package:iot_app/utils/ui/dark_mode_checker.dart';

import 'entities_base.dart';
import 'entity_grid_card.dart';

mixin EntitiesGridStateBase on StatefulWidget {
  @override
  _EntitiesGridState createState() => _EntitiesGridState();
}

class _EntitiesGridState<T, P> extends BaseEntitiesState<T, P> {
  _EntitiesGridState() : super();

  @override
  Widget pagedViewBuilder(BuildContext context) {
    var heading = widget.buildHeading(context);
    var gridChildAspectRatio = widget.gridChildAspectRatio() ?? 9 / 10;
    List<Widget> slivers = [];
    if (heading != null) {
      slivers.add(
        SliverPadding(
          padding: EdgeInsets.fromLTRB(30, 16, 30, 0),
          sliver: SliverToBoxAdapter(child: heading),
        ),
      );
    }
    slivers.add(
      SliverPadding(
        padding: EdgeInsets.fromLTRB(30, 16, 30, 10),
        sliver: SliverToBoxAdapter(
          child: Text(
            'Dashboards',
            style: TextStyle(
              color: isDarkMode(context)
                  ? AppColors.whiteColor
                  : AppColors.onPrimaryContainerLightMode,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
    slivers.add(SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        sliver: PagedSliverGrid(
            showNewPageProgressIndicatorAsGridChild: false,
            showNewPageErrorIndicatorAsGridChild: false,
            showNoMoreItemsIndicatorAsGridChild: false,
            pagingController: pagingController,
            // padding: EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: gridChildAspectRatio,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              crossAxisCount: 2,
            ),
            builderDelegate: PagedChildBuilderDelegate<T>(
                itemBuilder: (context, item, index) => EntityGridCard<T>(
                      item,
                      key: widget.getKey(item),
                      entityCardWidgetBuilder: widget.buildEntityGridCard,
                      onEntityTap: widget.onEntityTap,
                      settings: widget.entityGridCardSettings(item),
                    ),
                firstPageProgressIndicatorBuilder:
                    firstPageProgressIndicatorBuilder,
                newPageProgressIndicatorBuilder:
                    newPageProgressIndicatorBuilder,
                noItemsFoundIndicatorBuilder: noItemsFoundIndicatorBuilder))));
    return CustomScrollView(slivers: slivers);
  }
}
