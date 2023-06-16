extends Node2D

@onready var pCamera = $Player/PlayerCamera
@onready var oCamera = $outerCamera
@onready var player = $Player
@onready var enemy = $enemy
@onready var weapon = $Player/weapon/weaponFrames
@onready var weaponPoint = $Player/weapon/weaponFrames/Area2D

#defualt starting weapon - Pistol
@export var weaponType = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	#defualt starting weapon
	updatePlayerWeapon()
	#defaul camera
	oCamera.make_current()

func _input(event):
	if Input.is_action_just_pressed("swapCamera"):
		zoomCam()

func zoomCam():
	if pCamera.is_current():
		oCamera.make_current()
	elif oCamera.is_current():
		pCamera.make_current()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Pause Menu
	if Global.paused:
		$outerCamera/pauseMenu.visible = true
	else:
		$outerCamera/pauseMenu.visible = false

func updatePlayerWeapon():
	weapon.frame = weaponType
	player.rate_of_fire = Global.weaponData[weaponType]["Firerate"]
	player.fireSpeed = Global.weaponData[weaponType]["Speed"]
	player.projectiles = Global.weaponData[weaponType]["Projectiles"]
	player.bulletLife = Global.weaponData[weaponType]["Lifetime"]

func _on_option_button_item_selected(index):
	weaponType = index
	updatePlayerWeapon()
