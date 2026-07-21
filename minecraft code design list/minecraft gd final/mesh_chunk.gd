#@tool
class_name Mesh_chunk
extends MeshInstance3D

@onready var collision_shape_3d: CollisionShape3D = $StaticBody3D/CollisionShape3D


@export var material:Material
var chunk_dimension:int#:Vector3 = Vector3(32,32,32)
var chunk_data:Dictionary[Vector3,Color] = {}
var empty_mesh = ArrayMesh.new()

var chunk_data_test:Dictionary[Vector3,Color] = {Vector3(0,15,0):Color.RED}

var surface_array :Array = []
var vertices = PackedVector3Array()
var normals = PackedVector3Array()
var colors = PackedColorArray()

var cube_vertices:Array[Vector3] = [
	Vector3(-0.5,-0.5,0.5),
	Vector3(0.5,-0.5,0.5),
	Vector3(0.5,-0.5,-0.5),
	Vector3(-0.5,-0.5,-0.5),
	Vector3(-0.5,0.5,0.5),
	Vector3(0.5,0.5,0.5),
	Vector3(0.5,0.5,-0.5),
	Vector3(-0.5,0.5,-0.5)
]

enum Face {TOP,BOTTOM,LEFT,RIGHT,FRONT,BACK}
 
var face_indices: Dictionary[Face,Array] = {
	Face.TOP:[[4,7,6],[4,6,5]],
	Face.BOTTOM:[[0,1,2],[0,2,3]],
	Face.LEFT:[[3,7,4],[3,4,0]],
	Face.RIGHT:[[1,5,6],[1,6,2]],
	Face.FRONT:[[0,4,5],[0,5,1]],
	Face.BACK:[[2,7,3],[2,6,7]]
}
var face_normals:Dictionary[Face,Vector3] = {
	Face.TOP:Vector3.UP,
	Face.BOTTOM:Vector3.DOWN,
	Face.LEFT:Vector3.LEFT,
	Face.RIGHT:Vector3.RIGHT,
	Face.FRONT:Vector3.BACK,
	Face.BACK:Vector3.FORWARD,
}
var face_colors: Dictionary[Face,Color]={
	Face.TOP:Color.RED,
	Face.BOTTOM:Color.BLUE,
	Face.LEFT:Color.GREEN,
	Face.RIGHT:Color.BROWN,
	Face.FRONT:Color.PINK,
	Face.BACK:Color.BLACK,
}


func _ready() -> void:
	init_the_mesh()
	if chunk_data.is_empty() : return
	generate_mesh()
	#add_a_block(Vector3.ZERO)
	
	#generate_mesh()
func init_the_mesh():
	if mesh :
		mesh.clear_surfaces()
		mesh.clear_blend_shapes()
		mesh.reset_state()
		null_the_three()

	mesh = null
	surface_array=[]
	print(surface_array)
	surface_array.resize(Mesh.ARRAY_MAX)
	var empty = ArrayMesh.new()
	mesh = empty
	mesh.clear_surfaces()
	print("get_surface_count() : ",mesh.get_surface_count())
	
	

func null_the_three():
	vertices = null
	normals = null
	colors = null
	vertices = PackedVector3Array()
	normals = PackedVector3Array()
	colors = PackedColorArray()
	
func generate_chunk_data(chunk_size:int , max_height:int, noise : Noise, color_array:Array[Color]) -> Dictionary[Vector3,Color] :
	#var random
	#var rand_p
	#var height
	#var local_height
	#var global_position1
	for x in chunk_size:
		for z in chunk_size:
			var global_position1 = Vector2(x+position.x,z+position.z)
			#var global_position1 = position+Vector3(x,0,z)
			var random = ((noise.get_noise_2d(global_position1.x,global_position1.y)+0.5* noise.get_noise_2d(global_position1.x*2,global_position1.y*2) + 0.25 * noise.get_noise_2d(global_position1.x*4,global_position1.y*4))/1.75+1)/2
			var rand_p = pow(random,2.1)
			var height = max_height * rand_p
			
			if height < position.y :continue
			
			var local_height = height - position.y
			for y in range(min(local_height,chunk_size)):
				chunk_data[Vector3(x,y,z)] = color_array[y%color_array.size()]
			
	#for data in chunk_data:
		#print(data)
		#
	
	return chunk_data
	
