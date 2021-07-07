extends KinematicBody2D

var hp = 5
var mine_scene := load("res://Scenes/Mine.tscn")
var enemy_explosion_sound := load("res://Scenes/ExplosionSound2.tscn")

#Create a timer to drop the mines from the mine_enemy
func _ready():
	var timer = Timer.new()
	timer.connect("timeout", self, "_on_timer_timeout")
	timer.wait_time = 1
	add_child(timer)
	timer.start()

#Have the object follow the path
func _process(delta):
	$Path2D/PathFollow2D.set_offset($Path2D/PathFollow2D.get_offset()+(50*delta))
	if hp == 0:
		Global.points +=1
		_play_explosion(enemy_explosion_sound)
		queue_free()
#Spawn mines under the sprite
func _spawn_mine():
	var mine = mine_scene.instance()
	mine.position = $Path2D/PathFollow2D/Sprite.global_position
	get_parent().add_child(mine)

#Spawn mines
func _on_timer_timeout():
	_spawn_mine()
	
#Play the explosion sound upon death
func _play_explosion(enemy_explosion_sound):
	var explosion = enemy_explosion_sound.instance()
	get_parent().add_child(explosion)
	explosion.play()
	
#Gets hit by a bullet
func _on_Hitbox_area_entered(area):
	if area.is_in_group("Enemy_damager"):
		$Path2D/PathFollow2D/Sprite.modulate = Color.green
		$StunTimer.start()
		hp -= 1 # Replace with function body.

#Flash Green
func _on_StunTimer_timeout():
	$Path2D/PathFollow2D/Sprite.modulate = Color.white
