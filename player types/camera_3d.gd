extends Node3D

@onready var camera_3d: Camera3D = $Camera3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	if Input.is_action_pressed("a"):
		rotation.y +=0.1
	if Input.is_action_pressed("d"):
		rotation.y -=0.1
	if Input.is_action_pressed("w"):
		camera_3d.position.z -=0.1
	if Input.is_action_pressed("s"):
		camera_3d.position.z +=0.1
	if Input.is_action_pressed("q"):
		rotation.x +=0.1
	if Input.is_action_pressed("e"):
		rotation.x -=0.1
