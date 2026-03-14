# iOS 输入框长按菜单英文问题

## 问题现象

在 Flutter 登录页的输入框中，长按后弹出的系统编辑菜单仍然显示英文，例如：

- `Paste`
- `Copy`
- `Select All`

即使 Flutter 应用层已经设置了中文 `locale`，并补充了 `Material / Widgets / Cupertino` 本地化代理，iOS 模拟器中的输入框长按菜单仍然没有切换成中文。

## 影响范围

- iOS 端输入框体验与中文产品环境不一致
- 用户可见菜单文案不符合当前项目语言风格
- 单纯修改 Flutter 页面代码无法稳定解决系统级菜单语言问题

## 排查过程

### 1. 先检查 Flutter 层本地化设置

已确认应用入口加入了：

- `locale: Locale('zh', 'CN')`
- `GlobalMaterialLocalizations.delegate`
- `GlobalWidgetsLocalizations.delegate`
- `GlobalCupertinoLocalizations.delegate`

结论：
- Flutter 组件本身的中文能力已具备
- 但系统输入菜单仍可能受 iOS 工程语言设置影响

### 2. 检查 iOS 工程语言配置

检查了以下文件：

- `ios/Runner/Info.plist`
- `ios/Runner.xcodeproj/project.pbxproj`

发现问题：

- `project.pbxproj` 中 `developmentRegion = en;`
- `knownRegions` 只有 `en` 和 `Base`
- `Info.plist` 中 `CFBundleDevelopmentRegion` 依赖 `$(DEVELOPMENT_LANGUAGE)`，没有明确指定中文
- `Info.plist` 中缺少 `CFBundleLocalizations` 的中文声明

## 根因判断

问题根因不是 Flutter 输入框本身，而是 **iOS 工程层仍然把英文当作默认开发语言和主要区域语言**。

在这种情况下，即使 Flutter 层指定了中文 locale，系统级输入框编辑菜单仍可能优先显示英文。

## 最终解决方案

采用“设置层修复”的方式，不引入自定义长按菜单逻辑。

### 修改 1：调整 Xcode 工程默认开发语言

文件：
- `ios/Runner.xcodeproj/project.pbxproj`

修改内容：

- 将
  - `developmentRegion = en;`
  改为
  - `developmentRegion = "zh-Hans";`

- 将 `knownRegions` 扩充为：
  - `zh-Hans`
  - `en`
  - `Base`

### 修改 2：在 Info.plist 中显式声明中文本地化

文件：
- `ios/Runner/Info.plist`

修改内容：

- 将
  - `CFBundleDevelopmentRegion`
  显式改为 `zh-Hans`

- 新增：
  - `CFBundleLocalizations`

内容包含：

- `zh-Hans`
- `en`

## 这次实际修改的文件

- [project.pbxproj](/Users/wsy/Desktop/code/iOS项目/安小信flutter-codex/ios/Runner.xcodeproj/project.pbxproj)
- [Info.plist](/Users/wsy/Desktop/code/iOS项目/安小信flutter-codex/ios/Runner/Info.plist)
- [app.dart](/Users/wsy/Desktop/code/iOS项目/安小信flutter-codex/lib/app/app.dart)

说明：
- `app.dart` 中保留 Flutter 中文本地化代理配置
- 但真正解决系统编辑菜单英文问题的关键，是 iOS 工程语言设置切换为中文优先

## 验证方式

### 代码层验证

执行：

```bash
flutter analyze
flutter test
```

结果：

- `flutter analyze` 通过
- `flutter test` 通过

### 运行验证

执行：

```bash
flutter run -d <ios-simulator-id>
```

在 iOS 模拟器中：

1. 打开登录页
2. 长按任意输入框
3. 检查系统弹出的编辑菜单文案是否为中文

## 如果后续仍未切换成中文，继续排查的方向

如果按上述设置修改后仍显示英文，优先继续检查：

### 1. 模拟器系统语言

确认 iOS 模拟器本身的系统语言是否为中文：

- `Settings`
- `General`
- `Language & Region`

如果模拟器语言仍为英文，系统菜单可能继续显示英文。

### 2. 模拟器缓存

有时修改 iOS 工程语言配置后，旧安装包缓存不会立即刷新。

建议操作：

- 卸载模拟器中的 App
- 重新执行 `flutter run`
- 必要时重启模拟器

### 3. 不要优先走重型自定义菜单方案

当前项目更适合优先使用系统设置层修复，而不是直接重写输入框长按菜单。

原因：

- 系统菜单行为更稳定
- 平台一致性更好
- 后续维护成本更低
- 不会额外引入输入框交互兼容风险

## 结论

这类问题优先从 **iOS 工程语言设置** 排查，而不是先从 Flutter 页面逻辑入手。

本次有效方案是：

1. Flutter 层配置中文 locale 和本地化代理
2. iOS 工程层把默认开发语言和本地化区域切换到 `zh-Hans`
3. 重新构建并在模拟器中验证

这套方案适合后续同类“系统菜单语言不生效”的问题复用。
