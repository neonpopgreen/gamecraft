class_name My_json
extends Node

func _ready() -> void:
	pass
	#test()
	#test1()
	
func test1():
	pass
	
	var biome_plains :Dictionary = {
		"type":"basebiome",#basebiome_or_object
		"name":"plains",
		"description":"plain flat grasess",
		"overworld_image":{
			"image_path":"res://ress/World_A2.png",
			"height_width":Vector2(48,48),
			"position":Vector2(216,72)
		},
		"terrain_gen_type":"height_map",
		"terrain_gen_type_settings":["ceiling","lowest_height","equation","code"],
		"mobs_spawn_list":["pig","orc"],
		"blocks_list":[["soil_green","code_and_condition"],["soil_brown","code_and_condition"]],
		"premade_object_list":["trees","soil_pilars","stone"]
	}	
	# grass and trees , onting parameters lang muna 
	var biome_grass :Dictionary = {
		"type":"basebiome",#basebiome_or_object
		"name":"grass",
		"description":"plain non-flat grasess ,have grasses and trees",#tooltip
		"overworld_image":{
			"image_path":"res://ress/Outside_A2.png",
			"height_width":Vector2(48,48),
			"position":Vector2(432,0)
		},
	} 
	var biome_sand:Dictionary = {
		"type":"basebiome",#basebiome_or_object
		"name":"sand",
		"description":"plain sand ,have cactus ",#tooltip
		"overworld_image":{
			"image_path":"res://ress/World_A2.png",
			"height_width":Vector2(48,48),
			"position":Vector2(24,360)
		},
	}
	var biome_snow:Dictionary = {
		"type":"basebiome",#basebiome_or_object
		"name":"snow",
		"description":"plain white ",#tooltip
		"overworld_image":{
			"image_path":"res://ress/World_A2.png",
			"height_width":Vector2(48,48),
			"position":Vector2(24,504)
		},
	}
	var biome_lava:Dictionary = {
		"type":"basebiome",#basebiome_or_object
		"name":"lava",
		"description":" lava biome ",#tooltip
		"overworld_image":{
			"image_path":"res://ress/World_A2.png",
			"height_width":Vector2(48,48),
			"position":Vector2(312,360)
		},
	}
	
	var biome_sea:Dictionary = {
		"type":"basebiome",#basebiome_or_object
		"name":"sea",
		"description":" sea biome ",#tooltip
		"overworld_image":{
			"image_path":"res://ress/World_A1.png",
			"height_width":Vector2(48,48),
			"position":Vector2(24,72)
			},
	}
	
	var object_pillars:Dictionary = {
		"type":"biome_object",
		"name":"rocky-pillars",
		"description":" pillars of rocks biome object  ",#tooltip
		"overworld_image":{
			"image_path":"res://ress/World_A2.png",
			"height_width":Vector2(48,48),
			"position":Vector2(627,288)
		}
	}
	
	var object_mountain_peaks:Dictionary = {
		"type":"biome_object",
		"name":"mountain_peaks",
		"description":" peak mountains huge ",#tooltip
		"overworld_image":{
			"image_path":"res://ress/World_A2.png",
			"height_width":Vector2(48,48),
			"position":Vector2(730,0)
		}
	}
	
	var object_mountain:Dictionary ={
		"type":"biome_object",
		"name":"mountain",
		"description":" mountain ",#tooltip
		"overworld_image":{
			"image_path":"res://ress/World_A2.png",
			"height_width":Vector2(48,48),
			"position":Vector2(624,0)
		}
	}
	
	var object_mountains:Dictionary ={
		"type":"biome_object",
		"name":"mountains",
		"description":" mini many mountain ",#tooltip
		"overworld_image":{
			"image_path":"res://ress/World_A2.png",
			"height_width":Vector2(48,48),
			"position":Vector2(624,288)
		}
	}
	
	var object_xed:Dictionary ={
		"type":"biome_object",
		"name":"xed",
		"description":" mini many floating island ",#tooltip
		"overworld_image":{
			"image_path":"res://ress/World_A2 inverted.png",
			"height_width":Vector2(48,48),
			"position":Vector2(144,240)
		}
	}
	
	var object_inverted:Dictionary ={
		"type":"biome_object",
		"name":"mountains",
		"description":" mini many mountain ",#tooltip
		"overworld_image":{
			"image_path":"res://ress/World_A2 inverted.png",
			"height_width":Vector2(48,48),
			"position":Vector2(288,528)
		}
	}
	
	var object_village:Dictionary ={
		"type":"biome_object",
		"name":"mountains",
		"description":" mini many mountain ",#tooltip
		"overworld_image":{
			"image_path":"res://ress/World_B.png",
			"height_width":Vector2(48,48),
			"position":Vector2(0,334)
		}
	}
	
	var object_river:Dictionary ={
		"type":"biome_object",
		"name":"river",
		"description":" like path but river or lava  ",#tooltip
		"overworld_image":{
			"image_path":"res://ress/World_B.png",
			"height_width":Vector2(48,48),
			"position":Vector2(192,0)
		}
	}
	
	var object_path:Dictionary ={
		"type":"biome_object",
		"name":"path_road",
		"description":" road or path or  ",#tooltip
		"overworld_image":{
			"image_path":"res://ress/World_B.png",
			"height_width":Vector2(48,48),
			"position":Vector2(96,0)
		}
	}
	
	var biome_list:Dictionary={
		"data":[
		biome_plains,
		biome_grass,
		biome_sand,
		biome_snow,
		biome_lava, 
		biome_sea,
		object_pillars,
		object_mountain_peaks ,
		object_mountain ,
		object_mountains ,
		object_xed, 
		object_inverted,  
		object_village, 
		object_river,  
		object_path
	]}
	var project_name = "proj01"
	
	write_a_new_json(OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS).path_join("MyAwesomeGames").path_join(project_name).path_join("database"),"biomes_database.json",biome_list)
	
	
	#var object :Dictionary = {
		#"name":"Mountains",
		#"image":"res://ress/grass/Grass01.png"
	#}
	
