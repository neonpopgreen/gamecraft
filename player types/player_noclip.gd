extends Node3D

@export var move_speed:float = 0.3
@export var mouse_sensitivity :float = 0.01
@onready var camera_3d: Camera3D = $Camera3D
@onready var ray_cast_3d: Raycast_for_block = $Camera3D/RayCast3D

signal remove_block
signal add_block
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_pressed("w"):
		#position.z -= move_speed
		translate_object_local(Vector3.FORWARD*move_speed)
	if Input.is_action_pressed("s"):
		#position.z += move_speed
		translate_object_local(Vector3.BACK*move_speed)
	
	if Input.is_action_pressed("a"):
		#position.x -= move_speed
		translate_object_local(Vector3.LEFT*move_speed)
	if Input.is_action_pressed("d"):
		#position.x += move_speed
		translate_object_local(Vector3.RIGHT*move_speed)
	
	if Input.is_action_pressed("e"):
		#position.y += move_speed
		translate_object_local(Vector3.UP*move_speed)
	if Input.is_action_pressed("q"):
		#position.y -= move_speed
		translate_object_local(Vector3.DOWN*move_speed)
	
func _input(event):
	if event is InputEventMouseMotion:
		#print("mose is working , readable ")
		rotate_y(-event.relative.x * mouse_sensitivity)
		camera_3d.rotate_x(-event.relative.y * mouse_sensitivity)
		#camera_3d.rotation.x = clamp(rotation.x, deg_to_rad(-90), deg_to_rad(90))
	
	if event.is_action_pressed("add_block"):
		var hit : Raycast_for_block.RayHit = ray_cast_3d.get_ray_hit()
		if hit:
			pass
			#add_block.emit(hit.add_position,TerrainAlgorithm.Voxel.Grass) # parameters : position , block type to place ex. grass
		
	#if event.is_action_pressed("remove_block"):
		#var hit : Raycast_for_block.RayHit = ray_cast_3d.get_ray_hit()
		#if hit:
			#remove_block.emit(hit.remove_position)
	#if event.is_action_pressed("remove_block"):
		#if ray_cast_3d.get_collider()
