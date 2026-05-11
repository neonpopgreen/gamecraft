extends Control

# - - - version 2 , march 24 2026 
# changelog
# fix the data , from dictionary to array , and update insert_all_button() function 


#func setup (item_name : String ,  image_path , tooltip )
var image_folder_path = "res://database/images/"
var data : Array =[
	{
		"button_name" : "Actor",
		"Image_name" : "Actor",
		"button_tooltip" : " database of actors ,charcters , stats , info "
	},
	{
		"button_name" : "NPC",
		"Image_name" : "Others",
		"button_tooltip" : " database of npcs ,neutal , common , special , seller , animal "
	},
	{
		"button_name" : "Class",
		"Image_name" : "Class",
		"button_tooltip" : " database of class ,special skills "
	},
	{
		"button_name" : "Skills",
		"Image_name" : "Skills",
		"button_tooltip" : " database of skills ,damage , element effects "
	},
	{
		"button_name" : "Items",
		"Image_name" : "Items",
		"button_tooltip" : " database of items ,potions , key story items"
	},
	{
		"button_name" : "Weapons",
		"Image_name" : "Weapons",
		"button_tooltip" : " database of weapons ,shields , swords "
	},
	{
		"button_name" : "Armors",
		"Image_name" : "Armors",
		"button_tooltip" : " database of wearables ,body armor , legs armor "
	},
	{
		"button_name" : "Monsters",
		"Image_name" : "Others",
		"button_tooltip" : " database of mobs/units/objects ,exp ,item drops "
	},
	{
		"button_name" : "Status_effects",
		"Image_name" : "Others",
		"button_tooltip" : " database of debuff and buffs , poison , knockout , blessing "
	},
	{
		"button_name" : "VFX",
		"Image_name" : "Others",
		"button_tooltip" : " database of VFX , burn , smoke , heal "
	},
	{
		"button_name" : "Blocks",
		"Image_name" : "Others",
		"button_tooltip" : " database of block , minecraft blocks "
	},
	{
		"button_name" : "Systems",
		"Image_name" : "Others",
		"button_tooltip" : " database of settings , all tweakable "
	}
	]


func _ready() -> void:
	pass
	insert_all_button()
	
func insert_all_button():
	pass
	var button_blueprint = preload("res://database/menu_item.tscn")
	for item in data:
		pass
		var button_item = button_blueprint.instantiate()
		$Panel/HBoxContainer/menu/MarginContainer/VBoxContainer/VScrollBar/GridContainer.add_child(button_item)
		button_item.setup(item["button_name"],image_folder_path+item["Image_name"]+".png",item["button_tooltip"])
		
	
	
	
