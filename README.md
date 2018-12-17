# LYToolsKit

[![CI Status](https://img.shields.io/travis/yyly/LYToolsKit.svg?style=flat)](https://travis-ci.org/yyly/LYToolsKit)
[![Version](https://img.shields.io/cocoapods/v/LYToolsKit.svg?style=flat)](https://cocoapods.org/pods/LYToolsKit)
[![License](https://img.shields.io/cocoapods/l/LYToolsKit.svg?style=flat)](https://cocoapods.org/pods/LYToolsKit)
[![Platform](https://img.shields.io/cocoapods/p/LYToolsKit.svg?style=flat)](https://cocoapods.org/pods/LYToolsKit)

## 功能
```工具组件
时间处理，JS脚本，KB-MB-GB转换，URL解析，URL参数拼接，URL编码，Alert弹框，设备信息，网络信息，操作轴迹，View快捷构建，图片压缩，图片放缩，倒计时，hook方法，运营商信息
```

## 说明
LYToolsKit 是一个轻量级的常用组件库，包含Foundation、UI等简单扩展，可以极大的提高开发效率。
```
维护注意：
1. 本库前缀为【LY】
2. 分类中的方法需要以【ly_】开始
3. 尽量标明方法的用途
4. 禁止重复用途的方法
5. 各个子库之间不可以相互依赖【不包含：Utility库】
6. 注明返回值、参数是否为空
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

