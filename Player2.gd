extends CharacterBody3D

var mouse_sensitivity := 0.001
const SPEED = 4.0
const JUMP_VELOCITY = 4.5
@onready var twist_pivot := $TwistPivot
@onready var pitch_pivot := $TwistPivot/PitchPivot
var lookat
var lastLookAtDirection : Vector3
@onready var animationtree = get_node("AnimationTree")
var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
var twist_input := 0.0
var pitch_input := 0.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var health : float = 5.0
var damage

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _physics_process(delta):
	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	twist_pivot.rotate_y(twist_input)
	pitch_pivot.rotate_x(pitch_input)
	pitch_pivot.rotation.x = clamp(pitch_pivot.rotation.x, 
		deg_to_rad(-30), 
		deg_to_rad(30)
	)
	twist_input = 0.0
	pitch_input = 0.0
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY * gravity * delta
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_just_pressed("ui_enter"):
		get_tree().change_scene_to_file("res://game_over.tscn")
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_right", "ui_left", "ui_down", "ui_up")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	$AnimationTree.set("parameters/conditions/idle", input_dir == Vector2.ZERO && is_on_floor())
	$AnimationTree.set("parameters/conditions/walk", (input_dir.y == 1 || input_dir.y == -1) && is_on_floor())
	$AnimationTree.set("parameters/conditions/straifLeft", input_dir.x == 1 && is_on_floor())
	$AnimationTree.set("parameters/conditions/straifRight", input_dir.x == -1 && is_on_floor())
	$AnimationTree.set("parameters/conditions/falling", !is_on_floor())
	$AnimationTree.set("parameters/conditions/landed", is_on_floor())
	
	move_and_slide()
func _on_button_pressed():
	get_tree().change_scene_to_file("res://node_3d.tscn")

func _on_mesh_instance_3d_26_child_entered_tree(node):
	pass # Replace with function body.
