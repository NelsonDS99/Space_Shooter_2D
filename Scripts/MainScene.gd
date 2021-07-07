extends Node2D
var boss_scene := load("res://Scenes/Boss.tscn")
var boss_spawned = false
func _ready():
	pass

#If the boss is spawned pause blue enemies, start timer when boss is dead
func _process(delta):
	var boss = boss_scene.instance()
	if(Global.points % 50 == 0 and boss_spawned == false and Global.points != 0):
		_spawn_boss()
		boss_spawned = true
		$EnemySpawner/SpawnTimer.paused = true  #the spawners are named differently
		$MineEnemySpawner/MineEnemySpawn.paused = true   #the spawners are named differently
		$WaveEnemySpawner/WaveEnemySpawnerTimer.paused = true  #the spawners are named differently
	if(has_node("Boss") == false):
		if($EnemySpawner/SpawnTimer.paused == true):
			boss_spawned = false
			$EnemySpawner/SpawnTimer.paused = false
			$MineEnemySpawner/MineEnemySpawn.paused = false   #the spawners are named differently
			$WaveEnemySpawner/WaveEnemySpawnerTimer.paused = false  #the spawners are named differently

#Spawn the actual boss
func _spawn_boss():
	var boss = boss_scene.instance()
	boss.position = Vector2(0,-200)
	add_child(boss)
	