## walang laman 
func generate_mesh() -> void:
	commit_mesh()
	
func commit_mesh() -> void:
	surface_array[Mesh.ARRAY_VERTEX] = vertices
	surface_array[Mesh.ARRAY_NORMAL] = normals
	surface_array[Mesh.ARRAY_COLOR] = colors
	
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES,surface_array)
	mesh.surface_set_material(0,material)
	collision_shape_3d.shape = mesh.create_trimesh_shape()
	
func remove_a_block(global_position_of_selection:Vector3i ):
	pass
	print("global_position_of_selection : ",global_position_of_selection)
	#chunk_data.erase(Vector3(global_position_of_selection.x-position.x,global_position_of_selection.y-position.y,global_position_of_selection.z-position.z))
	print("position in this chunk : ",Vector3(global_position_of_selection)-position)
	print("color : ",chunk_data[Vector3(global_position_of_selection)-position])
	print("chunk size after : ", chunk_data.size())
	print("erased ? : ",chunk_data.erase(Vector3(global_position_of_selection)-position))
	print("chunk size after : ", chunk_data.size())
	#print("what color ? if this may laman na color , hindi nadelete  color : ",chunk_data[Vector3(global_position_of_selection)-position]) # nag eeror to kasi null sya , means na dedelete sya sa 
	get_parent().chunk_data_changes[global_position_of_selection] = Color.RED
	
	#chunk_data = {}
	print("number of faces before : ",mesh.get_faces().size())
	init_the_mesh()
	#be_a_chunk(chunk_data_test)
	be_a_chunk(chunk_data)
	commit_mesh()
	print("number of faces after : ",mesh.get_faces().size())

func add_a_block(global_position_of_selection:Vector3i ):
	pass
	chunk_data[Vector3(global_position_of_selection)-position] = Color.BLUE
	get_parent().chunk_data_changes[global_position_of_selection] = Color.BLUE
	init_the_mesh()
	be_a_chunk(chunk_data)
	commit_mesh()
	
	

func be_a_chunk(chunk_data:Dictionary[Vector3,Color])->void:
	if chunk_data.is_empty():return
	
	var color
	for block_pos_vect3 in chunk_data:
		color = chunk_data[block_pos_vect3]
		
		if not has_neighbour(chunk_data,Face.FRONT,block_pos_vect3):
			add_face(Face.FRONT,block_pos_vect3,color)
		if not has_neighbour(chunk_data,Face.BACK,block_pos_vect3):
			add_face(Face.BACK,block_pos_vect3,color)
		
		
		if not has_neighbour(chunk_data,Face.TOP,block_pos_vect3):
			add_face(Face.TOP,block_pos_vect3,color)
		if not has_neighbour(chunk_data,Face.BOTTOM,block_pos_vect3):
			add_face(Face.BOTTOM,block_pos_vect3,color)
		
		if not has_neighbour(chunk_data,Face.LEFT,block_pos_vect3):
			add_face(Face.LEFT,block_pos_vect3,color)
		if not has_neighbour(chunk_data,Face.RIGHT,block_pos_vect3):
			add_face(Face.RIGHT,block_pos_vect3,color)
			

		
	

#func add_a_block(chunk_data_for_face_culling_color_and_position:Dictionary[Vector3,Color]) -> void: # make the color uv 
	#add_face(Face.FRONT,position,chunk_data_for_face_culling_color_and_position[])
	#add_face(Face.BACK,position,color)
	#add_face(Face.LEFT,position,color)
	#add_face(Face.RIGHT,position,color)
	#add_face(Face.TOP,position,color)
	#add_face(Face.BOTTOM,position,color)
	#no longger needed this because creating a block individualy and face culling it collides 
	
func has_neighbour(chunk_data:Dictionary[Vector3,Color],face: Face , position:Vector3) -> bool:
	var neighbour_position = position + face_normals[face]
	if chunk_data.has(neighbour_position):return true
	return false
	
func add_face(face:Face , position:Vector3,color:Color) -> void:
	var indices = face_indices[face]
	for triangle in indices:
		for index in triangle:
			vertices.append(cube_vertices[index]+position)
			normals.append(face_normals[face])
			#colors.append(face_colors[face])
			colors.append(color)
	
