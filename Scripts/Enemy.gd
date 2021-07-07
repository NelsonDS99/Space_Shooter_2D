extends KinematicBody2D
var enemy_explosion_particles := load("res://Scenes/Enemy1Explosion.tscn")
export var speed = 50
var velocity = Vector2()
var TurnSpeed = 0.1
var enemy_explosion_sound := load("res://Scenes/ExplosionSound.tscn")

func _physics_process(delta):
	#velocity.y +=100*delta
	#velocity = move_and_slide(velocity, Vector2(0,-1))
	if Global.player != null:
		velocity = global_position.direction_to(Global.player.global_position)
	#Has the enemy follow the player
	global_position += velocity * speed * delta
	
#Ever off screen queue free
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
#Emit particles when hit 
func _explosion_particles():
	var enemy_explosion = enemy_explosion_particles.instance()
	enemy_explosion.position = self.position
	get_parent().add_child(enemy_explosion)
	enemy_explosion.emitting = true
	
#Play the explosion sound
func _play_explosion(enemy_explosion_sound):
	var explosion = enemy_explosion_sound.instance()
	get_parent().add_child(explosion)
	explosion.play()
	
#Get rid of the enemy if hit by a bullet
func _on_Hitbox_area_entered(area):
	if area.is_in_group("Enemy_damager"):
		Global.points +=1
		_explosion_particles()
		_play_explosion(enemy_explosion_sound)
		queue_free()
