class_name My_json
extends Node

func _ready() -> void:
	pass
	# test it here , all function

func add_data_to_json(folder_path:String,json_name:String,data:Dictionary)->bool:
	pass
	#load data jason
	var data1 :Dictionary = read_a_json_file_then_returns_as_dictionary(folder_path,json_name)
	# load the data to data1 , merge and replace
	var combined_data_dictinary:Dictionary = data1.duplicate()
	combined_data_dictinary.merge(data,true)
	# write 
	var file = FileAccess.open(folder_path.path_join(json_name),FileAccess.WRITE)
	file.store_string(JSON.stringify(combined_data_dictinary,"\t"))#\t for prettyness
	file.close()
	return true
	
	
## returns true if file already exist
## [br]returns false if file is nothing or file not created
func replace_json(folder_path:String,json_name:String,data:Dictionary)->bool:
	pass
	if FileAccess.file_exists(folder_path.path_join(json_name)):
		print("name : ",json_name," File exist. will delete will delete it")
		# code here : delete then create file 
		#delete
		if DirAccess.remove_absolute(folder_path.path_join(json_name)) == OK:
			print(json_name," is deleted")
			#create a file 
			var json_as_string = JSON.stringify(data)
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
		print("File does not exist. Creating file. ")
		# code here : create file 
		return false

func write_a_new_json(folder_path:String,json_name:String,data:Dictionary) -> bool:
	#check if the file exist
	if FileAccess.file_exists(folder_path.path_join(json_name)):
		print("File exist.")
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
	
