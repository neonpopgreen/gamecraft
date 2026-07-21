class_name Biomes_database
extends Node

#data
# index , name 

var Biomes : Array[Biome]

var Biome_json_test:Array =[
	["Plains"],
	["Forest"],
	["Sand"],
	["Snow"],
	["Lava"]
]

var image_path
var image_x_and_y

class Biome:
	var index:int
	var name: String
	var image
	
func _ready() -> void:
	pass
	#print(Biome_json_test["Plains"])
