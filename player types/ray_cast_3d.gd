class_name Raycast_for_block
extends RayCast3D

@onready var csg_box_3d_2: CSGBox3D = $CSGBox3D2
# var csgbox_default_position = Vector3(0,0,3) # i visible nalang
@onready var csg_box_3d_3: CSGBox3D = $CSGBox3D3

var selected_block_position : Vector3i
var selected_block_position_adding : Vector3i
var selected_chunk : Mesh_chunk
var selected_chunk_adding : Mesh_chunk

class RayHit:
	var remove_position: Vector3i 
	var add_position:Vector3i
	
	func _init(remove:Vector3i, add:Vector3i) -> void:
		remove_position = remove
		add_position = add

func get_ray_hit() -> RayHit:
	var collider = get_collider()
	if collider is not Mesh_chunk:return null
	
	var chunk = collider as Mesh_chunk
	var point = get_collision_point()
	var normal = get_collision_normal()
	var pos = (point - normal/2).floor()
	
	return RayHit.new(pos,pos+normal)

func _process(delta: float) -> void:
	show_block_selection_remove()
	show_block_selection_add()
	

func show_block_selection_remove():
	if get_collider():
		#print(get_collider().get_parent())
		if get_collider().get_parent() is Mesh_chunk :
			csg_box_3d_2.visible = true
			var pos = get_collision_point() - 0.5 * get_collision_normal()
			pos = pos.round()
			csg_box_3d_2.global_position = pos
			csg_box_3d_2.global_rotation = get_collider().get_parent().rotation
			selected_block_position = pos
			selected_chunk = get_collider().get_parent() as Mesh_chunk
	elif csg_box_3d_2.visible == true : # and !get_collider():
		csg_box_3d_2.visible=false
		selected_block_position = Vector3i.ZERO
		selected_chunk = null

func show_block_selection_add():
	if get_collider():
		#print(get_collider().get_parent())
		if get_collider().get_parent() is Mesh_chunk :
			csg_box_3d_3.visible = true
			var pos = get_collision_point() + 0.5 * get_collision_normal()
			pos = pos.round()
			csg_box_3d_3.global_position = pos
			csg_box_3d_3.global_rotation = get_collider().get_parent().rotation
			selected_block_position_adding = pos
			selected_chunk_adding = get_collider().get_parent() as Mesh_chunk
	elif csg_box_3d_3.visible == true : # and !get_collider():
		csg_box_3d_3.visible=false
		selected_block_position_adding = Vector3i.ZERO
		selected_chunk_adding = null

func _input(event):
	if event.is_action_pressed("remove_block") and selected_block_position!= Vector3i.ZERO:
		selected_chunk.remove_a_block(selected_block_position)
		
	if event.is_action_pressed("add_block") and selected_block_position_adding!= Vector3i.ZERO:
		selected_chunk_adding.add_a_block(selected_block_position_adding)
		
