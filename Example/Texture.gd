extends TextureRect

var rect_data: Dictionary

func _on_Button_pressed() -> void:
	var unpak := RegionUnpacker.new(10, 3)
	rect_data = unpak.get_used_rects(texture.get_data())
	$Control.show_preview(rect_data["rects"])



func _on_Texture_item_rect_changed() -> void:
	if "rects" in rect_data.keys():
		$Control.show_preview(rect_data["rects"])
