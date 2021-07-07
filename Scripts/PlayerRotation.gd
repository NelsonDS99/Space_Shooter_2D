extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#using the export keyword will make this variable public
#so it will appear under the "script variables" section in the Inspector
#which will allow us edit it outside of the script
export(float) var rotationValue = 0;  


func _process(_delta):  #function that will help with moving (may or may not be necessary)
	getUserInput()

func getUserInput():
	if(Input.is_action_pressed("ui_right")):   #if the user presses the "RIGHT" key (can be defined for any system in the Input Map in Project Settings)
		rotation_degrees += rotationValue;  #use rotation_degrees (pre-defined variable) to rotate the body clockwise (positive/right) a certain amount based on the rotation value previously defined
	elif(Input.is_action_pressed("ui_left")):  #otherwise if the user presses the "LEFT" key (can be defined for any system in the Input Map in Project Settings)
		rotation_degrees -= rotationValue;  #use rotation_degrees (pre-defined variable) to rotate the body counter-clockwise (negative/left) a certain amount based on the rotation value previously defined
	
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
