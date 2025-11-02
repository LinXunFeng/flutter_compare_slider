# compare_slider

[![author](https://img.shields.io/badge/author-LinXunFeng-blue.svg?style=flat-square&logo=Iconify)](https://github.com/LinXunFeng/) [![pub](https://img.shields.io/pub/v/compare_slider?&style=flat-square&label=pub&logo=dart)](https://pub.dev/packages/compare_slider) 

一个用于比较两个 `Widget` 的 `Slider`。

[English](https://github.com/LinXunFeng/flutter_compare_slider/blob/main/README.md) | 简体中文

## ☕ 请我喝一杯咖啡

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/T6T4JKVRP) [![wechat](https://img.shields.io/static/v1?label=WeChat&message=微信收款码&color=brightgreen&style=for-the-badge&logo=WeChat)](https://cdn.jsdelivr.net/gh/FullStackAction/PicBed@resource20220417121922/image/202303181116760.jpeg)

微信技术交流群请看: [【微信群说明】](https://mp.weixin.qq.com/s/JBbMstn0qW6M71hh-BRKzw)

![](https://raw.githubusercontent.com/LinXunFeng/flutter_assets/main/flutter_compare_slider/1.gif)

🕹 在线预览: [https://linxunfeng.github.io/flutter_compare_slider/](https://linxunfeng.github.io/flutter_compare_slider/)

## 📦 安装

将以下内容添加到您的包的 `pubspec.yaml` 文件中：

```yaml
dependencies:
  compare_slider: latest_version
```

然后运行：

```bash
flutter pub get
```

## 🚀 使用

导入：

```dart
import 'package:compare_slider/compare_slider.dart';
```

用法示例：

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

## 🎨 自定义
您可以通过以下参数自定义此组件：

| 参数 | 类型 | 描述 |
|---|---|---|
| `dragOnlyOnSlider` | `bool` | 定义拖动行为（默认为全区域拖动）。<br/>`false`：允许在整个组件区域内拖动。<br/>`true`：仅限于滑块手柄拖动。 |
| `value` | `double` | 滑块的当前值。 |
| `before` | `Widget` | 滑块“之前”侧显示的组件。 |
| `after` | `Widget` | 滑块“之后”侧显示的组件。 |
| `thumb` | `Widget` | 滑块手柄组件。 |
| `thickness` | `double` | 滑块的厚度。 |
| `onValueChanged` | `ValueChanged<double>` | 滑块值改变时触发的回调。 |
| `onSliderThumbTouchBegin` | `VoidCallback?` | 滑块手柄被触摸时触发的回调。<br/>当 `dragOnlyOnSlider` 为 `true` 时，仅在拖动滑块手柄时触发；否则，在组件任意位置拖动时触发。 |
| `onSliderThumbTouchEnd` | `VoidCallback?` | 滑块手柄触摸结束时触发的回调。<br/>当 `dragOnlyOnSlider` 为 `true` 时，仅在滑块手柄拖动结束时触发；否则，在组件任意位置拖动结束时触发。 |
| `onSliderDragEnd` | `Function(CompareSliderDragEndResult)?` | 滑块拖动操作结束时触发的回调。 |
| `extraHitTestArea` | `EdgeInsets` | 扩展滑块手柄的点击测试区域（当 `dragOnlyOnSlider` 为 `true` 时生效）。 |
| `debugHitTestAreaColor` | `Color?` | 扩展点击测试区域的颜色（当 `dragOnlyOnSlider` 为 `true` 时生效，用于调试）。 |

## 🧑‍💻 关于我

- GitHub: [https://github.com/LinXunFeng](https://github.com/LinXunFeng)
- Email: [linxunfeng@yeah.net](mailto:linxunfeng@yeah.net)
- Blogs: 
  - 全栈行动: [https://fullstackaction.com](https://fullstackaction.com)
  - 掘金: [https://juejin.cn/user/1820446984512392](https://juejin.cn/user/1820446984512392) 

<img height="267.5" width="481.5" src="https://github.com/LinXunFeng/LinXunFeng/raw/master/static/img/FSAQR.png"/>
