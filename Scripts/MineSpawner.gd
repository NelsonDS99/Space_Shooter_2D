extends Node

var mine_scene = load("res://Scenes/Mine.tscn")

export var velocity = Vector2()
func _ready():
	pass

#Spawn the mine
func _spawn_mine():
	var mine = mine_scene.instance()
	_set_mine_position(mine)
	add_child(mine)
	#Make it harder
	#if $MineSpawnTimer.wait_time > 2:
	#	$MineSpawnTimer.wait_time -= 0.05

#Spawn the mines at the top if we ever use it
func _set_mine_position(mine):
	var rect = get_viewport().size
	mine.position = Vector2(rand_range(0,rect.x), rand_range(-100,0))

func _on_MineSpawnTimer_timeout():
	_spawn_mine()
