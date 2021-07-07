#THIS IS FOR THE MINE ENEMY SPAWNER

extends Timer
var mine_enemy_scene := load("res://Scenes/MineEnemy.tscn")

#Spawn the mine enemy
func _spawn_mine_enemy():
	var mine_enemy = mine_enemy_scene.instance()
	_set_mine_enemy_position(mine_enemy)
	add_child(mine_enemy)
	
#Set the enemy at the beginning of the Path every time
func _set_mine_enemy_position(mine_enemy):
	mine_enemy.position = Vector2(0,0)

#At every 7 enemies possibility of it spawning
func _on_MineEnemySpawn_timeout():
	if Global.points % 20 == 0 and Global.points > 0: #as opposed to every other 7 (%7)
		_spawn_mine_enemy()
		
	
