extends Node

var kaka_install_palang
var windows_document_path = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
var project_list_folder_name = "MyAwesomeGames"

func _ready() -> void:
	var path = windows_document_path.path_join(project_list_folder_name)
	
	if not DirAccess.dir_exists_absolute(path):# kapag wala pang folder nato 
		DirAccess.make_dir_absolute(path)# add the folder 
		kaka_install_palang = true
		print("kaka_install_palang"," at dinagdagan kona ng folder")
	else :
		print("meron ng folder ")
		kaka_install_palang = false
		
	get_tree().quit()
	
