extends Node2D

@onready var pCamera = $Player/PlayerCamera
@onready var oCamera = $outerCamera

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if Input.is_action_just_pressed("swapCamera"):
		if pCamera.is_current():
			oCamera.make_current()
		elif oCamera.is_current():
			pCamera.make_current()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