func test():
	# test it here , all function
	var dict :Dictionary = {
		#"animal2":["cat","dog","ulam2"]
		"kulangot2":3283274729348,
		3:"tae2",
		Vector2i(1,2):Vector3.LEFT,
		"grow":Marker2D.new()
	}
	var path = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS).path_join("MyAwesomeGames")
	#write_a_new_json(path,"GodsPower.json",dict)
	#replace_json(path,"GodsPower.json",dict)
	add_data_to_json(path,"kanor.json",dict)
	print(dict[Vector2i(1,2)])
	
	get_tree().quit()

func add_data_to_json(folder_path:String,json_name:String,data:Dictionary)->bool:
	pass
	#load data jason
	var data1 :Dictionary = read_a_json_file_then_returns_as_dictionary(folder_path,json_name)
	if data1.is_empty():
		printerr("dictionary is empty , will return false")
		return false
	# load the data to data1 , merge and replace
	var combined_data_dictinary:Dictionary = data1.duplicate()
	combined_data_dictinary.merge(data,true)
	# write 
	var file = FileAccess.open(folder_path.path_join(json_name),FileAccess.WRITE)
	file.store_string(JSON.stringify(combined_data_dictinary,"\t"))#\t for prettyness
	file.close()
	print("done adding a dictionary to this (",json_name,") dictionary")
	return true
	
	
## returns true if file already exist
## [br]returns false if file is nothing or file not created
func replace_json(folder_path:String,json_name:String,data:Dictionary)->bool:
	pass
	if FileAccess.file_exists(folder_path.path_join(json_name)):
		print("name : ",json_name," File exist. will delete it")
		# code here : delete then create file 
		#delete
		if DirAccess.remove_absolute(folder_path.path_join(json_name)) == OK:
			print(json_name," is deleted")
			#create a file 
			var json_as_string = JSON.stringify(data,"\t")
			var file = FileAccess.open(folder_path.path_join(json_name),FileAccess.WRITE)
			if file:
				file.store_string(json_as_string)
				file.close()
				print(json_name," is created successfully")
				return true
			else:
				print(" file not created " )
				return false
			
			
		else :
			print(json_name," is cannot delete")
			return false
		
		
	else :
		print("File does not exist , aborting replacing json , will return false. ")
		return false

func write_a_new_json(folder_path:String,json_name:String,data:Dictionary) -> bool:
	
	# check if folder exist , if not create it
	if not DirAccess.dir_exists_absolute(folder_path):
		var err = DirAccess.make_dir_recursive_absolute(folder_path)

		if err == OK:
			print("Folders created!")
		else:
			print("Failed to create folders. Error: ", err)
	
	#check if the file exist
	if FileAccess.file_exists(folder_path.path_join(json_name)):
		print("File already exist. will return false and cancel the creation of file")
		return false
	else :
		print("File does not exist. Creating file. ")
		
	
		#open the file , if does not exist will create the file 
		var file = FileAccess.open(folder_path.path_join(json_name),FileAccess.WRITE)
		
		if file:
			#convert the dictionary to json
			var json_text = JSON.stringify(data,"\t")# pretty format with tabs
			file.store_string(json_text)
			print("data written.")
		else:
			print("file is null , failed to open or create the file")
			
		return true
		
func read_a_json_file_then_returns_as_dictionary(folder_path:String,json_name:String)->Dictionary:
	pass
	#check is exist
	if !FileAccess.file_exists(folder_path.path_join(json_name)):
		printerr(folder_path.path_join(json_name)," file does not exist, will return empty dictionary instead")
		return {}
	#open the file for reading
	var file =FileAccess.open(folder_path.path_join(json_name),FileAccess.READ)
	var json_as_text = file.get_as_text()
	file.close()
	# writing the json 
	var json = JSON.new()
	var error = json.parse(json_as_text)
	# check if error
	if error != OK:
		print("error at parsing ",folder_path.path_join(json_name), " because : ",json.get_error_message(), " will returns empty dictionary instead")
		return {}
	# check if the data is dictionary
	if json.data is Dictionary:
		return json.data
	
	print("file is not a dictionary ", folder_path.path_join(json_name)," will return empthy dictionary instead")
	return{}
	
