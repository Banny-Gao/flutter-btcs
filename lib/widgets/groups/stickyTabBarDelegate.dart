import 'package:flutter/material.dart';

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;
  final String coverImgUrl;
  final Widget coverImage;
  final double collapsedHeight;
  final double expandedHeight;

  StickyTabBarDelegate({
    @required this.child,
    this.coverImgUrl,
    this.collapsedHeight = 0,
    this.expandedHeight = 0,
    this.coverImage,
  });

  @override
  double get maxExtent => child.preferredSize.height + expandedHeight;

  @override
  double get minExtent => child.preferredSize.height + collapsedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  Color makeStickyHeaderBgColor(shrinkOffset) {
    final int alpha =
        (shrinkOffset / (maxExtent - minExtent) * 255).clamp(0, 255).toInt();
    return Color.fromARGB(alpha, 255, 255, 255);
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: maxExtent,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        // fit: StackFit.expand,
        children: <Widget>[
          coverImgUrl != null
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: expandedHeight,
                  child: Image.network(
                    coverImgUrl,
                    fit: BoxFit.fill,
                  ),
                )
              : coverImage != null
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: expandedHeight,
                      child: coverImage,
                    )
                  : Container(),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: makeStickyHeaderBgColor(shrinkOffset),
              child: this.child,
            ),
          ),
        ],
      ),
    );
  }
}
