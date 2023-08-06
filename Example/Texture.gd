extends TextureRect

var rect_data: RegionUnpacker.RectData

# roughly 665886 with old imp
func _on_Button_pressed() -> void:
	var time = Time.get_ticks_usec()
	var unpak := RegionUnpacker.new(10, 3)
	rect_data = unpak.get_used_rects(texture.get_image())
	$Control.show_preview(rect_data.rects)
	print(Time.get_ticks_usec() - time)


func _on_Texture_item_rect_changed() -> void:
	if is_instance_valid(rect_data) and not rect_data.rects.is_empty():
		$Control.show_preview(rect_data.rects)
