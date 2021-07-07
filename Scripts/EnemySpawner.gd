extends Node

var enemy_scene = load("res://Scenes/Enemy.tscn")
export var velocity = Vector2()


func _ready():
	pass
	
#Spawns the enemy
func _spawn_enemy(num: int):
	for i in num:
		var enemy = enemy_scene.instance()
		_set_enemy_position(enemy)
		add_child(enemy)
	#if $SpawnTimer.wait_time > 2:
	#	$SpawnTimer.wait_time -= 0.05
#Sets the enemy position
func _set_enemy_position(enemy):
	#Get the screen size
	var rect = get_viewport().size
	enemy.position = Vector2(rand_range(-200, rect.x + 200), rand_range(-600, 0))  #rand_range(-200,0) for y-axis originally  rand_range(-200, ret.x+200) for x-axis
	#enemy.position.y = clamp(enemy.position.y, -600, 300)   #rect.y-600
	
	#IGNORE THESE...TRYING TO STOP SPAWN OVERLAP
	#var enemyOffsetX = enemy.get_node("Hitbox").shape.get_extents().x/2
	#var enemyOffsetZ = enemy.get_node("Hitbox").shape.get_extents().z/2
	
	
	
#Timer to spawn the enemies
func _on_SpawnTimer_timeout():
	_spawn_enemy(rand_range(5,7)) #Change spawn to randomize (1,6) originally
	
	
