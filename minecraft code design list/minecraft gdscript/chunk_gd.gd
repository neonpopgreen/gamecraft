#@tool
extends StaticBody3D

var collisionShape : CollisionShape3D 
var meshInstance : MeshInstance3D 

# default val Vector3i(16,64,16)
var dimensions : Vector3i = Vector3i(8,16,8)
var vertices : Array[Vector3i] = [
	Vector3i(0,0,0),
	Vector3i(1,0,0),
	Vector3i(0,1,0),
	Vector3i(1,1,0),
	Vector3i(0,0,1),
	Vector3i(1,0,1),
	Vector3i(0,1,1),
	Vector3i(1,1,1)
] 

var top 	: Array[int] = [2,3,7,6]
var bottom	: Array[int] = [0,4,5,1]
var left	: Array[int] = [6,4,0,2]
var right	: Array[int] = [3,1,5,7]
var back	: Array[int] = [7,5,4,6]
var front	: Array[int] = [2,0,1,3]

var surfaceTool : SurfaceTool = SurfaceTool.new()

var number_of_triangles : int 


#var blocks : Array[Block_gd] = [dimensions.x,dimensions.y,dimensions.z]
#var blocks : Array[Block_gd] = [dimensions.x,dimensions.y,dimensions.z]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	collisionShape = $CollisionShape3D
	meshInstance = $MeshInstance3D
	
	var time = Time.get_datetime_dict_from_system()
	var current = time.second
	var past = time
	print("current : ", current)
	print(time)
	update()
	time = Time.get_datetime_dict_from_system()
	print("time : ",time.second-current)
	print(past)
	print(time)
	print("number of triagles : ",number_of_triangles,"  in square: ",number_of_triangles/2," in blocks : ",number_of_triangles/12)
	
	

	

func update():
	surfaceTool.begin(Mesh.PRIMITIVE_TRIANGLES)
	var x = 0
	while (x<dimensions.x):
		var y =0
		while (y<dimensions.y):
			var z = 0
			while (z<dimensions.z):
				create_block_mesh(Vector3i(x,y,z))
				print("create_block_mesh :",Vector3i(x,y,z))
				z+=1
				pass
			y+=1
			pass
		x+=1
		pass
		
func create_block_mesh(block_position:Vector3i):
	#if(CheckTransparent(blockPosition + Vector3I.Up)){CreateFaceMesh(_top, blockPosition);}
		
	if (check_transparent(block_position+Vector3i.UP)):
		create_face_mesh(top,block_position)
	if (check_transparent(block_position+Vector3i.DOWN)):
		create_face_mesh(bottom,block_position)
	if (check_transparent(block_position+Vector3i.LEFT)):
		create_face_mesh(left,block_position)
	if (check_transparent(block_position+Vector3i.RIGHT)):
		create_face_mesh(right,block_position)
	if (check_transparent(block_position+Vector3i.FORWARD)):
		create_face_mesh(front,block_position)
	if (check_transparent(block_position+Vector3i.BACK)):
		create_face_mesh(back,block_position)
	
		
func create_face_mesh(face:Array[int],block_position:Vector3i):
	var a : Vector3i = vertices[face[0]] + block_position;
	var b : Vector3i = vertices[face[1]] + block_position;
	var c : Vector3i = vertices[face[2]] + block_position;
	var d : Vector3i = vertices[face[3]] + block_position;
	
	#var triangle1 = new Vector3[]{a,b,c}; //triagle na isa ,
	#var triangle2 = new Vector3[]{a,c,d}; // pangalawang triagle so naka buo na ng square 
	
	var t1 : Array[Vector3] = [a,b,c]
	var t2 : Array[Vector3] = [a,c,d]
	
	surfaceTool.add_triangle_fan(t1)
	surfaceTool.add_triangle_fan(t2)
	number_of_triangles +=2  
	
	#var mesh = _surfaceTool.Commit();
	#meshInstance3D.Mesh = mesh;
	#collisionShape3D.Shape = mesh.CreateConvexShape();
	var mesh = surfaceTool.commit()
	meshInstance.mesh = mesh
	collisionShape.shape = mesh.create_convex_shape()


func check_transparent(block_pos:Vector3i):
	return true
	
		
		
		
