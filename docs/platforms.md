# 多平台运行与构建

## iOS

```bash
flutter run -d ios
flutter build ios
```

如需打开原生宿主工程：

```bash
open ios/Runner.xcworkspace
```

## Android

```bash
flutter run -d android
flutter build apk
flutter build appbundle
```

## HarmonyOS

HarmonyOS 当前采用宿主工程接入模式。请先阅读 `harmony/README.md`，按其中步骤准备 DevEco Studio 工程、Flutter 适配插件和桥接层后，再执行对应构建流程。
