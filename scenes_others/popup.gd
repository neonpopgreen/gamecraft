extends PopupPanel

@onready var label: Label = $VBoxContainer/Label

func _ready() -> void:
	print("popup")

func text(sulat:String):
	label.text = sulat


func _on_ok_button_pressed() -> void:
	pass # Replace with function body.
	queue_free()
