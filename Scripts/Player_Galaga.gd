extends KinematicBody2D

#preloading the bullet instance (preload will take the resource provided and lad it before our player is actually added into the game when we run it)
var preLoaded_bullet := preload("res://Scenes/Player_Bullet.tscn") #load the Player_Bullet scene from the resource folder using file path
#load the explosion particles
var explosion_particles_scene := load("res://Scenes/ShipExplosion.tscn")
var explosionSound := load("res://Scenes/ExplosionSound3.tscn") #for the sound when player ship explodes

#onready var music := $Music  <--- IGNORE for now... doesn't work

onready var fireDelayTimer := $Galaga_fireDelayTimer  #reference the timer node for this onready variable
onready var blasterSound = get_node("Galaga_BlasterSound")

#using the export keyword will make this variable public
#so it will appear under the "script variables" section in the Inspector
#which will allow us edit it outside of the script
#export(float) var rotationValue = 0;
export (float) var movementSpeed = 500
export(float) var fireDelay = 0.1;  #delay between bullet shots (initialize to 0.1 seconds)

#export (int) var ammo = 25;  # <-- moved to Global Script

var velocity = Vector2(0, 0)
var timesHit = 0 #checks number of times player is hit by enemies
var is_dead = false #Checks if the player is dead

func _physics_process(delta):  #function that will help with moving (may or may not be necessary)
	getUserInput(delta)
	checkShooting()

func getUserInput(delta):
	var directionVector = Vector2(0, 0)
	if is_dead == false:
		if(Input.is_action_pressed("ui_right")):   #if the user presses the "RIGHT" key (can be defined for any system in the Input Map in Project Settings)
			directionVector.x = 1
		#rotation_degrees += rotationValue;  #use rotation_degrees (pre-defined variable) to rotate the body clockwise (positive/right) a certain amount based on the rotation value previously defined
		elif(Input.is_action_pressed("ui_left")):  #otherwise if the user presses the "LEFT" key (can be defined for any system in the Input Map in Project Settings)
			directionVector.x = -1
		#rotation_degrees -= rotationValue;  #use rotation_degrees (pre-defined variable) to rotate the body counter-clockwise (negative/left) a certain amount based on the rotation value previously defined
		#elif(Input.is_action_pressed("ui_up")):  #otherwise if the user presses the "LEFT" key (can be defined for any system in the Input Map in Project Settings)
		#	directionVector.y = -1
		#elif(Input.is_action_pressed("ui_down")):  #otherwise if the user presses the "LEFT" key (can be defined for any system in the Input Map in Project Settings)
		#	directionVector.y = 1
	
	#update the velocity, and then the position based on the velocity and delta
	velocity = directionVector.normalized() * movementSpeed
	position += velocity * delta
	
	#make sure that player can't go out of screen (out of bounds)
	#var viewRect = get_viewport_rect()  #this will help us get the max (upper) bounds of the screen view
	position.x = clamp(position.x, -500, 500)  #x-value can't go lower than -500 (left bound of screen) and higher than 500 (right bound of screen)
	position.y = clamp(position.y, -275, 275)

func checkShooting():
	#ui_accept is 'Space' on PC and X on Dualshock in the Input Map, so we will use that
	#only allow a new laser to be shot when the timer is stopped
	if(Input.is_action_just_pressed("ui_accept") and fireDelayTimer.is_stopped() and is_dead == false): # and Global.currentAmmo > 0):     # I ADDED THE FEATURE WHERE PLAYER CAN ONLY SHOOT IF AMMO AVAILABLE (re-add and fully implement later)
		fireDelayTimer.start(fireDelay)  #when the player shoots, start the fireDelayTimer and have it run for as long as out fireDelay variable is
		var bullet = preLoaded_bullet.instance()  #create a new instance of the scene (so first you preload it and then you create the instance using .instance() when you want to use it)
		#get the current scene tree (tree of nodes as seen in the "Scene" section) and more specifically, the current scene of our game, and add the bullet instance to it
		get_tree().current_scene.add_child(bullet)
		
		bullet.position = position
		bullet.position.y = position.y - 35  #set the bullet postion to be the same as the player position, but offset the y-value so that bullets shoot out from the front of the shipand not fom the center of the ship
		
		#bullet.rotation_degrees = rotation_degrees #bullet rotation based on player rotation
		#bullet.apply_impulse(Vector2(), Vector2(bullet.bulletSpeed, 0).rotated(rotation))
		
		blasterSound.play()
		Global.currentAmmo = Global.currentAmmo - 1  #subtract one bullet
	
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.player = self #reference the player
	Global.galagaPoints = 0  #reset the points at the start of new game
	pass # Replace with function body.
func _exit_tree():
	Global.player = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
#Spawn the explosion particles
func _explosion_particles():
#Only activates once so that multiple explosions do not occur
	if(is_dead == false):
		var explosion_particles = explosion_particles_scene.instance()
		explosion_particles.position = self.position
		get_parent().add_child(explosion_particles)
		explosion_particles.emitting = true

#function to play sound upon player hit
func _play_explosion():
	var sound = explosionSound.instance()  #create an instance of the explosion sound
	get_parent().add_child(sound)  #add the sound as a child of parent
	sound.play() #play the sound
	#queue_free()  #only play sound once?
	
	

#Death to the player if it collides with an object
func _on_Hitbox_area_entered(area):
	
	if area.is_in_group("Enemy") or area.is_in_group("Mine"):
		timesHit += 1
		if(timesHit == 1):
			_play_explosion() #only play explosion the first time the player is hit
		_explosion_particles()
		visible = false
		is_dead = true
		yield(get_tree().create_timer(5),"timeout")  #5 sec timer as opposed to 10
		#get_tree().reload_current_scene()  #reload scene (we don't need this anymore because we are changing scenes after death
		#music.stop #stop music upon death?   <---- DOESN'T WORK
		queue_free()  #maybe?
		get_tree().change_scene("res://Scenes/MenuScreen.tscn")
		#Global.currentAmmo = Global.startingAmmo   # I RESET THE AMMO AND SCORE UPON DEATH




