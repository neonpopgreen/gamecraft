extends Panel
@onready var line_edit: LineEdit = $Panel/VBoxContainer/Panel/HBoxContainer/LineEdit

var kaka_install_palang:bool

var windows_document_path = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)

var project_folder_path_windows 
var project_folder_path_android
var project_list_folder_name = "MyAwesomeGames"

var editor_json_intro_data:Dictionary ={
	"default_project_path":"",
	"list_of_project":[],
}

func _ready() -> void:
	pass
	# on newly installed this app if folder is none
	# will show settings , project list path , defaulted to default path , search about it
	step1()
	#if kaka install palang show new project , can be exed naman  
	
	#if newly install is false
	# the app will read the content of the folder , will locate and read the readmefile
	# show the list of projects , if none thereis a plus sign

func step1():
	var project_folder_path_windows = windows_document_path.path_join(project_list_folder_name)
	
	if not DirAccess.dir_exists_absolute(project_folder_path_windows):# kapag wala pang folder nato 
		DirAccess.make_dir_absolute(project_folder_path_windows)# add the folder 
		kaka_install_palang = true
		print("kaka_install_palang"," at dinagdagan kona ng folder")
		line_edit.text = project_folder_path_windows
		#dagdsgan ng json file para sa editor settings
		#var editor_data_json_file_path = project_folder_path_windows.path_join("editor_data.json")
		#write the file 
		#var file = FileAccess.open(editor_data_json_file_path,FileAccess.WRITE)
		
		MyJson.write_a_new_json(project_folder_path_windows,"editor_data.json",editor_json_intro_data)
		
	else :
		print("meron ng folder ")
		kaka_install_palang = false
		#parse/load the editor_data.json , if missing , error and show if add a fresh one or not 

	
