extends RigidBody3D

@export var mouse_sensitivity := 0.005
var twist_input := 0.0
var pitch_input := 0.0
const JUMP_VELOCITY = 2.25
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
var lookat
var lastLookAtDirection : Vector3
@onready var animationtree = get_node("AnimationTree")
@onready var twist_pivot := $TwistPivot
@onready var pitch_pivot := $TwistPivot/PitchPivot
var buildSfx

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _process(delta: float) -> void:
	
	var input = Vector3.ZERO
	input.x = Input.get_axis("ui_left", "ui_right")
	input.z = Input.get_axis("ui_up", "ui_down")
	input.y = Input.get_axis("ui_accept", "move_forward")
	if Input.is_action_just_pressed("ui_accept") and not get_colliding_bodies():
		input.y = JUMP_VELOCITY * gravity
	
		
	apply_central_force(twist_pivot.basis * input * 1200.0 * delta)
	
	twist_pivot.rotate_y(twist_input)
	pitch_pivot.rotate_x(pitch_input)
	pitch_pivot.rotation.x = clamp(pitch_pivot.rotation.x,
		deg_to_rad(-30),
		deg_to_rad(30)
	)
	twist_input = 0.0
	pitch_input = 0.0
	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	$WeaponAnimationPlayer.get_animation_library("[Global]").get_animation("mixamo.com"))
	$WeaponAnimationPlayer.play("weapon_attack")
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			twist_input = - event.relative.x * mouse_sensitivity
			pitch_input = - event.relative.x * mouse_sensitivity


