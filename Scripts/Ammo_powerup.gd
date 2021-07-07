extends RigidBody2D


onready var ammoPing = get_node("AmmoPing")

func _on_Hitbox_area_entered(area):
	if area.is_in_group("Player"):
		Global.currentAmmo += 50
		queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
