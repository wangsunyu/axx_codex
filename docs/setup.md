# 安小信 Flutter 项目初始化说明

## 环境要求

- Flutter 3.41.2 或兼容的 stable 版本
- Dart 3.11.0 或与当前 Flutter SDK 配套的版本
- Xcode 及 iOS Simulator（用于 iOS 开发）
- Android Studio 或 Android SDK / adb（用于 Android 开发）
- DevEco Studio 与可用的 HarmonyOS Flutter 适配环境（用于鸿蒙接入）

## 本地初始化

```bash
flutter pub get
flutter analyze
```

## 运行应用

```bash
flutter run
```

默认情况下，Flutter 会连接当前可用的 iOS 或 Android 设备/模拟器。鸿蒙集成需要先完成 `harmony/` 目录下说明中的宿主工程接入。
