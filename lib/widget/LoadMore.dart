import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const kRefreshOffset = 40.0;
const kLoadMoreOffset = 0.0;

enum _PullIndicatorMode { idle, dragReleaseRefresh, dragReleaseLoadMore, dragReleaseCancel, refreshing, loading }

typedef Future PullCallback();

class LoadMore extends StatefulWidget {
  final Widget child;
  final PullCallback onLoadMore;

  final double loadMoreOffset;

  final NotificationListenerCallback<ScrollNotification> scrollNotification;

  LoadMore({@required this.child, this.onLoadMore, this.loadMoreOffset = kLoadMoreOffset, this.scrollNotification});

  @override
  _LoadMoreState createState() => new _LoadMoreState();
}

class _LoadMoreState extends State<LoadMore> {
  double _dragOffset;

  _PullIndicatorMode _mode;

  bool enableLoadMore = true;

  @override
  Widget build(BuildContext context) {
//    if(widget.child is ListView && enableLoadMore){
//      return widget.child;
//    }
    return new NotificationListener(
      onNotification: _handleScrollNotification,
      child: widget.child,
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (widget.scrollNotification != null) {
      widget.scrollNotification(notification);
    }

    if (notification is ScrollStartNotification) {
      _dragOffset = 0.0;
      _mode = _PullIndicatorMode.dragReleaseCancel;
    }

    if (notification is UserScrollNotification) {}

    if (notification is ScrollUpdateNotification) {
      _dragOffset -= notification.scrollDelta;

      if (_mode == _PullIndicatorMode.dragReleaseCancel ||
          _mode == _PullIndicatorMode.dragReleaseRefresh ||
          _mode == _PullIndicatorMode.dragReleaseLoadMore) {
        if (notification.metrics.extentAfter == 0.0 && _dragOffset < -widget.loadMoreOffset) {
//          changeMode(_PullIndicatorMode.dragReleaseLoadMore);
          _handleLoadMore();
        } else if (notification.metrics.extentAfter == 0.0) {
//          changeMode(_PullIndicatorMode.dragReleaseCancel);
        }
      }
    }

    if (notification is OverscrollNotification) {}

    if (notification is ScrollEndNotification) {
//      _dragOffset = null;
//      changeMode(null);
    }
    return false;
  }

  void _handleLoadMore() {
    if (!enableLoadMore) {
      return;
    }
    if (widget.onLoadMore != null) {
      handleResult(widget.onLoadMore());
    }
  }

  void changeMode(_PullIndicatorMode mode) {
    setState(() {
      _mode = mode;
    });
  }

  void handleResult(Future result) {
    assert(() {
      if (result == null)
        FlutterError.reportError(new FlutterErrorDetails(
          exception: new FlutterError('The onRefresh/onLoadMore callback returned null.\n'
              'The ScrollIndicator onRefresh/onLoadMore callback must return a Future.'),
          context: 'when calling onRefresh/onLoadMore',
          library: 'pdrpulm library',
        ));
      return true;
    }());
    if (result == null) return;
    result.whenComplete(() {
      if (mounted && _mode == _PullIndicatorMode.refreshing) {
        changeMode(_PullIndicatorMode.idle);
      }
      if (mounted && _mode == _PullIndicatorMode.loading) {
        changeMode(_PullIndicatorMode.idle);
      }
    });
  }
}
