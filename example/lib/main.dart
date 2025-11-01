import 'package:compare_slider/compare_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Compare Slider'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double value = 0.5;

  late double valueDragBefore = value;

  late double valueDragAfter = value;

  double sliderWidth = 1;

  double sliderThumbSize = 50;

  double multipleSpeed = 8;

  bool dragOnlyOnSlider = true;

  bool showDebugHitTestAreaColor = false;

  String onSliderTouchStatus = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('dragOnlyOnSlider'),
            trailing: Switch(
              value: dragOnlyOnSlider,
              onChanged: (newValue) {
                dragOnlyOnSlider = newValue;
                setState(() {});
              },
            ),
          ),
          if (kDebugMode)
            ListTile(
              title: Text('showDebugHitTestAreaColor'),
              trailing: Switch(
                value: showDebugHitTestAreaColor,
                onChanged: (newValue) {
                  showDebugHitTestAreaColor = newValue;
                  setState(() {});
                },
              ),
            ),
          Divider(),
          _buildCompareSlider(),
          ListTile(title: Text('onSliderTouch: $onSliderTouchStatus')),
          ListTile(title: _buildValueText()),
        ],
      ),
      floatingActionButton: FloatingActionButton.small(
        child: Icon(Icons.refresh),
        onPressed: () {
          value = 0.5;
          valueDragBefore = value;
          valueDragAfter = value;
          setState(() {});
        },
      ),
    );
  }

  Widget _buildCompareSlider() {
    Widget resultWidget = CompareSlider(
      value: value,
      dragOnlyOnSlider: dragOnlyOnSlider,
      before: _buildImageView(isBefore: true),
      after: _buildImageView(isBefore: false),
      thumb: _buildSlider(),
      extraHitTestArea: EdgeInsets.symmetric(horizontal: sliderThumbSize / 2),
      debugHitTestAreaColor: Colors.red.withValues(
        alpha: showDebugHitTestAreaColor ? 0.2 : 0,
      ),
      onValueChanged: (double value) {
        this.value = value;
        setState(() {});
      },
      onSliderThumbTouchBegin: () {
        onSliderTouchStatus = 'begin';
        setState(() {});
      },
      onSliderThumbTouchEnd: () {
        onSliderTouchStatus = 'end';
        setState(() {});
      },
      onSliderDragEnd: (result) {
        valueDragBefore = result.valueDragBefore;
        valueDragAfter = result.valueDragAfter;
        setState(() {});
      },
    );
    resultWidget = ClipRRect(clipBehavior: Clip.hardEdge, child: resultWidget);
    return resultWidget;
  }

  Widget _buildSlider() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        _buildSliderLine(),
        Positioned(
          left: -(sliderThumbSize - sliderWidth) / 2,
          child: _buildSliderThumb(),
        ),
      ],
    );
  }

  Widget _buildSliderLine() {
    return Container(
      width: sliderWidth,
      color: Colors.white.withValues(alpha: 0.5),
    );
  }

  Widget _buildSliderThumb() {
    Widget resultWidget = Image.asset(
      'assets/thumb.png',
      width: sliderThumbSize,
      height: sliderThumbSize,
    );
    resultWidget = Transform.rotate(
      angle: value * 2 * math.pi * multipleSpeed,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: 0.5),
        ),
        child: resultWidget,
      ),
    );
    return resultWidget;
  }

  Widget _buildImageView({required bool isBefore}) {
    final screenWidth = MediaQuery.widthOf(context);
    double imageSize = math.min(screenWidth, 445);

    Widget resultWidget = Image.asset(
      '''assets/${isBefore ? 'before.jpeg' : 'after.jpg'}''',
      width: imageSize,
      height: imageSize,
    );
    resultWidget = Stack(
      alignment: isBefore ? Alignment.centerLeft : Alignment.centerRight,
      children: [
        resultWidget,
        Positioned(
          child: IconButton(
            onPressed: () {
              value = isBefore ? 0 : 1;
              setState(() {});
            },
            icon: Icon(
              isBefore
                  ? Icons.keyboard_double_arrow_left_rounded
                  : Icons.keyboard_double_arrow_right_rounded,
              size: 20,
            ),
            color: Colors.white.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
    return resultWidget;
  }

  Widget _buildValueText() {
    final int fractionDigits = 2;
    final before = valueDragBefore.toStringAsFixed(fractionDigits);
    final current = value.toStringAsFixed(fractionDigits);
    final after = valueDragAfter.toStringAsFixed(fractionDigits);
    return Text('before: $before, current: $current, after: $after');
  }
}
