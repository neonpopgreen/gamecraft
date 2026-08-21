extends VBoxContainer


#@onready var label: Label = $Panel/HBoxContainer/Panel/VBoxContainer/Label
@onready var label: Label = $Panel/HBoxContainer/Panel/VBoxContainer/ScrollContainer/Label
@onready var project_icon: TextureRect = $Panel/HBoxContainer/Project_Icon
@onready var bbcode_name: RichTextLabel = $Panel/HBoxContainer/Panel/VBoxContainer/bbcode_name
@onready var bbcode_description: RichTextLabel = $Panel2/bbcode_description

func fill(dictionary_data:Dictionary):
	
	bbcode_name.text = dictionary_data["project_name"]
	
	# - - - - - - - - - - - - - - - - - - - -
	var version
	if not dictionary_data.has("version"):
		var dict = {"version":"0.001"}
		# add version key 
		MyJson.add_data_to_json(dictionary_data["project_folder_location"],"project_data.json",dict)
		version = "0.001"
	else:
		version = dictionary_data["version"]
	
	# - - - - - - - - - - - - - - - - - - - -
	var created
	var months : Array = ["zero","jan","feb","mar","apr","may","jun","jul","aug","sep","oct","nov","dec"]
	created = str(months[dictionary_data["date_created"]["month"]])+" "+str(int(dictionary_data["date_created"]["day"]))+" "+str(int(dictionary_data["date_created"]["year"]))
	
	# - - - - - - - - - - - - - - - - - - - -
	var modified
	if not dictionary_data.has("modified"):
		var dict = dictionary_data["date_created"]
		# add version key 
		MyJson.add_data_to_json(dictionary_data["project_folder_location"],"project_data.json",dict)
		modified = dict
	else:
		modified = dictionary_data["modified"]
	print(modified)
	#modified = str(months[dictionary_data["modified"]["month"]])+" "+str(dictionary_data["modified"]["day"])+" "+str(dictionary_data["modified"]["year"])
	modified = months[modified["month"]]+" "+str(int(modified["day"]))+" "+str(int(modified["year"]))
	
	
	# - - - - - - - - - - - - - - - - - - - -
	var size1
	size1 = get_folder_size(dictionary_data["project_folder_location"])
	size1 = folderSizeInt_to_string_mb(size1)
	
	# - - - - - - - - - - - - - - - - - - - -
	var creating_time
	if not dictionary_data.has("creating_time"):
		var dict = {"hours":0,"minutes":0,"seconds":0}
		# add version key 
		MyJson.add_data_to_json(dictionary_data["project_folder_location"],"project_data.json",dict)
		creating_time = dict
	else:
		creating_time = dictionary_data["creating_time"]
	creating_time = str(int(creating_time["hours"]))+":"+str(int(creating_time["minutes"]))+":"+str(int(creating_time["seconds"]))
	# - - - - - - - - - - - - - - - - - - - -
	var git_upload
	if not dictionary_data.has("git_upload"):
		var dict = {"git_upload":"to be implemented"}
		# add version key 
		MyJson.add_data_to_json(dictionary_data["project_folder_location"],"project_data.json",dict)
		git_upload = dict["git_upload"]
	else:
		git_upload = dictionary_data["git_upload"]
	
	# - - - - - - - - - - - - - - - - - - - -
	var session_days
	if not dictionary_data.has("session_days"):
		var dict = {"session_days":"to be implemented"}
		# add version key 
		MyJson.add_data_to_json(dictionary_data["project_folder_location"],"project_data.json",dict)
		session_days = dict["session_days"]
	else:
		session_days = dictionary_data["session_days"]
	# - - - - - - - - - - - - - - - - - - - -
	var path
	path = dictionary_data["project_folder_location"]
	
	# - - - - - - - - - - - - - - - - - - - -
	var description
	bbcode_description.text = "description:\n"+dictionary_data["project_description"]
	
	# - - - - - - - - - - - - - - - - - - - -icon
	project_icon.texture = ImportImage.base64_to_texture(dictionary_data["project_icon"])
	
	# - - - - - - - - - - - - - - - - - - - -array picture
	
	label.text = "version : "+version+"\ncreated : "+created+"\nmodified : "+modified+"\nsize : "+size1+"\ncreating time : "+creating_time+"\ngit upload date : "+git_upload+"\nsession days : "+session_days+"\npath : "+path
#"version :
#created	: s%
#modified	: s%
#size : s%
#creating time : s%
#git upload date : s%
#session days :  40 days , 3hr average s%
#path : s%" %[version,created,modified,size1,creating_time,git_upload,session_days,path]
	

func get_folder_size(path: String) -> int:
	var total_size := 0
	var dir := DirAccess.open(path)

	if dir == null:
		return 0

	dir.list_dir_begin()
	var file_name = dir.get_next()

	while file_name != "":
		var full_path = path.path_join(file_name)

		if dir.current_is_dir():
			total_size += get_folder_size(full_path)
		else:
			total_size += FileAccess.get_size(full_path)

		file_name = dir.get_next()

	dir.list_dir_end()

	return total_size # - - - - - - - - - -
	
func folderSizeInt_to_string_mb(size1:int)->String:
	var size_mb = size1 / 1024.0 / 1024.0
	return ("%.3f MB" % size_mb)
	
	
	
