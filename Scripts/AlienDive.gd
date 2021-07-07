extends AudioStreamPlayer2D



func _process(delta):
	if playing == false:
		queue_free()
