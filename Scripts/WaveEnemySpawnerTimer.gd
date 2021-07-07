extends Timer
var wave_enemy_scene := load("res://Scenes/WaveEnemy.tscn")



func _spawn_wave_enemy(num: int):
	for i in num:
		var wave_enemy = wave_enemy_scene.instance()
		_set_wave_enemy_position(wave_enemy)
		add_child(wave_enemy)
	
func _set_wave_enemy_position(wave_enemy):
	var rect = get_viewport().size
	wave_enemy.position = Vector2(rand_range(50,rect.x-50), 50)
	while(wave_enemy.position.x > 475 and wave_enemy.position.x < 525 or wave_enemy.position.x > 0 and wave_enemy.position.x < 50):
		wave_enemy.position = Vector2(rand_range(50,rect.x-50),50)

func _on_WaveEnemySpawnerTimer_timeout():
	if Global.points % 5 == 0 and Global.points > 0:  #as opposed to every other 5 (%5)
		_spawn_wave_enemy(rand_range(1,3))

