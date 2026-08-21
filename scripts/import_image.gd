extends Node


func import_image_to_string(file_path: String)->String:
	var image = Image.load_from_file(file_path)

	var base64_image
	
	if image:
		var image_data = image.save_png_to_buffer()
		base64_image = Marshalls.raw_to_base64(image_data)
	else:
		print("image is null")
		#var data = {
			#"image": base64_image
		#}
	return base64_image

func texture_to_base64(texture) -> String:

	if texture == null:
		return ""

	var image = texture.get_image()
	var png_data = image.save_png_to_buffer()
	
	return Marshalls.raw_to_base64(png_data)

func base64_to_texture(base64_string: String) -> Texture2D:
	var image_data = Marshalls.base64_to_raw(base64_string)
	
	var image = Image.new()
	var error = image.load_png_from_buffer(image_data)
	
	if error != OK:
		print("Failed to load image")
		return null
	
	return ImageTexture.create_from_image(image)
