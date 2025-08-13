# Godot RPG01

使用Godot引擎开发的RPG游戏项目

## 项目结构

- `Script/` - 游戏脚本文件
  - `Fighter.gd` - 战斗角色类，包含攻击、防御、血量管理等功能
  - `Battle.gd` - 战斗场景控制器
  - `DamagePopup.gd` - 伤害数字显示类
- `Scence/` - 游戏场景文件
  - `Fighter.tscn` - 角色场景
  - `Battle.tscn` - 战斗场景
  - `DamagePopup.tscn` - 伤害显示场景
- `Texture2D/` - 纹理资源文件
- `project.godot` - Godot项目配置文件

## 功能特性

- 自动战斗系统
- 暴击和闪避机制
- 伤害数字弹出效果
- 血量条显示
- 可自定义角色属性

## 开发环境

- Godot 4.4
- 使用GDScript编写

## 如何运行

1. 安装Godot 4.4或更高版本
2. 克隆此仓库
3. 在Godot中打开项目
4. 运行主场景Battle.tscn

## 贡献

欢迎提交问题和改进建议！