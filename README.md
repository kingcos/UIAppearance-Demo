# UIAppearance-Demo

- [我的简书](http://www.jianshu.com/u/b88081164fe8)
- [我的博客](https://maimieng.com)

> UIAppearance in Swift

- Info:
 - Swift 3.0
 - Xcode 8.2.1

## 前言

UIAppearance，即用户界面外观，是 iOS 中 UIKit 的一个协议。外观对于用户体验是至关重要的一点，NSHipster 的 Mattt Thompson 在 UIAppearance 一文中说：**Users will pay a premium for good-looking software.**（用户乐意为高颜值的软件额外付费）。

使用 UIAppearance 协议可以得到一个类的外观代理（proxy）。我们可以调用类的外观代理来更简单地自定义一个实例的外观。不过由于官方文档仍是 Objective-C 的例子，这里就总结一下 Swift 中的使用。这里为了方便演示，我创建了一个 Demo，您可以在 [kingcos/UIAppearance-Demo](https://github.com/kingcos/UIAppearance-Demo) 下载，并在 Xcode 中运行。

该 Demo 为纯代码，不涉及 Storyboard 和 XIB。

![原始界面](http://7xkam0.com1.z0.glb.clouddn.com/blog/uiappearance_01.png)

其中自定义了两个 TabBar 控制器，MM 和 VV TabBar 控制器的初始外观（后续主要针对 TabBarItem 的修改）如下所示。

![MMTabBarController](http://7xkam0.com1.z0.glb.clouddn.com/blog/uiappearance_02.png)

![VVTabBarController](http://7xkam0.com1.z0.glb.clouddn.com/blog/uiappearance_03.png)

## 全局修改外观

全局修改即修改该类型的**所有**实例的外观。

这里的 Demo 以 `UITabBarItem` 为例，如果我们需要修改整个应用中所有的 `UITabBarItem`  外观，即全局修改，那么我们直接使用以下方法即可获取该类的外观代理，进而进行修改。注意调用该方法的为**类**，而非实例。

```swift
public static func appearance() -> Self
```

将修改外观（此处以字体大小为例）的操作放在一个方法中：

```swift
func setGlobalAppearance() {
    var attrsNormal = [String : Any]()
    attrsNormal[NSFontAttributeName] = UIFont.systemFont(ofSize: 30)
    
    UITabBarItem.appearance().setTitleTextAttributes(attrsNormal, for: UIControlState.normal)
}
```

在 `viewDidLoad` 方法中调用该方法并运行，我们即可看到两种 TabBar 控制器的 TabBarItem 的字体均受到了影响。

![MMTabBarController](http://7xkam0.com1.z0.glb.clouddn.com/blog/uiappearance_04.png)

![VVTabBarController](http://7xkam0.com1.z0.glb.clouddn.com/blog/uiappearance_05.png)

## 部分修改外观

部分修改即修改该类型的**某些**实例的外观。

在 Demo 中，我们可以使用以下方法，传入 UIAppearance 容器类型，即可修改该容器内部的相应类型实例的外观。需要注意的是，这里的参数为数组，即传入多个不同类型也是允许的。同样注意调用该方法的为**类**，而非实例。

```swift
@available(iOS 9.0, *)
public static func appearance(whenContainedInInstancesOf containerTypes: [UIAppearanceContainer.Type]) -> Self
```

将修改外观（此处以字体大小为例）的操作放在一个方法中：

```swift
func setLocalAppearance() {
    var attrsNormal = [String : Any]()
    attrsNormal[NSFontAttributeName] = UIFont.systemFont(ofSize: 30)
    
    UITabBarItem.appearance(whenContainedInInstancesOf: [MMTabBarController.self]).setTitleTextAttributes(attrsNormal, for: UIControlState.normal)
}
```

在 `viewDidLoad` 方法中调用该方法并运行，我们即可看到只有作为参数的 MMTabBarController 的 TabBarItem 的字体受到了影响。

![MMTabBarController](http://7xkam0.com1.z0.glb.clouddn.com/blog/uiappearance_06.png)

![VVTabBarController](http://7xkam0.com1.z0.glb.clouddn.com/blog/uiappearance_07.png)

## 自定义 UIView 子类的实现

通过以上的 Demo，我们可以看出，通过 UIAppearance 可以很便捷且统一的管理界面外观。系统中遵守 UIAppearance 的方法和属性可以在 [mattt/uiappearance-selector.md](https://gist.github.com/mattt/5135521) 查到，那我们如何使自定义的 UIView 类也能用 UIAppearance 管理呢？

这里以自定义按钮为例，为了方便演示，直接使用了 Demo 中跳转的两个按钮。新建一个 MMButton 的类，继承 UIButton。UIView 本身已经实现了 UIAppearance 和 UIAppearanceContainer 协议，所以我们只需要添加需要 UIAppearance 修改的属性即可。

![UIView 已实现了 UIAppearance 和 UIAppearanceContainer 协议](http://7xkam0.com1.z0.glb.clouddn.com/blog/uiappearance_08.png)

```swift
class MMButton: UIButton {
    dynamic var btnBorderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        
        set {
            layer.borderWidth = newValue
        }
    }
    
}
```

这里是以按钮的边框宽度为例，该属性为**计算属性**。同时需要在定义前加上 `dynamic`，以赋予该处 Swift 代码的**运行时（runtime）**特性。

这样便可以使用 `appearance()` 来全局修改 MMButton 的该属性：

```swift
MMButton.appearance().btnBorderWidth = CGFloat(10.0)
```

效果即如图所示：

![自定义 MMButton](http://7xkam0.com1.z0.glb.clouddn.com/blog/uiappearance_09.png)

需要注意的是，可以支持修改的属性只能为 `id`，`NSInteger`，`NSUInteger`，`CGFloat`，`CGPoint`，`CGSize`，`CGRect`，`UIEdgeInsets` 或 `UIOffset`（官方提供的均为 Objective-C 类型）。

> 极端特殊的情况下，你也可以参考文末的 UIAppearance proxy for custom objects，其中 LombaX 提供了继承自 NSObject 的普通类的 appearance 实现。由于 UIAppearance 多用于 UIView 的子类，所以本文不再探究，但给出参考。

## 总结

使用 UIAppearance 协议可以很方便的自定义外观。当然，UIAppearance 并不是外观修改的唯一选择。在 Mattt Thompson 的 UIAppearance 一文中也提到了几个替代 UIAppearance 的第三方库，通过把样式和内容分开（很像 CSS 和 HTML 的关系）来定义外观，更加清晰。在为 App 开发主题抑或是夜间模式时，也可以选择轻量级颜色框架 [ViccAlexander/Chameleon](https://github.com/ViccAlexander/Chameleon)，其已经在 GitHub 上拿到了超过 7000+ Stars。

UIAppearance 中还有两个方法本文没有涉及：

```swift
static func appearance(for: UITraitCollection, whenContainedInInstancesOf: [UIAppearanceContainer.Type])
static func appearance(whenContainedInInstancesOf: [UIAppearanceContainer.Type])
```

这两个方法是关于 Trait Collection，和多屏适配相关。目前这块的相关中文资料不是太多，我会找时间进行搜索、总结，届时再与大家分享。

另外本文略有涉及 Swift 和 Objective-C 的兼容，`dynamic` 关键字便可以保证和 Objective-C 里动态调用时相同的**运行时（runtime）**特性。为大家所熟知的还有 `@objc`，关于这两者（`dynamic` & `@objc`）的区别，您可以参考文末中喵神的 @OBJC 和 DYNAMIC。

## 参考资料

- [UIAppearance - Apple Inc.](https://developer.apple.com/reference/uikit/uiappearance)
- [UIAppearanceContainer - Apple Inc.](https://developer.apple.com/reference/uikit/uiappearancecontainer)
- [UIAppearance - NSHipster](http://nshipster.com/uiappearance/)
- [mattt/uiappearance-selector.md](https://gist.github.com/mattt/5135521)
- [UIAppearance proxy for custom objects - StackOverflow](http://stackoverflow.com/questions/15732885/uiappearance-proxy-for-custom-objects)
- [@OBJC 和 DYNAMIC](http://swifter.tips/objc-dynamic/)

## LICENSE

MIT