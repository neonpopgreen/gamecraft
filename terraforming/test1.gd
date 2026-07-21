extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@export var color : Color
var img 
var integer :int =1
@export var logo : Texture2D
@export var logo2 : Texture2D


func _ready() -> void:
	# create_empty(width: int, height: int, use_mipmaps: bool, format: Format)

	sprite_2d.texture = ImageTexture.new()
	img= Image.create_empty(500,500,false,Image.FORMAT_RGBA8)
	img.fill(Color.RED)
	sprite_2d.texture.set_image(img)
	img.fill(Color.GREEN)
	sprite_2d.texture.update(img) # or set_image()
	img.fill_rect(Rect2i(10,10,100,100), Color.AQUA)
	sprite_2d.texture.update(img)
	
	img.blit_rect(logo.get_image(),Rect2i(Vector2(-300,0),logo.get_size()/2),Vector2i(1,100))
	#conclusion
	# - dist : position ng image , not centered  
	# - rect2i position : position ng logo sa loob ng rectangle
	# pag yung logos position inside of rect may hollow na dahil minuve , magiging alpha sya , means transparent , kita na pinatungan nya 
	sprite_2d.texture.update(img)
	img.blend_rect(logo.get_image(),Rect2i(Vector2(0,-100),logo.get_size()/2),Vector2i(1,100))
	#img.adjust_bcs(1,1,2)
	sprite_2d.texture.update(img)
