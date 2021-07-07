extends RigidBody2D

var mine_explosion_particles := load("res://Scenes/MineParticles.tscn")


#Leaves the screen disappear
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

#Adds explosion animation upon death
func _explosion_particles():
	var mine_explosion = mine_explosion_particles.instance()
	mine_explosion.position = self.position
	get_parent().add_child(mine_explosion)
	mine_explosion.emitting = true
	yield(get_tree().create_timer(4),"timeout")
	get_parent().remove_child(mine_explosion)
	get_tree().remove_timer

#Hits a bullet
func _on_Hitbox_area_entered(area):
	if area.is_in_group("Enemy_damager"):
		_explosion_particles()
		queue_free()
