extends MeshInstance3D

@onready var a = get_node("/root/Spatial/Player")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translation = a.global_transform.origin
