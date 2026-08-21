extends Panel

@onready var settings: Panel = $Settings
@onready var new_project_window: Panel = $New_project_window

@onready var line_edit_name: LineEdit = $New_project_window/VBoxContainer/HBoxContainer/VBoxContainer/LineEdit_name
@onready var text_edit_description: TextEdit = $New_project_window/VBoxContainer/HBoxContainer/VBoxContainer/TextEdit_description

@onready var texture_rect: TextureButton = $New_project_window/VBoxContainer/HBoxContainer/TextureRect

@onready var v_box_list_of_projs: VBoxContainer = $"MarginContainer/HBoxContainer/list of actors/ScrollContainer/VBoxContainer2/VBox_list_of_projs"

@onready var file_dialog: FileDialog = $FileDialog

const ITEM_FOR_PROJECT_LIST = preload("res://scenes_others/project_list_folder/item_for_project_list.tscn")


const POPUP = preload("uid://biit2n8oqdfdg")

var new_project_data_dictionary : Dictionary = {
	"project_name":"",
	"project_icon":"",
	"project_description":"",
	"project_folder_location":"",
	"date_created":{}
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	#init the filedialog filters
	file_dialog_filters()
	
	#make the settings and new proj window in vissible
	settings.visible = false
	new_project_window.visible = false
	
	#step 1 
	# - search all project_data.json , read all data 
	step1_search_all_project_data_json()

func file_dialog_filters():
	file_dialog.filters = PackedStringArray([
		"*.png ; PNG Images",
		"*.jpg ; JPEG Images",
		"*.jpeg; JPEG Images",
		"*.webp; WebP Images"
	])

func _process(delta: float) -> void:
	pass

func step1_search_all_project_data_json():
	print("list refreshed")
	#increment
	var counter = 1
	var darken_panel:bool = false
	
	#clear the list
	for child in v_box_list_of_projs.get_children():
		child.queue_free()
	
	
	var path = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS).path_join("MyAwesomeGames")
	#print(find_json_files(path))
	var paths = find_json_files(path)
	paths = filter_the_array_of_filepath_to("project_data.json",paths)
	print(paths)
	for p in paths:
		#get data
		var data = MyJson.read_a_json_file_then_returns_as_dictionary(p.get_base_dir(),p.get_file())
		#print("data : ",data)
		# create item node for the list
		var item = ITEM_FOR_PROJECT_LIST.instantiate()
		v_box_list_of_projs.add_child(item)
		# fill the item with data 
		var s = "%03d : " % counter
		item.fill(data["project_name"],s,ImportImage.base64_to_texture(data["project_icon"]),darken_panel,data)
		# counter for increment 
		counter +=1
		darken_panel = !darken_panel
	
	
	
func find_json_files(path:String)->Array:
	var json_files = [] # will store here all jso file 
	
	var dir = DirAccess.open(path)
	
	if dir == null:
		#print("from project_list.gd : dir empty")
		return json_files
	
	dir.list_dir_begin()
	
	var file_name = dir.get_next()
	
	while file_name != "":
		var full_path = path.path_join(file_name)
		
		if dir.current_is_dir():
			# Search inside the subfolder 
			json_files.append_array(find_json_files(full_path))
	
		elif file_name.to_lower().ends_with(".json"):
			json_files.append(full_path)
		file_name = dir.get_next()
	#end of while
	
	dir.list_dir_end()
	return json_files
	
	
	
func filter_the_array_of_filepath_to(filename:String,array_of_file_path:Array)->Array:
	var array_of_file_path1 = array_of_file_path.filter(func(path):
		return path.get_file().to_lower() == filename)
	return array_of_file_path1

func _on_Plus_button_pressed() -> void:
	new_project_window.visible = true


func _on_confirm_from_new_proj_window_button_pressed() -> void:
	
	pass # Replace with function body.
	new_project_window.visible = false
	# get the description from texedit , gawin mo rin sa name 
	var name1 = line_edit_name.text
	var description = text_edit_description.text
	#print("name:",name)
	if name1 == "":
		pass
		#print("out",name)
		# toast like 
		var popup = POPUP.instantiate()
		add_child(popup)
		popup.text("name of project is empty , set some name , aborting ")
	else :
		pass
		#check folder with same name , if has , make it ++
		#create the folder 
		var path = create_incremented_folder(OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS).path_join("MyAwesomeGames"),name1)
		#populate new_project_data_dictionary
		new_project_data_dictionary["project_name"] = name1
		new_project_data_dictionary["project_icon"]=ImportImage.texture_to_base64(texture_rect.texture_normal)
		new_project_data_dictionary["project_description"] = description
		new_project_data_dictionary["project_folder_location"] = path
		new_project_data_dictionary["date_created"] = Time.get_datetime_dict_from_system()
		
		#add the project_data.json 
		MyJson.write_a_new_json(path,"project_data.json",new_project_data_dictionary)
	step1_search_all_project_data_json()

func _on_settings_button_pressed() -> void:
	pass # Replace with function body.
	settings.visible = true


func _on_confirm_button_from_settings_pressed() -> void:
	pass # Replace with function body.
	settings.visible = false


func _on_project_icon_pressed() -> void:
	file_dialog.popup_centered()
	

func _on_file_dialog_file_selected(path: String) -> void:
	var image = Image.load_from_file(path)
	if image:
		texture_rect.texture_normal = ImageTexture.create_from_image(image)
	else:
		print("no image selected")
		
func create_incremented_folder(base_path: String, folder_name: String) -> String:
	# Define the base target directory path
	var target_path : String = base_path.path_join(folder_name)
	
	# If the folder doesn't exist, create it immediately
	if not DirAccess.dir_exists_absolute(target_path):
		DirAccess.make_dir_recursive_absolute(target_path)
		return target_path
		
	# If it already exists, start looping to find the next available 3-digit suffix
	var counter : int = 1
	while true:
		# "%03d" formats the integer into a 3-digit padded string (e.g., 001, 002)
		var new_folder_name : String = folder_name + "_" + "%03d" % counter
		var new_target_path : String = base_path.path_join(new_folder_name)
		
		# Check if this incremented path is available
		if not DirAccess.dir_exists_absolute(new_target_path):
			DirAccess.make_dir_recursive_absolute(new_target_path)
			return new_target_path # Returns the successfully created folder path
			
		counter += 1
		
	return ""
