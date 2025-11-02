# compare_slider

[![author](https://img.shields.io/badge/author-LinXunFeng-blue.svg?style=flat-square&logo=Iconify)](https://github.com/LinXunFeng/) [![pub](https://img.shields.io/pub/v/compare_slider?&style=flat-square&label=pub&logo=dart)](https://pub.dev/packages/compare_slider) 

A slider that allows users to compare two widgets.

English | [简体中文](https://github.com/LinXunFeng/flutter_compare_slider/blob/main/README-zh.md)

## ☕ Support me

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/T6T4JKVRP) [![wechat](https://img.shields.io/static/v1?label=WeChat&message=WeChat&nbsp;Pay&color=brightgreen&style=for-the-badge&logo=WeChat)](https://cdn.jsdelivr.net/gh/FullStackAction/PicBed@resource20220417121922/image/202303181116760.jpeg)

Chat: [Join WeChat group](https://mp.weixin.qq.com/s/JBbMstn0qW6M71hh-BRKzw)

## 📦 Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  compare_slider: latest_version
```

Then run:

```bash
flutter pub get
```

## 🚀 Usage

Import it:

```dart
import 'package:compare_slider/compare_slider.dart';
```

Use it:

```dart
double value = 0.5;

CompareSlider(
  value: value,
  before: _buildImageView(isBefore: true),
  after: _buildImageView(isBefore: false),
  thickness: 1,
  thumb: _buildThumb(),
  onValueChanged: (double value) {
    this.value = value;
    setState(() {});
  },
);
```

## 🎨 Customization
You can customize the widget with the following parameters:

| Parameter | Type | Description |
|---|---|---|
| `dragOnlyOnSlider` | `bool` | Defines the drag behavior (defaults to full area dragging). <br/>`false`: Enables dragging across the entire component area. `true`: Restricts dragging to the slider thumb only. |
| `value` | `double` | The current value of the slider. |
| `before` | `Widget` | The widget displayed on the 'before' side of the slider. |
| `after` | `Widget` | The widget displayed on the 'after' side of the slider. |
| `thumb` | `Widget` | The slider thumb widget. |
| `thickness` | `double` | The thickness of the slider. |
| `onValueChanged` | `ValueChanged<double>` | Callback invoked when the slider's value changes. |
| `onSliderThumbTouchBegin` | `VoidCallback?` | Callback invoked when the slider thumb is touched. <br/>This callback is triggered only when dragging the slider thumb if `dragOnlyOnSlider` is true; otherwise, it's triggered when dragging anywhere on the component. |
| `onSliderThumbTouchEnd` | `VoidCallback?` | Callback invoked when the slider thumb touch ends. <br/>This callback is triggered only when the slider thumb drag ends if `dragOnlyOnSlider` is true; otherwise, it's triggered when dragging anywhere on the component ends. |
| `onSliderDragEnd` | `Function(CompareSliderDragEndResult)?` | Callback invoked when the slider drag operation ends. |
| `extraHitTestArea` | `EdgeInsets` | Expands the hit-test area for the slider thumb (effective when `dragOnlyOnSlider` is true). |
| `debugHitTestAreaColor` | `Color?` | The color of the expanded hit-test area (effective when `dragOnlyOnSlider` is true, for debugging purposes). |

## 🧑‍💻 About Me

- GitHub: [https://github.com/LinXunFeng](https://github.com/LinXunFeng)
- Email: [linxunfeng@yeah.net](mailto:linxunfeng@yeah.net)
- Blogs: 
  - 全栈行动: [https://fullstackaction.com](https://fullstackaction.com)
  - 掘金: [https://juejin.cn/user/1820446984512392](https://juejin.cn/user/1820446984512392) 

<img height="267.5" width="481.5" src="https://github.com/LinXunFeng/LinXunFeng/raw/master/static/img/FSAQR.png"/>

