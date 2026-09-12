# HOYOAO-3RD — MASTER KICKOFF BRIEF
(Dán toàn bộ bản này vào task mới để bắt đầu build project từ đầu)

## 0. BỐI CẢNH & LỆNH TỐI CAO (BẮT BUỘC ĐỌC TRƯỚC)
Tôi đã có một task trước đó xây dựng HoyoAO-3rd nhưng quá nhiều sai sót, vi phạm, lỗi chồng chéo. Tôi muốn BỎ TOÀN BỘ, build lại từ con số 0 theo chất lượng AAA thực sự.

## SUPREME AMENDMENT v3.0 — GDSCRIPT-ONLY PRODUCTION
Đã ban hành ở task cũ, vẫn có hiệu lực tuyệt đối: 
---
- LOẠI BỎ hoàn toàn C++ .so / GDExtension / godot-cpp
- 100% GDScript cho game logic, domain, vault, economy, combat
- Ưu tiên Godot Servers (RenderingServer, PhysicsServer3D, ...) cho xử lý nặng
- GDScript phải được tối ưu theo data-oriented, pool, cache, typed variable
- UI vẫn chỉ là presenter, không sửa canonical state
- Command/Event flow phải một chiều
- Mobile-first, test trên Android device thật, KHÔNG dùng PC/emulator làm chuẩn
- Nếu gặp giới hạn hiệu năng → giảm scope/pool/cache/server/shader, KHÔNG quay lại C++
---


## LÝ DO ĐÃ CHỐT
Godot Editor có phiên bản mới nhưng C++ toolchain bám version cũ → rủi ro đồng bộ
Chi phí môi trường C++ quá lớn (thiếu thiết bị, cross-compile Android, debug phức tạp)
NGUYÊN TẮC BẤT KHẢ XÂM PHẠM (Rút ra từ task cũ)
1. NO CODE-BASED UI — Mọi UI phải là .tscn scene file, kéo thả trong Editor. Script chỉ bind data + xử lý event. CẤM Label.new(), Button.new(), PanelContainer.new() trong script.
2. NO BOOTSTRAP STACK — Chỉ 1 file game_bootstrap.gd duy nhất. CẤM m1, m2, m3... m21 bootstrap chồng chất.
3. NO PATH DRIFT — Mọi service phải ở đúng path theo blueprint. Không tạo service ở res://core/... rồi tham chiếu res://sys/....
4. NO UNUSED PARAMETER/VARIABLE — GDScript strict mode. Mọi param không dùng phải prefix _.
5. NO SHADOWED GLOBAL IDENTIFIER — Cấm đặt biến tên exp, str, int, tr, print...
6. NO ANCHOR SIZE CONFLICT — Node có anchor_right = 1.0 thì KHÔNG được set size.x trực tiếp. Phải dùng set_deferred hoặc đổi anchor.
7. NO DICTIONARY DUPLICATE KEY — Cấm {"type": "x", "type": "y"}. Key command routing và key payload phải khác tên (type vs item_type).
8. NO FAKE COMBAT / NO FAKE COOLDOWN / NO FAKE STAT — Mọi con số phải là canonical từ service.
9. COMPLETE FILE LAW — Khi sửa file, trả về FULL FILE, không gửi patch fragment.
10. ONE-WAY FLOW — UI → Command → Service → Event → UI. CẤM re-entry.

## 1. KIẾN TRÚC 4 TRỤ CỘT (Giữ nguyên từ blueprint gốc)

| Trụ cột | Vai trò | Nơi đặt |
| :--- | :--- | :--- |
| DCL (Domain Core/Contract) | Luật lõi, schema, command envelope, event contract, ID domain | res://sys/core/ (GDScript thay C++) |
| DDD (Domain-Driven) | Bounded contexts: Save, Economy, Ownership, Progression, Combat, Quality | res://sys/services/ |
| DDA (Data-Driven Assets) | Static authored data: character, weapon, skill, item, enemy, stage, gacha | res://defs/ + res://locales/ + res://cfg/ |
| DOD (Data-Oriented Runtime) | Combat sim, VFX pool, cached hit volumes, snapshot double-buffer | res://gameplay/ + res://combat/ + res://fx/ |

Flow một chiều:
---
UI/Input → Intent → CommandBus → Domain Service → EventBus → Snapshot → Presenter/UI/VFX/Audio
---

