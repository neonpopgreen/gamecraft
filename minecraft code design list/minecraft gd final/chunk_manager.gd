class_name ChunkManager
extends Node

@export var noise_seed : int
## 0.03 roughf , 0.01 flat/plains
@export var frequency : float
@export var perlin_noise : FastNoiseLite# = FastNoiseLite.new() 
@export var colors :Array[Color]
var cell_size = 8 # ito ay ang size ng bundok o isang village , kasama na border for smoothing
@export var dimension : Vector3i = Vector3i(32*cell_size,32,32*cell_size)
@export var chunk_size : int = 32

var chunk_class = preload("res://minecraft code design list/minecraft gd final/chunk_mesh.tscn")

#var all_chunks_in_array:Array[PackedScene] = {} # instantiation returns Dictionary[PackedScene,Variant] , what is the variant ?
var loading_threads : Array[Thread] = [Thread.new(),Thread.new(),Thread.new(),Thread.new()]

var chunks : Dictionary[Vector3i,Mesh_chunk]={}
#var chunks1 : Dictionary[Vector3i,Array[Color,int,String]]={}

var chunk_data_changes :Dictionary[Vector3,Color] = {}

func _ready() -> void:
	pass
	perlin_noise.frequency = frequency
	perlin_noise.seed = noise_seed
	generate_all_chunk(Vector3(0,0,0))
	#do_thread()
	
	
	

func do_thread(): #deprecated
	#paste this to ready func
	loading_threads[0].start(generate_all_chunk.bind(Vector3.ZERO))
	loading_threads[1].start(generate_all_chunk.bind(Vector3(dimension.x/2,0,0)))
	loading_threads[2].start(generate_all_chunk.bind(Vector3(0,0,dimension.z/2)))
	loading_threads[3].start(generate_all_chunk.bind(Vector3(dimension.x/2,0,dimension.z/2)))
	
func generate_all_chunk(pos:Vector3) -> void:	# deprecated
	var number_of_chunk = dimension/chunk_size  
	#print(number_of_chunk)
	var chunks:Vector3 = number_of_chunk/2
	
	
	for x in number_of_chunk.x:
		for z in number_of_chunk.z:
			for y in number_of_chunk.y:
				var new_chunk : Mesh_chunk = chunk_class.instantiate()
				#all_chunks_in_array.append(new_chunk)
				new_chunk.position = Vector3(x,y,z) * chunk_size  + pos
				
				new_chunk.be_a_chunk(new_chunk.generate_chunk_data(chunk_size,dimension.y,perlin_noise,colors))
				#new_chunk.generate_mesh()
				#mesh_instance_3d.be_a_chunk(mesh_instance_3d.generate_chunk_data(dimension.x,dimension.y,perlin,colors))
				call_deferred("add_child",new_chunk) # add_child(new_chunk)
				
func _exit_tree() -> void:
	for thread in loading_threads:
		thread.wait_to_finish()

# ______________________________________________________________________________________

func remove_chunk(chunk_position:Vector3i)->void:
	# return pag yung chunk na nasa chunk_position param ay null , 
	# ibig sabihin pag wala sa chunks Dictionary yung chunk edi return  
	if !chunks.has(chunk_position):return
	
	# erase at queue free mo yung chunk 
	var chunk = chunks[chunk_position]
	chunks.erase(chunk_position)
	chunk.queue_free()
	

func create_chunk(chunk_position:Vector3i) -> Mesh_chunk:
	pass
	remove_chunk(chunk_position) #remove kung meron na 
	
	
	var chunk = chunk_class.instantiate() as Mesh_chunk
	# set size , then chunk position ,then ipasok sa dictionary na chunks ang chunk nato , then return the chunk
	chunk.position = chunk_position
	chunk.be_a_chunk(chunk.generate_chunk_data(chunk_size,dimension.y,perlin_noise,colors))
	chunks[chunk.position]=chunk
	return chunk

#func get_chunk() # di na kailangan kaya ko kununin ang chunk via raycast

func generate_chunk(chunk_position:Vector3i) -> void :
	var chunk = create_chunk(chunk_position*chunk_size)
	# create chunk data ehh meron na sa create_chunk
	chunk.commit_mesh()
	call_deferred("add_child",chunk) 
	
func add_a_block():
	pass
	
func remove_a_block():
	pass
	
func global_to_local():
	pass
	
func voxel_to_chunk_position():
	pass
	
