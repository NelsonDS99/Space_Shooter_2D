extends KinematicBody2D

var enemy_bullet_scene := preload("res://Scenes/BossBullet.tscn")
var explosion_sound_scene := load("res://Scenes/ExplosionSound3.tscn")
var explosion_particles_scene := load("res://Scenes/EnemyRedExplosion.tscn")
var hp = 100
var speed = 100
var right = true
#Spawn timer
func _ready():
	var timer = Timer.new()
	timer.connect("timeout", self, "_on_timer_timeout")
	timer.wait_time = 1.5  #timer between shots
	add_child(timer)
	timer.start()
	
#Control the path follow
func _process(delta):
	if(position.x > 500):
		right = false
	if(position.x < -500):
		right = true
	if(right == true):
			position.x += delta * speed
	else:
		position.x -= delta * speed
	if hp == 0:
		Global.points += 1
		_explosion_particles()
		_play_explosion()
		queue_free()

func _play_explosion():
	var explosion_sound = explosion_sound_scene.instance()
	get_parent().add_child(explosion_sound)
	explosion_sound.play()
	
func _explosion_particles():
	var explosion_particles = explosion_particles_scene.instance()
	explosion_particles.position = position
	get_parent().add_child(explosion_particles)
	explosion_particles.emitting = true

func _spawn_bullet1():
	var bullet = enemy_bullet_scene.instance()
	bullet.transform = $Front.transform
	bullet.position = position
	get_parent().add_child(bullet)

func _spawn_bullet2():
	var bullet = enemy_bullet_scene.instance()
	bullet.transform = $LeftSide.transform
	bullet.position = position
	get_parent().add_child(bullet)

func _spawn_bullet3():
	var bullet = enemy_bullet_scene.instance()
	bullet.transform = $RightSide.transform
	bullet.position = position
	get_parent().add_child(bullet)


func _on_timer_timeout():
	_spawn_bullet1()
	_spawn_bullet2()
	_spawn_bullet3()


func _on_Hitbox_area_entered(area):
	if area.is_in_group("Enemy_damager"):
		hp -= 5
		$HealthDisplay/Healthbar.value -= 5
		$AnimatedSprite.modulate = Color.greenyellow
		


func _on_StunTimer_timeout():
	$AnimatedSprite.modulate = Color.white
