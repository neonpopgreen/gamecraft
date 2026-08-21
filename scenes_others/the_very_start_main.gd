extends Node

var project_list = preload("res://scenes_others/project_list_folder/project_list.tscn").instantiate()

func _ready() -> void:
	step1_write_data_if_first_time()
	step2_if_has_existing_proj_being_edited()
	step3_goto_project_list() 
	
func step1_write_data_if_first_time():
	# check if the app ay kakainstall palang 
	# - check path "awesomegames folder" its json data , if not have means kaka install palang will save a json file 
	var path = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS).path_join("MyAwesomeGames")
	var data = {
		"tutorial":true
	}
	var file_name = "editor_data.json"
	var err = MyJson.write_a_new_json(path,file_name,data)
	if err == false:
		print("meron ng data,",file_name )
		
	
func step2_if_has_existing_proj_being_edited():
	
	var path = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS).path_join("MyAwesomeGames")
	var file_name = "editor_data.json"
	var data = MyJson.read_a_json_file_then_returns_as_dictionary(path,file_name)
	var key = "current_project"
	if data.has(key):
		pass
		
		#open_proj(data[key])

func step3_goto_project_list():
	add_child(project_list)
