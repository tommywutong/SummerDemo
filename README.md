# TommyWu-2025-summerCode

2025 暑期 iOS / Objective-C 练习合集（四个独立 Xcode 工程）。

| 工程 | 简介 | 主要技术 |
|------|------|----------|
| [`3GShareee/`](3GShareee) | 3GSHARE App 仿写（首页/活动/文章/用户等） | Objective-C · CocoaPods |
| [`天气难报/`](天气难报) | 天气预报 App 仿写（列表、详情、添加、网络层） | Objective-C · CocoaPods |
| [`网易云音乐/`](网易云音乐) | 网易云音乐仿写（侧栏、推荐、夜间模式等） | Objective-C · CocoaPods |
| [`计算器77/`](计算器77) | 计算器（MVC：Model / View / Controller） | Objective-C · Masonry · Lookin |

## 运行

各工程均为独立 workspace。进入对应目录后：

```bash
# 以计算器77 为例
cd 计算器77
pod install   # 若本地尚无 Pods
open 计算器77.xcworkspace
```

请用 Xcode 打开 `.xcworkspace`（不要直接开 `.xcodeproj`），否则可能找不到依赖。

## 仓库说明

- 已修复历史上三个工程被错误记录为 **git submodule 占位**、GitHub 上无法浏览内容的问题；源码现已完整入库。
- 仓库不提交 `Pods/`、`xcuserdata/`、`.DS_Store`，依赖请本地 `pod install`。
- 各工程内 `Podfile` / `Podfile.lock` 已保留，便于还原依赖版本。

## 免责

课程/练习用途的 UI 仿写，仅供学习交流，不用于任何商业分发。
