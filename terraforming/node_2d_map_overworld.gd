extends Node2D

#@onready var camera_2d: Camera2D = $Camera2D


#func _input(event: InputEvent) -> void:
	#var start_mouse_position:Vector2
	#var cam_start_position:Vector2
	#
	##pag pinindot ang mouse midlle button save mo yung position 
	#if event is InputEventMouseButton:
		#if event.pressed:
			#if event.button_mask == MOUSE_BUTTON_MASK_MIDDLE:
				#start_mouse_position  = event.position
				#cam_start_position = camera_2d.position
				#print("napindot",start_mouse_position,cam_start_position)
	#
	## make the camere move if the mouse pressed middle mouse button
	#if event is InputEventMouseMotion:
		#if event.button_mask == MOUSE_BUTTON_MASK_MIDDLE:
			#pass
			##var cam=camera_2d.position
			##camera_2d.position =(cam_start_position-cam)-(event.position - start_mouse_position)
			#var zoom = 1.0
			#camera_2d.position -= event.relative * zoom
			#
			## make the cam move based on moved mouse 
			#
			#
