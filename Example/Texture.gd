extends TextureRect

var rect_data: Dictionary

# roughly 665886 with old imp
func _on_Button_pressed() -> void:
	var time = Time.get_ticks_usec()
	var unpak := RegionUnpacker.new(10, 3)
	rect_data = unpak.get_used_rects(texture.get_data())
	$Control.show_preview(rect_data["rects"])
	print(Time.get_ticks_usec() - time)



func _on_Texture_item_rect_changed() -> void:
	if "rects" in rect_data.keys():
		$Control.show_preview(rect_data["rects"])
