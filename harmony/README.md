# HarmonyOS 接入说明

当前仓库中的 `harmony/` 目录提供的是接入脚手架与占位配置，用于明确 Flutter 共享层与鸿蒙宿主层的边界。由于不同 Flutter-Harmony 适配发行版在插件兼容性和构建脚本上可能存在差异，正式实施时需要基于团队选定的适配方案补齐真实工程文件。

## 目录说明

- `AppScope/`：应用级配置占位
- `entry/`：鸿蒙宿主模块占位
- `build-profile.json5`：构建 profile 占位

## 建议接入步骤

1. 在 DevEco Studio 中创建或导入 HarmonyOS Stage 模型工程。
2. 按选定的 Flutter-Harmony 适配方案，将 Flutter 产物接入 `entry` 模块。
3. 将平台能力、权限声明和原生桥接代码限制在 `harmony/entry` 内。
4. 验证共享 Flutter 页面可由鸿蒙宿主拉起。

## 当前限制

- 本仓库尚未固定具体的 Flutter-Harmony 适配发行版。
- 第三方 Flutter 插件是否兼容鸿蒙，需要在接入后逐项验证。
- 构建命令以实际选定的适配方案文档为准。
