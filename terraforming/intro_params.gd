extends Control

@onready var line_edit: LineEdit = $Panel/VBoxContainer/Panel/VBoxContainer/HBoxContainer/LineEdit
@onready var line_edit_2: LineEdit = $Panel/VBoxContainer/Panel/VBoxContainer/HBoxContainer/LineEdit2
@onready var line_edit_index: LineEdit = $Panel/VBoxContainer/Panel2/VBoxContainer/HBoxContainer/LineEdit


signal intro_data
var map_size :Vector2i = Vector2i(16,16)
var fill_with :int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#self.visible = true
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	map_size = Vector2i(int(line_edit.text),int(line_edit_2.text))
	fill_with =int( line_edit_index.text)
	intro_data.emit(map_size,fill_with)
	visible =false
	
