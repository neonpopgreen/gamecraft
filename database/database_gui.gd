extends Control

#func setup (item_name : String ,  image_path , tooltip )
var image_folder_path = "res://database/images/"
var data : Dictionary ={
	0 : {
		"button_name" : "Actor",
		"Image_name" : "Actor",
		"button_tooltip" : " database of actors ,charcters , stats , info "
	},
	1 : {
		"button_name" : "NPC",
		"Image_name" : "Others",
		"button_tooltip" : " database of npcs ,neutal , common , special , seller , animal "
	},
	2 : {
		"button_name" : "Class",
		"Image_name" : "Class",
		"button_tooltip" : " database of class ,special skills "
	},
	3 : {
		"button_name" : "Skills",
		"Image_name" : "Skills",
		"button_tooltip" : " database of skills ,damage , element effects "
	},
	4 : {
		"button_name" : "Items",
		"Image_name" : "Items",
		"button_tooltip" : " database of items ,potions , key story items"
	},
	5 : {
		"button_name" : "Weapons",
		"Image_name" : "Weapons",
		"button_tooltip" : " database of weapons ,shields , swords "
	},
	6 : {
		"button_name" : "Armors",
		"Image_name" : "Armors",
		"button_tooltip" : " database of wearables ,body armor , legs armor "
	},
	7 : {
		"button_name" : "Monsters",
		"Image_name" : "Others",
		"button_tooltip" : " database of mobs ,exp ,item drops "
	},
	8 : {
		"button_name" : "Status_effects",
		"Image_name" : "Others",
		"button_tooltip" : " database of debuff and buffs , poison , knockout , blessing "
	},
	9 : {
		"button_name" : "VFX",
		"Image_name" : "Others",
		"button_tooltip" : " database of VFX , burn , smoke , heal "
	},
	10 : {
		"button_name" : "Blocks",
		"Image_name" : "Others",
		"button_tooltip" : " database of block , minecraft blocks "
	},
	11 : {
		"button_name" : "Systems",
		"Image_name" : "Others",
		"button_tooltip" : " database of settings , all tweakable "
	}
	
}

func _ready() -> void:
	pass
	#print(data[1]["value2"])
	#print("size :",data[1]["value1"].size()) no size pag hindi sya array o dictionary
	# print(" data wia array ",data[1][1]) not working need the key talaga
	insert_all_button()
	
func insert_all_button():
	pass
	var button_blueprint = preload("res://database/menu_item.tscn")
	for item in data:
		pass
		var button_item = button_blueprint.instantiate()
		#print(data[item]["button_name"],image_folder_path+data[item]["button_name"]+".png",data[item]["button_tooltip"])
		#print(data[item]["button_name"],image_folder_path+item.button_name+".png",data[item]["button_tooltip"])
		#button_item.setup(item["button_name"],image_folder_path+item.button_name+".png",item["button_tooltip"])
		$Panel/HBoxContainer/menu/MarginContainer/VBoxContainer/VScrollBar/GridContainer.add_child(button_item)
		button_item.setup(data[item]["button_name"],image_folder_path+data[item]["Image_name"]+".png",data[item]["button_tooltip"])
		
	
	
	
