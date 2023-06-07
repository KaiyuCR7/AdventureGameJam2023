extends Node2D

@onready var pCamera = $Player/PlayerCamera
@onready var oCamera = $outerCamera
@onready var player = $Player
@onready var weapon = $Player/weapon/Sprite2D
@onready var weaponPoint = $Player/weapon/Sprite2D/Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	#defualt starting weapon
	weapon.frame = 0
	#defaul camera
	oCamera.make_current()

func _input(event):
	if Input.is_action_just_pressed("swapCamera"):
		zoomCam()
#	if Input.is_action_just_released("shoot"):
#		shoot()

#func shoot():
#	var bulletInstance = bulletScene.instantiate()
#	bulletInstance.set_position(weaponPoint.global_position)
#	var aimVector = get_global_mouse_position() - player.position
#	var aimRotate = aimVector.angle()
#	bulletInstance.rotation = aimRotate
#	bulletInstance.setDvelocity(aimVector)
#	add_child(bulletInstance)
#	print("Bullet Shot")

func zoomCam():
	if pCamera.is_current():
		oCamera.make_current()
	elif oCamera.is_current():
		pCamera.make_current()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
