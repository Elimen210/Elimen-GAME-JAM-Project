extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().change_scene_to_file("res://UI.tscn")
