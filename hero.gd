extends CharacterBody3D
class_name Hero

# === CONSTANTS ===
const SPEED_RUN := 5.0
const SPEED_WALK := 2.5
const JUMP_VELOCITY := 4.5
const GRAVITY := 9.81
const ROTATION_SPEED := 12.0

# === EXPORTED ===
@export_group("Stats")
@export var max_hp: int = 100
@export var attack_damage: int = 15
@export var attack_cooldown: float = 0.8
@export var skill_cooldown: float = 3.0

@export_group("Input")
@export var input_enabled: bool = true

# === NODES ===
@onready var anim_tree: AnimationTree = $AnimationTree
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var model: Node3D = $Model
@onready var camera_target: Marker3D = $CameraTarget

# === STATE ===
enum State { IDLE, RUN, ATTACK, SKILL, HURT, DEAD, EMOTE }
var current_state: State = State.IDLE
var current_hp: int = max_hp
var attack_timer: float = 0.0
var skill_timer: float = 0.0
var hurt_timer: float = 0.0

# === SIGNALS ===
signal state_changed(new_state: State)
signal hp_changed(new_hp: int)
signal died

# === LIFECYCLE ===
func _ready() -> void:
    current_hp = max_hp
    anim_tree.active = true
    _set_state(State.IDLE)

func _physics_process(delta: float) -> void:
    _apply_gravity(delta)
    _update_cooldowns(delta)
    
    if input_enabled and current_state != State.DEAD:
        _handle_input(delta)
    
    move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
    if not input_enabled or current_state == State.DEAD:
        return
    
    if event.is_action_pressed("attack"):
        _try_attack()
    elif event.is_action_pressed("skill"):
        _try_skill()
    elif event.is_action_pressed("emote"):
        _try_emote()

# === GRAVITY & MOVEMENT ===
func _apply_gravity(delta: float) -> void:
    if not is_on_floor():
        velocity.y -= GRAVITY * delta

func _handle_input(delta: float) -> void:
    var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
    var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
    
    if direction:
        velocity.x = direction.x * SPEED_RUN
        velocity.z = direction.z * SPEED_RUN
        _rotate_toward(direction, delta)
        _set_state(State.RUN)
    else:
        velocity.x = move_toward(velocity.x, 0, SPEED_RUN)
        velocity.z = move_toward(velocity.z, 0, SPEED_RUN)
        _set_state(State.IDLE)

func _rotate_toward(target_dir: Vector3, delta: float) -> void:
    if target_dir.length() < 0.1:
        return
    var target_rotation := atan2(-target_dir.x, -target_dir.z)
    model.rotation.y = lerp_angle(model.rotation.y, target_rotation, ROTATION_SPEED * delta)

# === STATE MACHINE ===
func _set_state(new_state: State) -> void:
    if new_state == current_state:
        return
    
    var old_state := current_state
    current_state = new_state
    
    _exit_state(old_state)
    _enter_state(new_state)
    
    emit_signal("state_changed", new_state)

func _enter_state(state: State) -> void:
    match state:
        State.IDLE:
            anim_tree.set("parameters/conditions/is_running", false)
        State.RUN:
            anim_tree.set("parameters/conditions/is_running", true)
        State.ATTACK:
            anim_tree.set("parameters/conditions/is_attacking", true)
            attack_timer = attack_cooldown
        State.SKILL:
            anim_tree.set("parameters/conditions/is_casting", true)
            skill_timer = skill_cooldown
        State.HURT:
            anim_tree.set("parameters/conditions/is_hurt", true)
            hurt_timer = 0.5
        State.DEAD:
            anim_tree.set("parameters/conditions/is_dead", true)
            emit_signal("died")
        State.EMOTE:
            anim_tree.set("parameters/conditions/is_emoting", true)

func _exit_state(state: State) -> void:
    match state:
        State.ATTACK:
            anim_tree.set("parameters/conditions/is_attacking", false)
        State.SKILL:
            anim_tree.set("parameters/conditions/is_casting", false)
        State.HURT:
            anim_tree.set("parameters/conditions/is_hurt", false)
        State.EMOTE:
            anim_tree.set("parameters/conditions/is_emoting", false)

func _update_cooldowns(delta: float) -> void:
    if attack_timer > 0:
        attack_timer -= delta
    if skill_timer > 0:
        skill_timer -= delta
    if hurt_timer > 0:
        hurt_timer -= delta
        if hurt_timer <= 0 and current_state == State.HURT:
            _set_state(State.IDLE)

# === ACTIONS ===
func _try_attack() -> void:
    if current_state == State.ATTACK or current_state == State.SKILL:
        return
    if attack_timer > 0:
        return
    _set_state(State.ATTACK)

func _try_skill() -> void:
    if current_state == State.SKILL or current_state == State.ATTACK:
        return
    if skill_timer > 0:
        return
    _set_state(State.SKILL)

func _try_emote() -> void:
    if current_state == State.EMOTE:
        return
    _set_state(State.EMOTE)

# === DAMAGE ===
func take_damage(amount: int) -> void:
    if current_state == State.DEAD:
        return
    
    current_hp = max(0, current_hp - amount)
    emit_signal("hp_changed", current_hp)
    
    if current_hp <= 0:
        _set_state(State.DEAD)
    else:
        _set_state(State.HURT)

func heal(amount: int) -> void:
    if current_state == State.DEAD:
        return
    current_hp = min(max_hp, current_hp + amount)
    emit_signal("hp_changed", current_hp)

# === ANIMATION CALLBACKS ===
func _on_animation_finished(anim_name: StringName) -> void:
    if anim_name == "attack" and current_state == State.ATTACK:
        _set_state(State.IDLE)
    elif anim_name == "skill" and current_state == State.SKILL:
        _set_state(State.IDLE)
    elif anim_name == "emote" and current_state == State.EMOTE:
        _set_state(State.IDLE) 
