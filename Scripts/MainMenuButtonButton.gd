extends Button

export var referencePath = ""  #this will hold the path to the scene we want it to take us to
export(bool) var startFocused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if(startFocused):
		grab_focus()  #if the button is in focus, grab it
	connect("mouse_entered", self, "_on_Button_mouse_entered")  #connect the mouse hovering functionality
	connect("pressed", self, "_on_Button_pressed")

func _on_Button_mouse_entered():
	grab_focus()
	
func _on_Button_pressed():
	if(referencePath != ""):
		get_tree().change_scene(referencePath)  #if given a reference path to a scene (if referencePath is not empty), change to that scene
	else:
		get_tree().quit()  #otherwise, quit
