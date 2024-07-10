extends MeshInstance3D



@onready var a = get_node("/root/Node3D/Player")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = a.global_transform.origin
	
func _input(event):
	if Input.is_key_pressed(KEY_D):
		rotate_y(01)
