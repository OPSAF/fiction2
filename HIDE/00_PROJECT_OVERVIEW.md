# 00 — 项目总览

## 项目名
虚数空間の異邦人 ～ Quantum Terminal User ～

## 一句话描述
地球天才少年林零通过量子意识实验进入异世界，以CLI终端读写世界底层代码，在魔法学院中扮猪吃老虎、赚钱、攻略女主、寻找身世真相。

## 语言规则（v0.9重大变更）
- **正文叙述**：全部中文
- **角色对话**：日文原文 + 中文翻译（仅对话保留日文，叙述不保留）
- **终端界面**：英文CLI
- **原因**：双语全文太费字数token，缩减为仅对话保留日文

## 文件结构
```
fiction/
  index.html                    — 完整SPA阅读器（CSS+JS+嵌入所有.md内容）
  
  PROLOGUE/                     — 序章10个episode
    ep_00_zero.md ～ ep_09_eve_end.md
  
  chapter_01/                   — Ch01三个Part
    part1/ep_01.md ～ ep_06.md  (Part 1: 入学日常)
    part2/ep_07.md ～ ep_10.md  (Part 2: 精灵赚钱)
    part3/ep_11.md ～ ep_14.md  (Part 3: 暗杀学妹)
  
  HIDE/                         — 大纲与设定（不上传GitHub）
    00_PROJECT_OVERVIEW.md      — 本文件
    01_WORLD_SETTING.md         — 世界观（国家/种族/地理/历史）
    02_MAGIC_SYSTEM.md          — 魔法理论体系
    03_CHARACTERS.md            — 角色完全设定（含前世信息）
    04_TERMINAL_SYSTEM.md       — 主角能力详解
    05_PLOT_OUTLINE.md          — 剧情大纲
    06_WRITING_STYLE.md         — 写作规范
    07_TRUTH_APPENDIX.md        — 真相附录（零不知情）
    characters_full.json         — 角色JSON数据
    characters_spoiler.md        — 角色深层设定
    galgame_choice_system.md     — 选项系统设计
  
  data/                         — 结构化数据（公开）
  wiki/                         — Wiki文档（公开）
  reference/                    — 字数校准参考
  TASK_LIST.md                  — 任务清单
  LESSONS_LEARNED.md            — 经验总结
  .claude/skills/write-novel.md — 写作Skill
```

## 写作流程（供模型参考）
1. 读 `HIDE/05_PLOT_OUTLINE.md` 确定要写的episode
2. 读 `HIDE/03_CHARACTERS.md` 确认当前角色的状态和萌点
3. 读 `HIDE/06_WRITING_STYLE.md` 确认风格规范
4. 读已完成episode（如 `PROLOGUE/ep_00_zero.md`）作为风格样本
5. 写完检查字数（参考 `reference/3734.txt` = 24万字节GBK ≈ 9万字）
6. 写完立即Git commit
