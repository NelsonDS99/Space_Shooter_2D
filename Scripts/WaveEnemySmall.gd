extends "res://Scripts/WaveEnemy.gd"

export var velocity = 50
export var speed = 20
var enemy_explosion := load("res://Scenes/ExplosionSound3.tscn")
func _physics_process(delta):
	#velocity.y +=100*delta
	#velocity = move_and_slide(velocity, Vector2(0,-1))
	if Global.player != null:
		velocity = global_position.direction_to(Global.player.global_position)
	#Has the enemy follow the player
	global_position += velocity * speed * delta

#Gets hit by a bullet
func _on_Hitbox_area_entered(area):
	if area.is_in_group("Enemy_damager"):
		_explosion_particles()
		_play_explosion(enemy_explosion)
		queue_free()

#Play explosion
func _play_explosion(enemy_explosion):
	var explosion = enemy_explosion.instance()
	get_parent().add_child(explosion)
	explosion.play()
	
