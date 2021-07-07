extends Node2D

func _ready():
	_on_target_score_achieved()

#win Galaga
func _on_target_score_achieved():
	if(Global.galagaPoints == 49):
		yield(get_tree().create_timer(5),"timeout")  #5 sec timer as opposed to 10
		#queue_free()  #maybe?
		get_tree().change_scene("res://Scenes/EndScreen.tscn")
