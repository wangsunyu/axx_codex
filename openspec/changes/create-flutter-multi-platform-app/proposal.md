## Why

当前工作区还没有任何工程基础设施，无法开始面向移动端的业务开发、联调与交付。现在建立一个兼容 iOS、Android、鸿蒙的 Flutter 项目基座，可以尽早统一技术栈、目录结构、构建约定和多端适配方案，降低后续功能开发与平台接入成本。

## What Changes

- 创建一个新的 Flutter 应用工程，作为后续业务开发的统一宿主项目。
- 配置 iOS 与 Android 的标准运行、构建与打包基础能力。
- 集成鸿蒙适配方案，明确 Flutter 到 HarmonyOS 的工程接入、平台目录组织和构建入口。
- 建立环境配置、依赖管理、代码组织、资源目录和多端构建说明，确保团队可以在同一仓库内开展开发。
- 提供最小可运行首页与基础应用壳层，用于验证三端工程可启动、可编译、可扩展。

## Capabilities

### New Capabilities
- `flutter-app-bootstrap`: 创建 Flutter 应用基座，定义项目结构、入口页面、依赖管理和开发约定。
- `multi-platform-target-support`: 为 iOS、Android、鸿蒙提供平台工程、构建配置和运行验证路径。

### Modified Capabilities

None.

## Impact

- 新增 Flutter 工程文件、Dart 源码目录、资源目录和多平台宿主工程。
- 引入 Flutter SDK 相关工具链与项目依赖，并补充鸿蒙适配所需插件或桥接配置。
- 增加项目文档，说明本地开发、平台构建、环境要求与后续扩展方式。
