extends ParallaxBackground

var speed_background = -200

func _process(delta):
	scroll_offset.x += speed_background*delta
