extends KinematicBody2D

var speed = 100
var right = true 
var compare = 0
var enemy_bullet_scene := load("res://Scenes/EnemyBullet.tscn")

func _ready():
	var timer = Timer.new()
	timer.connect("timeout",self,"_on_timer_timeout")
	timer.wait_time = rand_range(7,12)
	add_child(timer)
	timer.start()

func _process(delta):
	if right == true:
		position.x += speed * delta
	else:
		position.x -= speed * delta

func _spawn_enemy_bullet():
	var enemy_bullet = enemy_bullet_scene.instance()
	enemy_bullet.transform = $Front.transform
	enemy_bullet.position = position
	get_parent().add_child(enemy_bullet)

func _on_Movement_timeout():
	right = !right

func _on_timer_timeout():
	_spawn_enemy_bullet()

func _on_Hitbox_area_entered(area):
	if area.is_in_group("Enemy_damager"):
		Global.galagaPoints += 1
		queue_free()
