import 'package:compare_slider/compare_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CompareSlider renders correctly with initial value',
      (WidgetTester tester) async {
    double initialValue = 0.5;
    Key thumbKey = UniqueKey();
    double thumbSize = 10;
    double thickness = 1;
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: CompareSlider(
          value: initialValue,
          before: Container(color: Colors.red),
          after: Container(color: Colors.blue),
          thickness: thickness,
          thumb: Container(
            key: thumbKey,
            width: thumbSize,
            height: thumbSize,
            color: Colors.green,
          ),
          onValueChanged: (value) {},
        ),
      ),
    );

    final sliderFinder = find.byType(CompareSlider);
    expect(sliderFinder, findsOneWidget);

    final thumbFinder = find.byKey(thumbKey);
    expect(thumbFinder, findsOneWidget);

    final sliderRect = tester.getRect(sliderFinder);
    final thumbRect = tester.getRect(thumbFinder);
    expect((sliderRect.size.width - thickness) / 2, thumbRect.left);
  });

  testWidgets('onValueChanged callback is triggered on drag',
      (WidgetTester tester) async {
    double currentValue = 0.5;
    double? changedValue;
    double thickness = 1;

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: CompareSlider(
          value: currentValue,
          before: Container(color: Colors.red),
          after: Container(color: Colors.blue),
          thickness: thickness,
          thumb: Container(
            width: thickness,
            height: 10,
            color: Colors.green,
          ),
          onValueChanged: (value) {
            changedValue = value;
          },
        ),
      ),
    );

    final sliderFinder = find.byType(CompareSlider);
    expect(sliderFinder, findsOneWidget);

    // Simulate dragging from the center to the right
    await tester.drag(sliderFinder, Offset(50, 0));
    await tester.pumpAndSettle();

    expect(changedValue, isNotNull);
    expect(changedValue, greaterThan(currentValue));
  });

  testWidgets(
      'onSliderThumbTouchBegin and onSliderThumbTouchEnd callbacks are triggered',
      (WidgetTester tester) async {
    bool touchBegin = false;
    bool touchEnd = false;
    double thickness = 1;

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: CompareSlider(
          value: 0.5,
          before: Container(color: Colors.red),
          after: Container(color: Colors.blue),
          thickness: thickness,
          thumb: Container(width: thickness, height: 10, color: Colors.green),
          onValueChanged: (value) {},
          onSliderThumbTouchBegin: () {
            touchBegin = true;
          },
          onSliderThumbTouchEnd: () {
            touchEnd = true;
          },
        ),
      ),
    );

    final sliderFinder = find.byType(CompareSlider);
    expect(sliderFinder, findsOneWidget);

    // Simulate drag gesture
    await tester.timedDragFrom(
      tester.getCenter(sliderFinder),
      const Offset(50, 0),
      const Duration(milliseconds: 100),
    );
    await tester.pumpAndSettle();

    expect(touchBegin, isTrue);
    expect(touchEnd, isTrue);
  });

  testWidgets('onSliderDragEnd callback is triggered with correct values',
      (WidgetTester tester) async {
    CompareSliderDragEndResult? dragEndResult;
    double value = 0.5;
    double thickness = 1;

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: StatefulBuilder(builder: (context, setState) {
          return CompareSlider(
            value: value,
            before: Container(color: Colors.red),
            after: Container(color: Colors.blue),
            thickness: thickness,
            thumb: Container(
              width: thickness,
              height: 10,
              color: Colors.green,
            ),
            onValueChanged: (newValue) async {
              setState(() {
                value = newValue;
              });
            },
            onSliderDragEnd: (result) {
              dragEndResult = result;
            },
          );
        }),
      ),
    );

    final sliderFinder = find.byType(CompareSlider);
    expect(sliderFinder, findsOneWidget);

    // Simulate drag gesture
    await tester.timedDragFrom(
      tester.getCenter(sliderFinder),
      const Offset(50, 0),
      const Duration(milliseconds: 100),
    );
    await tester.pumpAndSettle();

    expect(dragEndResult, isNotNull);
    expect(dragEndResult!.valueDragBefore, 0.5);
    expect(dragEndResult!.valueDragAfter, greaterThan(0.5));
  });

  testWidgets('dragOnlyOnSlider true prevents dragging outside thumb',
      (WidgetTester tester) async {
    double currentValue = 0.5;
    double? changedValue;
    double thickness = 1;
    Key thumbKey = UniqueKey();

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: StatefulBuilder(builder: (context, setState) {
          return CompareSlider(
            value: currentValue,
            dragOnlyOnSlider: true,
            before: Container(color: Colors.red),
            after: Container(color: Colors.blue),
            thickness: thickness,
            thumb: Container(
              key: thumbKey,
              width: thickness,
              height: 50,
              color: Colors.green,
            ),
            onValueChanged: (value) {
              setState(() {
                changedValue = value;
              });
            },
          );
        }),
      ),
    );

    final sliderFinder = find.byType(CompareSlider);
    expect(sliderFinder, findsOneWidget);

    // Obtain the bounding box of the CompareSlider
    final sliderRect = tester.getRect(sliderFinder);
    // Attempt to drag from an area to the left of the slider (distant from the
    // slider's center).
    // Start dragging from sliderRect.left + 10, which is intended to be outside
    // the slider's interactive area.
    await tester.dragFrom(Offset(sliderRect.left + 10, sliderRect.center.dy),
        Offset(sliderRect.left + 60, sliderRect.center.dy));
    await tester.pumpAndSettle();
    expect(changedValue, isNull);

    final thumbFinder = find.byKey(thumbKey);
    expect(thumbFinder, findsOneWidget);
    // Attempt to drag from an area inside the thumb.
    await tester.timedDragFrom(
      tester.getCenter(thumbFinder),
      const Offset(50, 0),
      const Duration(milliseconds: 100),
    );
    await tester.pumpAndSettle();
    expect(changedValue, isNotNull);
  });

  testWidgets('dragOnlyOnSlider false allows dragging anywhere',
      (WidgetTester tester) async {
    double currentValue = 0.5;
    double thickness = 1;
    double? changedValue;

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: StatefulBuilder(builder: (context, setState) {
          return CompareSlider(
            value: currentValue,
            dragOnlyOnSlider: false,
            before: Container(color: Colors.red),
            after: Container(color: Colors.blue),
            thickness: thickness,
            thumb: Container(
              width: thickness,
              height: 50,
              color: Colors.green,
            ),
            onValueChanged: (value) {
              setState(() {
                changedValue = value;
              });
            },
          );
        }),
      ),
    );

    final sliderFinder = find.byType(CompareSlider);
    expect(sliderFinder, findsOneWidget);

    final sliderRect = tester.getRect(sliderFinder);

    // Attempt to drag from an area outside the slider
    await tester.dragFrom(
        Offset(sliderRect.size.width / 2 + 60, sliderRect.center.dy),
        Offset(sliderRect.size.width / 2 + 90, sliderRect.center.dy));
    await tester.pumpAndSettle();

    expect(changedValue, isNotNull);
    expect(changedValue, greaterThan(currentValue));
  });
}
