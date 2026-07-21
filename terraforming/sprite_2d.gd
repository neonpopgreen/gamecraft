extends Sprite2D

@export var paint_color : Color = Color.RED
@export var image_size : Vector2i = Vector2i(1000,500)
@onready var sprite_2d_2: Sprite2D = $"../Sprite2D2"
@export var brush_texture :Texture2D 


var img : Image 
var brush_size := 50

func _ready() -> void:
	img = Image.create_empty(image_size.x,image_size.y,false,Image.FORMAT_RGBA8)
	img.fill(Color.WHITE)
	texture = ImageTexture.create_from_image(img)
	
func paint_to(pos : Vector2i) -> void:
	#img.set_pixelv(pos,paint_color)
	#img.fill_rect(Rect2i(pos,Vector2i(1,1)).grow(brush_size),paint_color)
	
	var brush = brush_texture.get_image()
	brush.resize(brush_size,brush_size)
	
	for x in brush.get_size().x:
		for y in brush.get_size().y:
			var cc :=brush.get_pixel(x,y)
			brush.set_pixel(x,y,paint_color*cc)
	img.blend_rect(brush,brush.get_used_rect(),pos -Vector2i(brush_size/4,brush_size/4) )
	
# is_echo means hold pressing it down , because os spam it if hold down press
# lpos , to_local() ? what the fuck , should i be testing it or nah , nah  
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.is_echo() == false :
			if event.button_index == MOUSE_BUTTON_LEFT:
				#var lpos = to_local(event.position)
				#var impos = lpos-offset+get_rect().size/2.0
				var test = event.position - position
				sprite_2d_2.position = test
				paint_to(test)
				texture.update(img)
			if event.button_index == MOUSE_BUTTON_RIGHT:
				var test = event.position - position
				sprite_2d_2.position = test
				paint_color = img.get_pixelv(test)
			if event.button_index == MOUSE_BUTTON_MIDDLE:
				img.fill(Color.WHITE)
				texture.update(img)
	if event is InputEventMouseMotion:
		if event.button_mask == MOUSE_BUTTON_LEFT:
			var test = event.position - position
			if event.relative.length_squared()>0:
				var num:=ceili(event.relative.length())
				var target_pos = test - (event.relative)
				for i in num:
					test = test.move_toward(target_pos,1.0)
					paint_to(test)
					texture.update(img)
			
			texture.update(img)
			
			
			
