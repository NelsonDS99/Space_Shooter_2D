extends KinematicBody2D


var speed = 300
onready var screen_size = get_viewport().size
var move = false
var alien_dive := load("res://Scenes/AlienDive.tscn")

func _ready():
	var timer = Timer.new()
	timer.connect("timeout",self,"_on_timer_timeout")
	timer.wait_time = rand_range(5,7)
	add_child(timer)
	timer.start()

func _process(delta):
	if(move == true):
		position.y += speed * delta
		position.y = wrapf(position.y, -300 ,screen_size.y )


func _on_Hitbox_area_entered(area):
	if area.is_in_group("Enemy_damager") or area.is_in_group("Player"):
		Global.galagaPoints += 1
		queue_free()

func _play_dive():
	var alien_sound = alien_dive.instance()
	add_child(alien_sound)
	alien_sound.play()

func _on_timer_timeout():
	move = !move
	if move == true:
		_play_dive()
