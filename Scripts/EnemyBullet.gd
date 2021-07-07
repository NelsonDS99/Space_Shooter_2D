extends Area2D

var speed = 400
func _ready():
	scale.x = 0.5
	scale.y = 0.6
func _physics_process(delta):
	position -= transform.y * speed * delta
	 


func _on_EnemyBullet_area_entered(area):
	if area.is_in_group("Player") or area.is_in_group("Enemy_damager"):
		queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
