extends Node

@export var perlin : FastNoiseLite# = FastNoiseLite.new() 
@export var dimension: Vector3i = Vector3i(32,32,32)
## means the noise_point_in_3d from noice is float from 1 to 0 , cuting it off will be 1 and zero not a float   
## [br] - the higher the cutoff the less likely it will be 1 not zero 
## [br] - 0.9 is few cubes , 0.1 is many  , none if 9-8 , no culling : lag if 1-2
@export var cutoff : float = 0.5
@export var colors :Array[Color]

@onready var mesh_instance_3d: Mesh_chunk = $MeshInstance3D
#var chunk:Mesh_chunk

var test_chunk_data : Dictionary[Vector3,Color] ={
	Vector3(1,0,0):Color.AQUA,
	Vector3(1,0,1):Color.BLACK,
	Vector3(1,0,2):Color.BLUE,
	Vector3(1,0,3):Color.GREEN,
	Vector3(1,0,4):Color.RED,
	Vector3(1,1,3):Color.DEEP_PINK,
	Vector3(1,0,5):Color.YELLOW,
	
}


var noise_point : float

func _ready() -> void:
	#mesh_instance_3d.be_a_chunk(create_chunk_data(perlin))
	mesh_instance_3d.be_a_chunk(mesh_instance_3d.generate_chunk_data(dimension.x,dimension.y,perlin,colors))
	
	#mesh_instance_3d.add_face(Mesh_chunk.Face.FRONT , Vector3.ZERO,Color.RED)
	#mesh_instance_3d.be_a_chunk(test_chunk_data)
	mesh_instance_3d.generate_mesh()
	#print(create_chunk_data(perlin))
	print("vector forward: ",Vector3.FORWARD)
	print("vector back : ",Vector3.BACK)

	
func create_chunk_data(noise:FastNoiseLite)->Dictionary[Vector3,Color]: # Deprecated
	var chunk_data :Dictionary[Vector3,Color] = {}
	#var a_block_s_dictionary:Dictionary[Vector3,Color]
	for x in dimension.x:
		for y in dimension.y:
			for z in dimension.z:
				noise_point = perlin.get_noise_3d(x,y,z)
				if noise_point > cutoff:
					#print("noise point val : ",noise_point)
					#a_block_s_dictionary = {Vector3(x,y,z):Color.RED}
					#chunk_data.append(Vector3(x,y,z),Color.REBECCA_PURPLE)
					chunk_data[Vector3(x,y,z)] = colors[y%colors.size()]
				
	return chunk_data
