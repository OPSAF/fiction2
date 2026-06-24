# HIDE 目录迁移说明

> **日期**：2026-06-24
> **操作**：将 HIDE/ 中的设定内容归纳整理并移植到 `bible/` 目录

---

## 发生了什么

HIDE/ 中原有的约30个设定文件已按内容类型归类、整理并移植到了项目 Bible 目录结构中：

| 内容类型 | 原位置 | 新位置 |
|----------|--------|--------|
| 世界观·魔法·等级·终端 | HIDE/01-05, 90-91 | `bible/world/` |
| 势力设定（帝国/宗教/虚空/古神） | HIDE/07-10 | `bible/world/05-08_faction_*.md` |
| 角色设定·设计文档·Wiki | HIDE/11, DESIGN_*, WIKI_* | `bible/characters/` |
| 故事线总览·逐章剧情 | HIDE/06, DESIGN_STORYLINES | `bible/routes/` |
| 真相附录·上古种族 | HIDE/12-13 | `bible/world/09-10_*.md` |
| 伏笔系统 | （从多文件提取整理） | `bible/mysteries/` |
| 时间线 | （从多文件提取整理） | `bible/timeline_events/` |
| Agent写作提示 | HIDE/agent_prompts.md | `meta/agent_prompts.md` |

---

## HIDE/ 文件保留说明

**HIDE/ 中的所有原始文件保持不变**，作为历史存档保留。

- 如需查阅当前活跃版本，请访问 `bible/` 目录
- 如需查阅旧版内容或对比变更，HIDE/ 中的文件仍可正常访问

---

## Bible 目录快速导航

- 总索引：`bible/README.md`
- 世界观：`bible/world/README.md`
- 角色：`bible/characters/README.md`
- 路线：`bible/routes/README.md`
- 谜题/伏笔：`bible/mysteries/README.md`
- 时间线：`bible/timeline/README.md` / `bible/timeline_events/README.md`
