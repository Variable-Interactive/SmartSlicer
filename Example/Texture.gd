extends TextureRect

var rect_data: RegionUnpacker.RectData

## This example will profile process times as we increase skip_amount
## with each click
func _on_Button_pressed() -> void:
	print("Started")
	var avg_time = 0
	for i in 20:
		var time = Time.get_ticks_msec()
		var unpak := RegionUnpacker.new(10, 3)
		rect_data = unpak.get_used_rects(texture.get_image())
		avg_time += Time.get_ticks_msec() - time
	print("Average time for 20 samples is: ", avg_time/(20.0), " Milli Seconds")
	$Control.show_preview(rect_data.rects)


func _on_Texture_item_rect_changed() -> void:
	if is_instance_valid(rect_data) and not rect_data.rects.is_empty():
		$Control.show_preview(rect_data.rects)
