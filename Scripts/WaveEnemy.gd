extends KinematicBody2D
var enemy_explosion_particles := load("res://Scenes/EnemyGreenExplosion.tscn")
var small_wave_enemy_scene := load("res://Scenes/WaveEnemySmall.tscn")
var hp = 3
var enemy_explosion_sound := load("res://Scenes/ExplosionSound2.tscn")
func _ready():
	var timer = Timer.new()
	timer.connect("timeout", self, "_on_timer_timeout")
	timer.wait_time = 3
	add_child(timer)
	timer.start()


func _process(delta):
	if hp == 0:
		Global.points +=1
		_explosion_particles()
		_play_explosion(enemy_explosion_sound)
		queue_free()


func _explosion_particles():
	var enemy_explosion = enemy_explosion_particles.instance()
	enemy_explosion.position = self.position
	get_parent().add_child(enemy_explosion)
	enemy_explosion.emitting = true
	
#If hit by a bullet get rid of the enemy
func _on_Hitbox_area_entered(area):
	if area.is_in_group("Enemy_damager"):
		$Sprite.modulate = Color.red
		$StunTimer.start()
		hp -= 1
		
func _play_explosion(enemy_explosion_sound):
	var explosion = enemy_explosion_sound.instance()
	get_parent().add_child(explosion)
	explosion.play()
	
func _spawn_small_enemy():
	var wave_enemy_small = small_wave_enemy_scene.instance()
	wave_enemy_small.position = self.position
	get_parent().add_child(wave_enemy_small)
	
func _on_timer_timeout():
	_spawn_small_enemy()


func _on_StunTimer_timeout():
	$Sprite.modulate = Color.white
