extends Node

@export var can_toggle_pause = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if can_toggle_pause:
		if Input.is_action_just_released("pause"):
			print("here")
			pauseHandler()

func pauseHandler():
	if Global.paused:
		Global.paused = false
		get_tree().paused = false
	else:
		Global.paused = true
		get_tree().paused = true
