extends Node3D

@export var walkspeed = 1.5
@export var runspeed = 3
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var JUMP_VELOCITY = 4.5
var SPEED = 5.0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
		
func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y -= gravity * delta
	var velocity = Vector3.ZERO
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if Input.is_action_just_pressed("move_forward"):
		velocity.x = direction.x * SPEED * delta
		
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		vector.y = JUMP_VELOCITY
	
