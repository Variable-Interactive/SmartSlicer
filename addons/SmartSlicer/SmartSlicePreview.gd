extends Control
## Add this as a child of the texturerect that contains the main spritesheet
## the stretch_mode of the texture muat be STRETCH_KEEP_ASPECT_CENTERED

var color := Color("6680ff")  ## Set this to a theme color later
var _sliced_rects: Array[Rect2i]
var _stretch_amount: float
var _offset: Vector2


func show_preview(sliced_rects: Array[Rect2i]) -> void:
	var texture_rect = get_parent()
	match texture_rect.stretch_mode:
		texture_rect.STRETCH_KEEP_ASPECT_CENTERED:
			stretch_keep_aspect_centered()
		_:
			return
	_sliced_rects = sliced_rects.duplicate()
	queue_redraw()


func _draw() -> void:
	draw_set_transform(_offset, 0, Vector2.ONE)
	for i in _sliced_rects.size():
		var rect := _sliced_rects[i]
		var scaled_rect: Rect2 = rect
		scaled_rect.position = (scaled_rect.position * _stretch_amount)
		scaled_rect.size *= _stretch_amount
		draw_rect(scaled_rect, color, false)
		# show number
		draw_set_transform(_offset + scaled_rect.position, 0, Vector2.ONE)
		var font: Font = Control.new().get_theme_font("font")
		var font_height := font.get_height()
		draw_string(font, Vector2(1, font_height), str(i))
		draw_set_transform(_offset, 0, Vector2.ONE)


# Setups for different stretch modes
func stretch_keep_aspect_centered():
	var texture_size = get_parent().texture.get_size()
	var aspect = texture_size.x / texture_size.y
	var occupied_image_size = texture_size
	if texture_size.x < size.x and (size.x / aspect) <= size.y:
		occupied_image_size.x = size.x
		occupied_image_size.y = (size.x / aspect)
	else:
		occupied_image_size.y = size.y
		occupied_image_size.x = (size.y * aspect)

	if texture_size.x > texture_size.y:
		_stretch_amount = occupied_image_size.x / texture_size.x
	else:
		_stretch_amount = occupied_image_size.y / texture_size.y
	_offset = (0.5 * (size - (texture_size * _stretch_amount))).floor()
