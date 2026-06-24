# Project Bible — 星降りのコード・ウィザード 设定总库

> **Bible = 单一真相来源 (Single Source of Truth)**
> 所有 skill 从这里读取规范数据，所有设计决策通过这里写入。

---

## 目录结构

```
bible/
├── README.md                   ← 你在这里
│
├── world/                      → 世界观与规则系统
│   ├── README.md               → 阅读顺序指南
│   ├── 01_geography_races.md   → 地理·种族·国家·政治经济
│   ├── 02_magic_physics.md     → 魔法物理学（粒子/物质/生物/场）
│   ├── 03_ranking_education.md → 双轨等级制·觉醒机制·教育体系
│   ├── 04_terminal_system.md   → 终端系统（量子场编辑器）
│   ├── 05_faction_empire.md    → 帝国势力
│   ├── 06_faction_religion.md  → 宗教/魔道教势力
│   ├── 07_faction_voidborn.md  → 虚空种势力
│   ├── 08_faction_ancient_gods.md → 古神线势力
│   ├── 09_ancient_races.md     → 上古种族详细
│   ├── 10_truth_appendix.md    → 真相附录（Phantasm计划等）
│   ├── 90_legacy_world.md      → 旧版世界观（存档）
│   └── 91_legacy_magic.md      → 旧版魔法系统（存档）
│
├── characters/                 → 角色设定
│   ├── README.md               → 角色索引
│   ├── 00_master_index.md      → 全角色总览
│   ├── rei_design.md           → 神代零 设计文档
│   ├── akane_design.md         → 天宮朱音 设计文档
│   ├── elna_design.md          → 艾露娜·温德尔 设计文档
│   ├── koyuki_design.md        → 神代小雪 设计文档
│   ├── mayoi_design.md         → 黒鉄真夜 设计文档
│   ├── shiraha_design.md       → 白羽栞 设计文档
│   ├── akane_wiki.md           → 朱音 Wiki
│   ├── elna_wiki.md            → 艾露娜 Wiki
│   └── characters_full.json    → 结构化角色数据
│
├── routes/                     → 路线与结局系统
│   ├── README.md               → 路线索引
│   ├── 00_storylines_overview.md → 路线总览（1主线+4支线）
│   └── 01_full_story_progression.md → 完整逐章剧情推进
│
├── mysteries/                  → 谜题与伏笔管理
│   ├── README.md               → 谜题索引
│   └── 00_foreshadowing_registry.md → 伏笔注册表
│
├── timeline/                   → 时间线（结构定义）
│   └── README.md               → 时间线格式说明
│
├── timeline_events/            → 时间线事件
│   └── README.md               → 事件索引
│
├── scenes/                     → 场景规格
│   └── README.md               → 场景格式说明
│
└── worlds/                     → 世界线变体
    └── README.md               → 世界线说明
```

---

## 阅读顺序推荐

### 如果你是第一次接触这个项目：

1. **bible/world/README.md** → 了解世界观整体结构
2. `bible/world/01_geography_races.md` → 知道这个世界长什么样
3. `bible/world/02_magic_physics.md` → 理解魔法的物理本质
4. `bible/world/03_ranking_education.md` → 理解等级系统和学校
5. `bible/characters/00_master_index.md` → 认识所有角色
6. `bible/routes/00_storylines_overview.md` → 理解故事结构

### 如果你想写某个角色的剧情：

1. `bible/characters/README.md` → 找到角色
2. 读该角色的 DESIGN 文档 → 理解设计意图
3. 读对应线路的 faction 文件 → 理解势力背景
4. `bible/routes/` → 确认路线走向

### 如果你想理解某个势力/线路：

1. `bible/routes/00_storylines_overview.md` → 先看路线总览
2. 读对应 faction 文件（`bible/world/05-08_faction_*.md`）
3. `bible/mysteries/00_foreshadowing_registry.md` → 查看相关伏笔

---

## 与 Skill 系统的关系

- **Tier 0 (Foundation)**: `bible-manager` skill 管理本目录
- **Tier 1 (World Building)**: `world-designer`, `character-designer`, `timeline-architect`, `mystery-designer` 读写对应子目录
- **Tier 2-5**: 上层 skill 通过 bible-manager 间接访问本目录

---

## 维护规则

1. **所有设定修改必须先更新 bible，再同步到 manuscripts**
2. **不要直接修改 HIDE/ 中的文件**（HIDE/ 是历史存档）
3. **每次修改在 commit message 中注明修改了哪个 bible 文件**
4. **文件间交叉引用使用相对路径**（如 `../characters/rei_design.md`）

---

> **原 HIDE/ 目录保留为历史存档。** 本 bible/ 目录是当前活跃的单一真相来源。
