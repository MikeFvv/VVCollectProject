# 注意事项、常用类介绍

#### 介绍

1. 创建项目勾选Test 部分
MXW 为前缀





#### 类介绍
@required 必须类    @optional  可选类

特殊的
MFHInjectionIIIHelper    实时更新UI


@required
 UIColor+Hex        颜色类
NSDictionary+Log        打印台
PrintBeautifulLog       可以正常在控制台输出中文
 NSString+Size      计算Label 尺寸
 MXWAdapter      适配相关
 MFHTimeManager     时间相关处理类
 MMVersionControlManager   弹出更新版本提示类、 判断版本
 MXWDataTypeConversionManager    数据类型转换
 
 

@optional
NSString+RegexCategory      正则相关
UIResponder+Router      路由器 事件相关
FunctionManager         一些散装封装方法
XHNetworkCache   缓存数据
VVAlert     系统弹窗
UIView+WZB   画表格
























## Swift 开发编码规范

```Swift
主要是参考和保留一些 Objective-C 开发编码规范的一些规则
```
- 重要说明
    - 从代码库中 check out 到代码之后先 安装 第三方 框架
    - 终端 进入到 NWF.xcworkspace 同层文件夹中 执行 pod install

---


### 一. 开发使用到的语言

1. 主要使用 Swift
* Objective-C



---

### 二. 项目结构说明

```Swift
项目的第三方库以CocoaPods工具管理，安装好CocoaPods后使用.xcworkspace打开项目
```

** 一级目录说明 **

1. Class: 存放源代码
2. Default: 存放宏定义/静态参数
3. Bridge: 存放桥接文件, Swift 与 Objective-C 的桥接文件
4. Resource: 存放资源文件,图片、音频、plist 等
5. ThirdFramework: 存放第三方资源（某些不能通过cocoapods管理的库）
6. Localizable.strings 代码字符串本地化
7. InfoPlist.strings 应用名称本地化

**二级目录说明**

1. **Class: 存放源代码**
* CommonView 公用view
* ViewController 主要是控制器有关的类
* ViewModel 视图模型
* View 视图
* Model 模型
* Data 储存在本地plist文件
* Enum 枚举
* Extension 所有拓展Category)
* Protocol 协议、代理
* SingleObject 单例对象
* Tools 工具类

2. **Defautl 宏定义/ 全局/ 常量 (命名规则: 前缀+作用/位置(+其他))**

* 杂项 (前缀: Common)
* 路径 (前缀: Path)
* 文字大小 字号 (前缀: font)
* 尺寸大小 宽/高/间距 (前缀: size)
* 全局色值 (前缀: color)
* 图片名称 (前缀: image)
* URL 接口 (前缀: url)
* 通知名称 (前缀: notice)

3. **Bridge 桥接文件**

* Bridge.h 桥接 OC 代码
* NWF.swift 取代 OC 中的 pch 文件的全局宏定义

4. **JSCode(JS文件)**

* NWF_Native.js 注入到webview

- Resource 图片、音频、plist 等
- Localizable.strings 代码字符串本地化

1. Localizable.strings(English) 英文
* Localizable.strings(Simplified) 简体中文
* Localizable.strings(Tradtional) 繁體中文
- InfoPlist.strings 应用名称本地化

1. Localizable.strings(English) 英文
* Localizable.strings(Simplified) 简体中文
* Localizable.strings(Tradtional) 繁體中文

---

### 三. 项目命名规则

**一.文件命名规则**

1. 控制器: 前缀 `NWF_` + 功能/作用 (+ 其他) + 类型

```Swift
首页控制器 : NWF_HomeViewController.swift
```

* view: 前缀 `NWF_` + 功能/作用(+ 其他) + 类型

```Swift
NWF_DoubleTableView.swift
```

* Model: 前缀 `NWF_` + 功能/作用(+ 其他) + Model

```Swift
NWF_BaseModel.swift
```

* Extension : 类名 + `+/-` + Extension

```Swift
UIButton-Extension.swift
UIView+Extension.swift
```

* Protocol : 前缀 `NWF_` + 类名(+ 其他) + Protocol/Delegate/DataSource

```Swift
NWF_DictModelProtocol.swift
NWF_DoubleTableViewDataSource.swift
NWF_DoubleTableViewDelegate.swift
```


**二.变量命名规则**

1. 全局变量命名规则: `font/size/color/url/img/notic + 位置/作用(+其他)`

```Swift
字体大小: fontNavTitle
高度尺寸: sizeNavigationH
全局背景色: colorAPPBackground
按钮图标: imgNavLeftBackButton
通知 : noticHomeTableHeadViewHeightDidChange
```
* 成员属性命名规则: `作用/功能/位置 + 其他 + 类型`

```Swift
// 懒加载控件 (属性 后面的 +View 表示是 View 类型)
fileprivate lazy var noticeView : NWF_NoticView = {[weak self] in
}()
// 懒加载控制器属性 (后面的 +VC 表示控制器类型)
lazy var regionVC : NWF_RegionViewController = {[weak self] in
}()
// 控件尽量使用 weak 修饰, 上面两个例子都未使用到 weak 修饰,
// 通过 XIB 或者 storyboard 加载的控件 (属性名称后面的 +Label 表示对应的类型)
@IBOutlet weak var subTitleLabel: UILabel!
```

**三.函数/方法命名规则**

1. 函数 命名规则: nwf + Func + 功能作用 + 其他参数 ...

> 在很多场合仍然需要用到函数，比如说如果一个对象是一个单例，那么应该使用函数来代替类方法执行相关操作。
> 函数的命名和方法有一些不同，主要是：
> * 函数名称一般带有缩写前缀，表示方法所在的框架。
> * 前缀后的单词以 “ 驼峰 ” 表示法显示，第一个单词首字母大写。
> * 函数名的第一个单词通常是一个动词，表示方法执行的操作：

```Swift
// 前缀 nwfFunc + 功能 Font + 其他 withPx
// 通过像素转出文字大小
func nwfFuncFontWithPx(_ px : CGFloat) -> CGFloat
```

* 方法 命名规则: (nwf +) 功能作用 + 其他参数 ...

```Swift
// 设置右边 客服按钮 (带有 set 避免与 setter 方法冲突, 因此要添加 前缀)
fileprivate func nwfSetRightServiceButton()
// 按钮点击事件调用的方法
命名规则: 按钮名称 + Click
传递参数: sender
@objc fileprivate func rightServiceButtonClick(_ sender : UIButton)
```
* **注意: 类扩展的方法必须有前缀 nwf 避免与UIKit 框架提供的方法冲突**
```Swift
// 个原有的 NSString 类型添加 : 根据文字大小计算字符串尺寸的方法
func nwfSizeWithFont(_ font : UIFont?) -> CGSize {}
```
**四.协议/代理**

1. 协议代理方法

- 一个类的 Delegate 对象通常还引用着类本身，这样很容易造成引用循环的问题，所以类的 Delegate 属性要设置为弱引用, 可选型.

```Swift
// MARK: - 代理属性
weak var delegate : UITableViewDelegate?
```
- 当特定的事件发生时，对象会触发它注册的委托方法。委托是 iOS 中常用的传递消息的方式。委托有它固定的命名范式。一个委托方法的第一个参数是触发它的对象，第一个关键词是触发对象的类名，除非委托方法只有一个名为 sender 的参数：

```swift
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {}
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {}
```
- 根据委托方法触发的时机和目的，使用 should,will,did 等关键词
```Swift
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
```