## 2. PROJECT STRUCTURE MỤC TIÊU
```
res://
├── app/
│   ├── boot/
│   │   └── game_bootstrap.gd          # DUY NHẤT — không có m1, m2, m3...
│   ├── router/
│   │   └── scene_router.gd            # MENU → LOBBY → PLAYING → GAME_OVER
│   └── lifecycle/
│
├── sys/
│   ├── event_bus/
│   │   └── event_bus.gd
│   ├── commands/
│   │   └── command_bus.gd
│   ├── core/
│   │   ├── dcl/result.gd              # class_name AoResult
│   │   ├── vault/save_vault.gd
│   │   ├── combat_sim/combat_sim.gd   # DOD SoA
│   │   └── quality/quality_gov.gd
│   ├── services/
│   │   ├── content_registry.gd
│   │   ├── economy_service.gd
│   │   ├── ownership_service.gd
│   │   ├── gacha_service.gd
│   │   ├── inventory_service.gd
│   │   ├── equip_service.gd
│   │   ├── progression_service.gd
│   │   ├── player_stat_service.gd
│   │   ├── save_load_service.gd
│   │   ├── localization_service.gd
│   │   └── audio_manager.gd
│   └── debug/
│       └── combat_log_service.gd
│
├── defs/
│   ├── skills/{basic_slash,heavy_strike,wind_slash}.json
│   ├── items/{health_potion,mana_shard,iron_ore}.json
│   ├── weapons/{iron_sword,steel_blade}.json
│   ├── characters/{hero,knight}.json
│   ├── enemies/{grunt,runner,brute,boss}.json
│   ├── gacha/standard_banner.json
│   └── loot_tables.json
│
├── gameplay/
│   ├── intent/player_intent_controller.gd
│   ├── flow/{wave_spawner, loot_drop, progression_bridge, enemy_archetype}.gd
│   ├── ai/{enemy_ai_controller, enemy_ai_factory}.gd
│   ├── camera/arpg_camera.gd
│   └── state/{entity_presenter, entity_presenter_factory, pickup_presenter_factory}.gd
│
├── combat/
│   ├── view/target_marker.gd
│   ├── hitfx/hitfx_bridge.gd
│   └── reaction/{animation_state_bridge, entity_appearance_bridge, entity_death_presenter, combo_counter}.gd
│
├── fx/
│   └── vfx_pool/fx_pool.gd
│
├── ui/
│   ├── controls/                       # REUSABLE components — .tscn + .gd
│   │   ├── virtual_joystick.tscn + .gd
│   │   ├── action_button.tscn + .gd
│   │   └── hp_bar.tscn + .gd
│   ├── hud/
│   │   ├── combat/combat_hud.tscn + .gd
│   │   ├── progression/progression_hud.tscn + .gd
│   │   ├── stats/stat_hud.tscn + .gd
│   │   ├── inventory/inventory_hud.tscn + .gd
│   │   ├── skill_slots/skill_slot_hud.tscn + .gd
│   │   ├── combo/combo_hud.tscn + .gd
│   │   ├── damage_numbers/damage_number.tscn + .gd
│   │   └── game_over/game_over_hud.tscn + .gd
│   ├── lobby/
│   │   ├── main_menu.tscn + .gd
│   │   ├── lobby_hub.tscn + .gd
│   │   └── gacha_modal.tscn + .gd
│   ├── settings/settings_menu.tscn + .gd
│   └── debug/debug_overlay.tscn + .gd
│
├── locales/{en,vi}/strings.json
├── cfg/{defaults,quality}/
├── assets/{ui,audio,vfx}/             # Textures, icons, fonts, themes
└── project.godot                       # KHÔNG autoload services — instance từ bootstrap
```

## 3. UI LAYOUT CHUẨN HONKAI / GENSHIN (Mobile)
---
┌─────────────────────────────────────────────────────┐
│ [Mini-map]                              [||] [SET] │ ← Top bar
│ [HP BAR ██████████ 1250/1500]                      │
│ [EXP BAR ███████░░░] Lv.5                          │
│ [ATK 85  DEF 42]                                         │
│                                                          │
│                    GAME VIEWPORT                         │
│                                                          │
│ [Char 1]  ← Switch (top-left vertical stack)            │
│ [Char 2]                                                 │
│ [Char 3]                                                 │
│                                                          │
│                                                          │
│      ┌──────────┐                                 │
│      │ Joystick │                  [ULT]  ← 72px       │
│      │  (ring)  │             [S2]                      │
│      │  220px   │        [S1]    [ATK]  ← 88px         │
│      └──────────┘              [DGE]  ← 64px     │
│                                                          │
│ [Inv slot] [slot] [slot] [slot] [slot] [Gold] [Gem]│ ← Bottom bar
└─────────────────────────────────────────────────────┘
---

Size chuẩn (ngón tay cái):
- Attack button: 88×88px
- Skill button: 64×64px (arc layout quanh attack)
- Ultimate: 72×72px
- Dodge: 64×64px
- Joystick: outer ring 220×220px, knob 70×70px
- Character switch: 56×56px mỗi slot
- HP bar: 320×24px
- Inventory slot: 48×48px

