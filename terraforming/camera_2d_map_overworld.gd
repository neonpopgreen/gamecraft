extends Camera2D

var dragging: bool = false:
	set(value):
		#print("dragging : ",value)
		dragging = value
	
var zoom_power_of_scroll_wheel:float = 0.01

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_MIDDLE:
			dragging = event.pressed
	elif event is InputEventMouseMotion and dragging:
		# Move camera opposite to mouse motion vector, scaled by zoom
		position -= event.relative / zoom
		#print("moving")
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			#print("zoom down") # dala dalawa ang lumalabas
			zoom -=Vector2(zoom_power_of_scroll_wheel,zoom_power_of_scroll_wheel)
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			#print("zoom up") # dala dalawa ang lumalabas
			zoom +=Vector2(zoom_power_of_scroll_wheel,zoom_power_of_scroll_wheel)
		
