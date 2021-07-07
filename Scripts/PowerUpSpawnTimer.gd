extends Timer

var powerup_scene := load("res://Scenes/Ammo_powerup.tscn")

func _spawn_powerup():
	var powerup = powerup_scene.instance()
	powerup.position = Vector2(rand_range(200,1000), rand_range(-500,-400))
	add_child(powerup)

func _on_PowerUpSpawnTimer_timeout():
	_spawn_powerup()
