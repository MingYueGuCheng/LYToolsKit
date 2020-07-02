# LYToolsKit

[![CI Status](https://img.shields.io/travis/yyly/LYToolsKit.svg?style=flat)](https://travis-ci.org/yyly/LYToolsKit)
[![Version](https://img.shields.io/cocoapods/v/LYToolsKit.svg?style=flat)](https://cocoapods.org/pods/LYToolsKit)
[![License](https://img.shields.io/cocoapods/l/LYToolsKit.svg?style=flat)](https://cocoapods.org/pods/LYToolsKit)
[![Platform](https://img.shields.io/cocoapods/p/LYToolsKit.svg?style=flat)](https://cocoapods.org/pods/LYToolsKit)

## 功能
* Foundation
1. URL解析｜URL编码｜URL参数拼接
1. 对象Hook方法
1. 常用时间处理
1. 常用JS脚本
1. KB-MB-GB转换

* UI
1. 图片压缩｜图片放缩
1. View快捷构建
1. 16进制颜色值
1. 获取设备信息
1. 获取网络信息
1. 获取运营商信息
1. 获取导航栏、状态栏、底部UITabBar高度

* Utility
1. 封装Alert弹框
1. 屏幕显示触摸痕迹
1. 轻量级缓存管理
1. 订阅管理
1. 超链接按钮
1. 悬浮按钮
1. 倒计时Label

## 说明
LYToolsKit 是一个轻量级的常用组件库，对Foundation、UI简单扩展，可以极大的提高开发效率。
```
维护注意：
1. 本库前缀为【LY】
2. 分类中的方法需要以【ly_】开始
3. 尽量标明方法的用途
4. 禁止重复用途的方法
5. 各个子库之间不可以相互依赖
6. 禁止依赖第三方库
7. 注明返回值、参数是否为空
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

LYToolsKit is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'LYToolsKit'
```

## Author

yyly, mingyuegucheng@icloud.com

## License

LYToolsKit is available under the MIT license. See the LICENSE file for more info.

## 关于命令
```提交新版到cocoapods
pod trunk push LYToolsKit.podspec --allow-warnings
```

