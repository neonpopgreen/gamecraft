#tool
extends MeshInstance3D



@export var cube_size : float = 1# Called when the node enters the scene tree for the first time.
var cube_mesh:ArrayMesh 

@export var width : int = 8
@export var height : int = 16
@export var depth : int = 8

var voxels = []

var uvs = [0,0,0,0,0,0]

func _ready() -> void:
	
	# - - - timeran intro - - -
	var time = Time.get_datetime_dict_from_system()
	var current = time.second
	var past = time
	print("current : ", current)
	print(time)
	
	# - - - code - - -
	voxels = generate_voxels()
	generate_mesh(voxels)
	
	# - - - timeran ending  - - -
	time = Time.get_datetime_dict_from_system()
	print("time : ",time.second-current)
	print(past)
	print(time)
	print("mesh.get_faces().size() : ",self.mesh.get_faces().size(),"  in square: ",self.mesh.get_faces().size()/2," in blocks : ",self.mesh.get_faces().size()/12)
	
	#print("mesh.get_faces() : ",self.mesh.get_faces(),"  mesh.get_surface_count() : ",self.mesh.get_surface_count())
	
	
	
	
func generate_mesh(voxels):
	var faces = []
	
	for x in range(voxels.size()):
		for y in range(voxels[x].size()):
			for z in range(voxels[x][y].size()):
				if voxels[x][y][z] != 0:
					#var position = voxels[x][y][z] * cube_size
					var position = Vector3(x,y,z) * cube_size
					
					faces.append(create_face(Vector3.UP,position, uvs))
					faces.append(create_face(Vector3.DOWN,position, uvs))
					faces.append(create_face(Vector3.LEFT,position, uvs))
					faces.append(create_face(Vector3.RIGHT,position, uvs))
					faces.append(create_face(Vector3.FORWARD,position, uvs))
					faces.append(create_face(Vector3.BACK,position, uvs))
	var vertices = []
	var normals = []
	var uvs = []
	
	for face in faces:
		vertices += face["vertices"]
	#	normals += face["normals"]
	#	uvs += face["uvs"]
		
	var vertex_array = PackedVector3Array(vertices)
	var normal_array = PackedVector3Array(normals)
	var uv_array = PackedVector2Array(uvs)
	
	var arrays = []
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = vertex_array
	#arrays[Mesh.ARRAY_NORMAL] = normal_array
	#arrays[Mesh.ARRAY_TEX_UV] = uv_array
	
	cube_mesh = ArrayMesh.new()
	cube_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES,arrays)
	
	
	self.mesh = cube_mesh
	
func generate_voxels()-> Array:
	var array = []
	array.resize(width)
	
	for x in width:
		array[x] = []
		array[x].resize(height)
		
		for y in height:
			array[x][y] = []
			array[x][y].resize(depth)
	
	for x in width:
		for y in height:
			for z in depth:
				array[x][y][z] = 1
				
	return array

func create_face(direction:Vector3,position : Vector3,uv_coords:Array) -> Dictionary:
	var vertices = []
	var normals = []
	var uvs = []
	
	normals.resize(4)
	
	match direction:
		Vector3.UP:
			vertices = [
				position + Vector3(-0.5, 0.5,-0.5) * cube_size,
				position + Vector3( 0.5, 0.5,-0.5) * cube_size,
				position + Vector3( 0.5, 0.5, 0.5) * cube_size,
				position + Vector3(-0.5, 0.5, 0.5) * cube_size,
			]
			normals.fill(Vector3.UP)
			uvs = uv_coords
		Vector3.DOWN:
			vertices = [
				position + Vector3(-0.5,-0.5,0.5) * cube_size,
				position + Vector3( 0.5,-0.5,0.5) * cube_size,
				position + Vector3( 0.5, -0.5, -0.5) * cube_size,
				position + Vector3(-0.5, -0.5, -0.5) * cube_size,
			]
			normals.fill(Vector3.DOWN)
			uvs = uv_coords
		Vector3.LEFT:
			vertices = [
				position + Vector3(-0.5, -0.5,-0.5) * cube_size,
				position + Vector3( -0.5, 0.5,-0.5) * cube_size,
				position + Vector3( -0.5, 0.5, 0.5) * cube_size,
				position + Vector3(-0.5, -0.5, 0.5) * cube_size,
			]
			normals.fill(Vector3.LEFT)
			uvs = uv_coords
		Vector3.RIGHT:
			vertices = [
				position + Vector3(0.5, -0.5,0.5) * cube_size,
				position + Vector3( 0.5, 0.5,0.5) * cube_size,
				position + Vector3( 0.5, 0.5, -0.5) * cube_size,
				position + Vector3(0.5, -0.5, -0.5) * cube_size,
			]
			normals.fill(Vector3.RIGHT)
			uvs = uv_coords
		Vector3.FORWARD:
			vertices = [
				position + Vector3(-0.5, -0.5,-0.5) * cube_size,
				position + Vector3( 0.5, -0.5,-0.5) * cube_size,
				position + Vector3( 0.5, 0.5, -0.5) * cube_size,
				position + Vector3(-0.5, 0.5, -0.5) * cube_size,
			]
			normals.fill(Vector3.FORWARD)
			uvs = uv_coords
		Vector3.BACK:
			vertices = [
				position + Vector3(-0.5, 0.5,0.5) * cube_size,
				position + Vector3( 0.5, 0.5,0.5) * cube_size,
				position + Vector3( 0.5, -0.5, 0.5) * cube_size,
				position + Vector3(-0.5, -0.5, 0.5) * cube_size,
			]
			normals.fill(Vector3.BACK)
			uvs = uv_coords
			
	return {
		"vertices":[
			vertices[0],vertices[1],vertices[2],
			vertices[0],vertices[2],vertices[3]
		]
		
	}
