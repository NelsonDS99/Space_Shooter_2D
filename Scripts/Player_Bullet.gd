extends Area2D

var bulletVelocity = Vector2()
export var bulletSpeed : float = 500  #bullet speed in pixels

#this function will contain the movement handling (_physics_process is a predefined function)
func _physics_process(delta):
	#every frame, subtract from the y-position of the bullet (remember that negative y position means going up since window starts at (0, 0)
	position.y -= bulletSpeed * delta  #move up on the screen a given number of pixels (based on bulletSpeed) every second (multiplying by delta)
	

#for when the bullet leaves the screen, we want to despawn it (better for processing)
func _on_VisibilityNotifier2D_screen_exited():
	queue_free() #remove it from the parent tree and dispose of it
	pass # Replace with function body.

#function to check bullet collsion with enemies
func _on_Player_Bullet_body_entered(body):
	#if the bullet collides with something that is not a player
	if(!body.is_in_group("Player")):
		queue_free() #delete the bullet
		#THE REST OF YOUR CODE GOES HERE


func _on_Player_Bullet_area_entered(area):
	if area.is_in_group("Mine") or area.is_in_group("Enemy"):
		queue_free()
