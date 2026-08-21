extends Panel

@onready var icon1: TextureRect = $HBoxContainer/Icon
@onready var number1: Label = $HBoxContainer/Number
@onready var name1: Label = $HBoxContainer/Name

@onready var v_box_details: VBoxContainer = $"../../../../../VBoxDetails"

#@onready var v_box_details: VBoxContainer = %VBoxDetails

var project_data_json_dictionary : Dictionary 

func fill(proj_name:String,number:String,icon,darken_panel : bool,project_data_json:Dictionary) :
	name1.text = proj_name
	number1.text = number
	icon1.texture = icon
	if darken_panel:
		#change color
		var style = preload("res://other/new_style_box_flat.tres" )
		add_theme_stylebox_override("panel",style)
	#assign data
	project_data_json_dictionary = project_data_json



	
	


func _on_item_pressed() -> void:
	pass # Replace with function body.
	v_box_details.fill(project_data_json_dictionary)
	
	