Cooldown indicator:
- Dùng TextureProgress mode Radial 360 với fill_mode = Counter-clockwise
- Overlay đen alpha 0.6
- Label "1.2s" ở giữa
- Palette (Honkai-style):
- Attack: đỏ ruby #E63946
- Skill: xanh dương #457B9D
- Ultimate: vàng kim #FFD166
- Dodge: xanh lá #06A77D
- HP: xanh lá #2EC4B6 → vàng #FFB703 → đỏ #E63946 theo %
- EXP: tím #9D4EDD

## 4. EXECUTION PHASES (THEO ĐÚNG THỨ TỰ, KHÔNG ĐỐT GIAI ĐOẠN)

### PHASE 0 — FOUNDATION (Làm trước)
- Tạo đầy đủ tree folder như section 2
- AoResult class (DCL)
- EventBus + CommandBus
- game_bootstrap.gd duy nhất (KHÔNG autoload)
- project.godot với Godot 4.7.2 settings chuẩn mobile (Vulkan Forward Mobile)

### PHASE 1 — CORE SERVICES
- ContentRegistry (load JSON defs)
- CombatSim (DOD SoA: _ids, _hp, _pos, _state, _faction, _atk, _def, _max_hp, cooldown dict)
- SaveVault + SaveLoadService (encrypted save)
- EconomyService + OwnershipService + InventoryService + EquipService + ProgressionService + PlayerStatService + QualityGov + LocalizationService + AudioManager

### PHASE 2 — SCENE FLOW
- SceneRouter (MENU → LOBBY → PLAYING → GAME_OVER → LOBBY)
- MainMenu.tscn (cinematic BG, 3 nút)
- LobbyHub.tscn (3D character showcase, currency, gacha, battle)
- GachaModal.tscn
- SettingsMenu.tscn (tab layout, slider, dropdown)

### PHASE 3 — COMBAT CORE
- WaveSpawner (grunt/runner/brute/boss)
- EnemyArchetypeService + EnemyAIController + EnemyAIFactory
- EntityPresenter + EntityPresenterFactory + EntityAppearanceBridge + EntityDeathPresenter
- LootDropService + PickupPresenterFactory + PickupIntentController
- ProgressionBridge + ComboCounter
- FXPool + HitFxBridge + AnimationStateBridge
- DamageNumberPool (scene-based, pooled)

### PHASE 4 — MOBILE CONTROLS (THEO LAYOUT SECTION 3)
- VirtualJoystick.tscn (ring + knob, touch-only)
- CombatHUD.tscn (joystick + action arc + top bar + bottom bar)
- ActionButton.tscn (reusable với cooldown radial fill)
- HPBar.tscn (reusable)
- SkillSlotHUD.tscn
- ProgressionHUD.tscn + StatHUD.tscn + InventoryHUD.tscn + ComboHUD.tscn
- GameOverHUD.tscn

### PHASE 5 — POLISH & QA
- Scene transitions (fade)
- Audio BGM + SFX
- Particle VFX cho skill
- Localization en/vi/zh
- Thermal audit script
- Build Android, test trên device thật

5. KỲ VỌNG VỀ CHẤT LƯỢNG
Khi hoàn thành, tôi kỳ vọng:
1. Mở Godot Editor → Thấy cây folder sạch, mỗi file đúng chỗ
2. Mở .tscn → Kéo thả UI được, đổi màu thấy ngay, không cần đọc code
3. Chạy game → Flow mượt, UI đúng layout Honkai/Genshin, không chồng chéo
4. Console Godot → 0 warning, 0 error
5. Test trên Android device thật → 60 FPS stable, không thermal throttle trong 30 phút
6. Save file encrypted, không plaintext, chống rollback
7. Gacha hoạt động, economy balance, ownership đúng

### 6. BẮT ĐẦU TỪ ĐÂU?
Yêu cầu AI bắt đầu từ PHASE 0 — tạo AoResult, EventBus, CommandBus, game_bootstrap.gd, và cấu hình project.godot chuẩn mobile. Xác nhận hiểu brief này bằng cách trả lời "Yes, bắt đầu Phase 0", sau đó implement đúng format output quy định trong HoyoAO.md ([STATUS], [ANALYSIS], [FILES AFFECTED], [IMPLEMENTATION] full file, [VALIDATION], [PERFORMANCE], [SECURITY]).
LƯU Ý: KHÔNG làm tắt, KHÔNG bỏ qua phase, KHÔNG tạo file thừa. Mỗi phase xong hãy hỏi tôi xác nhận rồi mới sang phase kế tiếp. Tôi muốn thấy tiến trình sạch sẽ, không hỗn tạp như task cũ.
