import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:ui' show lerpDouble;

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class NaviPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new AppBarBottomSample();
  }

  const NaviPage();
}

// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

class AppBarBottomSample extends StatefulWidget {
  @override
  _AppBarBottomSampleState createState() => new _AppBarBottomSampleState();
}

class _AppBarBottomSampleState extends State<AppBarBottomSample> with SingleTickerProviderStateMixin, _PressPage {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: choices.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _nextPage(int delta) {
    final int newIndex = _tabController.index + delta;
    if (newIndex < 0 || newIndex >= _tabController.length) return;
    _tabController.animateTo(newIndex);
  }


  @override
  void click(int page) {
    choicePage(page);
  }

  choicePage(int page) {
    if (page < 0 || page >= _tabController.length) return;
    _tabController.animateTo(page);
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('AppBar Bottom Widget'),
          leading: new IconButton(
            tooltip: 'Previous choice',
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              _nextPage(-1);
            },
          ),
          actions: <Widget>[
            new IconButton(
              icon: const Icon(Icons.arrow_forward),
              tooltip: 'Next choice',
              onPressed: () {
                _nextPage(1);
              },
            ),
          ],
          bottom: new PreferredSize(
            preferredSize: const Size.fromHeight(48.0),
            child: new Theme(
              data: Theme.of(context).copyWith(accentColor: Colors.white),
              child: new Container(
                height: 48.0,
                alignment: Alignment.center,
                child: new _TabPageSelector(
                  onPress: this,
                  controller: _tabController,
                  indicatorSize: 15.0,
                ),
              ),
            ),
          ),
        ),
        body: new TabBarView(
          controller: _tabController,
          children: choices.map((Choice choice) {
            return new Padding(
              padding: const EdgeInsets.all(16.0),
              child: new ChoiceCard(choice: choice),
            );
          }).toList(),
        ),
      ),
    );
  }

  void onClick() {
    print("onClick");
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'CAR', icon: Icons.directions_car),
  const Choice(title: 'BICYCLE', icon: Icons.directions_bike),
  const Choice(title: 'BOAT', icon: Icons.directions_boat),
  const Choice(title: 'BUS', icon: Icons.directions_bus),
  const Choice(title: 'TRAIN', icon: Icons.directions_railway),
  const Choice(title: 'WALK', icon: Icons.directions_walk),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme
        .of(context)
        .textTheme
        .display1;
    return new Card(
      color: Colors.white,
      child: new Center(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Icon(choice.icon, size: 128.0, color: textStyle.color),
            new Text(choice.title, style: textStyle),
          ],
        ),
      ),
    );
  }
}

// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.


double _indexChangeProgress(TabController controller) {
  final double controllerValue = controller.animation.value;
  final double previousIndex = controller.previousIndex.toDouble();
  final double currentIndex = controller.index.toDouble();

  // The controller's offset is changing because the user is dragging the
  // TabBarView's PageView to the left or right.
  if (!controller.indexIsChanging)
    return (currentIndex - controllerValue).abs().clamp(0.0, 1.0);

  // The TabController animation's value is changing from previousIndex to currentIndex.
  return (controllerValue - currentIndex).abs() / (currentIndex - previousIndex).abs();
}


/// Displays a row of small circular indicators, one per tab. The selected
/// tab's indicator is highlighted. Often used in conjunction with a [TabBarView].
///
/// If a [TabController] is not provided, then there must be a [DefaultTabController]
/// ancestor.
class _TabPageSelector extends StatelessWidget {
  /// Creates a compact widget that indicates which tab has been selected.
  const _TabPageSelector({
    Key key,
    this.controller,
    this.indicatorSize: 12.0,
    this.color,
    this.selectedColor,
    this.onPress,
  })
      : assert(indicatorSize != null && indicatorSize > 0.0),
        super(key: key);

  /// This widget's selection and animation state.
  ///
  /// If [TabController] is not provided, then the value of [DefaultTabController.of]
  /// will be used.
  final TabController controller;

  /// The indicator circle's diameter (the default value is 12.0).
  final double indicatorSize;

  /// The indicator circle's fill color for unselected pages.
  ///
  /// If this parameter is null then the indicator is filled with [Colors.transparent].
  final Color color;

  /// The indicator circle's fill color for selected pages and border color
  /// for all indicator circles.
  ///
  /// If this parameter is null then the indicator is filled with the theme's
  /// accent color, [ThemeData.accentColor].
  final Color selectedColor;

  final _PressPage onPress;

  Widget _buildTabIndicator(int tabIndex,
      TabController tabController,
      ColorTween selectedColorTween,
      ColorTween previousColorTween,) {
    Color background;
    if (tabController.indexIsChanging) {
      // The selection's animation is animating from previousValue to value.
      final double t = 1.0 - _indexChangeProgress(tabController);
      if (tabController.index == tabIndex)
        background = selectedColorTween.lerp(t);
      else if (tabController.previousIndex == tabIndex)
        background = previousColorTween.lerp(t);
      else
        background = selectedColorTween.begin;
    } else {
      // The selection's offset reflects how far the TabBarView has / been dragged
      // to the previous page (-1.0 to 0.0) or the next page (0.0 to 1.0).
      final double offset = tabController.offset;
      if (tabController.index == tabIndex) {
        background = selectedColorTween.lerp(1.0 - offset.abs());
      } else if (tabController.index == tabIndex - 1 && offset > 0.0) {
        background = selectedColorTween.lerp(offset);
      } else if (tabController.index == tabIndex + 1 && offset < 0.0) {
        background = selectedColorTween.lerp(-offset);
      } else {
        background = selectedColorTween.begin;
      }
    }
    return new InkResponse(
      onTap: () {
        onPress.click(tabIndex);
      },
      child: new TabPageSelectorIndicator(
        backgroundColor: background,
        borderColor: selectedColorTween.end,
        size: indicatorSize,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color fixColor = color ?? Colors.transparent;
    final Color fixSelectedColor = selectedColor ?? Theme
        .of(context)
        .accentColor;
    final ColorTween selectedColorTween = new ColorTween(begin: fixColor, end: fixSelectedColor);
    final ColorTween previousColorTween = new ColorTween(begin: fixSelectedColor, end: fixColor);
    final TabController tabController = controller ?? DefaultTabController.of(context);
    assert(() {
      if (tabController == null) {
        throw new FlutterError('No TabController for $runtimeType.\n'
            'When creating a $runtimeType, you must either provide an explicit TabController '
            'using the "controller" property, or you must ensure that there is a '
            'DefaultTabController above the $runtimeType.\n'
            'In this case, there was neither an explicit controller nor a default controller.');
      }
      return true;
    }());
    final Animation<double> animation = new CurvedAnimation(
      parent: tabController.animation,
      curve: Curves.fastOutSlowIn,
    );
    return new AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget child) {
          return new Semantics(
            label: 'Page ${tabController.index + 1} of ${tabController.length}',
            child: new Row(
              mainAxisSize: MainAxisSize.min,
              children: new List<Widget>.generate(tabController.length, (int tabIndex) {
                return _buildTabIndicator(tabIndex, tabController, selectedColorTween, previousColorTween);
              }).toList(),
            ),
          );
        });
  }
}

abstract class _PressPage {
  void click(int page);
}
