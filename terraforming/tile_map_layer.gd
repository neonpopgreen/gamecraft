extends TileMapLayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var intro_params: Control = $"../../Intro_params"


var tilemap_pos :Vector2i
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	intro_params.intro_data.connect(intro_data_emitted)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed:
			if event.keycode == KEY_SPACE:
				print("pressed")
				set_cell(Vector2i(7,5),1,Vector2i(0,0))
	if event is InputEventMouseMotion:
		#sprite_2d.position = event.position
		var tile_size_x = self.tile_set.tile_size.x
		var tile_size_y = self.tile_set.tile_size.y
		#event.position.x = event.position.x
		var x_pos = event.position.x
		var y_pos = event.position.y
		#var condition
		#if x_pos < tile_size:
			#pass
		var tilemap_x_pos : int 
		var tilemap_y_pos : int
		while(x_pos>tile_size_x):
			tilemap_x_pos+=1
			x_pos = x_pos-tile_size_x
		sprite_2d.position.x = tilemap_x_pos * tile_size_x + tile_size_x/2.0
		while(y_pos>tile_size_y):
			tilemap_y_pos+=1
			y_pos = y_pos-tile_size_y
		sprite_2d.position.y = tilemap_y_pos * tile_size_y + tile_size_y/2.0
		tilemap_pos  = Vector2i(tilemap_x_pos,tilemap_y_pos)
			
	if event is InputEventMouseButton:
		if event.pressed:
			if event.button_mask == MOUSE_BUTTON_LEFT:
				set_cell(tilemap_pos,1,Vector2i(0,0))
	if event is InputEventMouseMotion:
		#if event.pressed:
		if event.button_mask == MOUSE_BUTTON_LEFT:
			set_cell(tilemap_pos,1,Vector2i(0,0))
	
		
		

func intro_data_emitted(vector2i,index):
	pass
	print("introdata getted",vector2i,index)
	fill_using_intro_data(vector2i,index)

func fill_using_intro_data(vector2i,index):
	for x in vector2i.x:
		for y in vector2i.y:
			set_cell(Vector2i(x,y),index,Vector2i(0,0))
	
