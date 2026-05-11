extends Panel



func _ready() -> void:
	pass
	#setup("actors", "res://database/images/Armors.png","tooltip testing")

## setup (item_name : String ,  image_path , tooltip )
##[br] - item_name - pangalan ng button , ito yung label
##[br] - image_path - path kung nasaan ang image para sa icon ng button
##[br] - tootltip - type mo kung ano description ng button nato 
func setup (item_name : String ,  image_path , tooltip ) -> void :
	name = item_name
	$Label.text = item_name
	$Label.label_settings.font_size = 30
	$Button.tooltip_text = tooltip
	load_image_thru_path(image_path)
	pass

func load_image_thru_path(path):
	var image = load(path)
	$AspectRatioContainer/TextureRect.texture = image
	

	


func update_size() -> void:
	pass # Replace with function body.
	var percent = 0.15
	#size.y = size.x 
	custom_minimum_size.y = size.x#get_rect().size.x
	$Label.label_settings.font_size = size.y * percent
	


func _on_resized() -> void:
	update_size()
