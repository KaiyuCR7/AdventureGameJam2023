extends CharacterBody2D

#For Player Movement
const MAX_SPEED = 200
const ACCELERATION = 100 
const FRICTION = 80

#For Weapon aim and shoot
var lookDirection = 1
var can_fire = true
var rate_of_fire = 0.5
var fireSpeed = 10
var bulletSpread = 0.1
var projectiles = 1
var bulletLife = 2

@onready var animationPlayer = $AnimationPlayer 
@onready var weaponPoint = $weapon/weaponFrames/Area2D
@onready var weaponSprite = $weapon/weaponFrames

var bullet = preload("res://Scenes/MainScenes/bullet.tscn")
var bullet2 = preload("res://Scenes/MainScenes/bulletTest.tscn")


func _process(delta):
	aim()
	move(delta)
	shoot()
	
	Global.setPlayerPositionX(self.global_position.x)
	Global.setPlayerPositionY(self.global_position.y)

func aim():
	#aim Weapon
	var aimVector = get_global_mouse_position() - self.position
	var aimRotate = aimVector.angle()
	weaponSprite.rotation = aimRotate
	if aimRotate > 1.57 || aimRotate < -1.57:
		weaponSprite.flip_v = true
		#looking left
		lookDirection = 2
		
	else:
		weaponSprite.flip_v = false
		#looking right
		lookDirection = 1
		
func shoot():
	if Input.is_action_pressed("shoot") and can_fire == true:
		can_fire = false
		var bulletSpreadList = []
		var count2 = 0
		var counter = 0
		var prevSwap = 1
		for i in range(projectiles):
			count2 = count2 + 1
			if count2 == 2:
				counter = counter + 1
				count2 = 0
			bulletSpreadList.append(bulletSpread * counter * prevSwap)
			prevSwap = prevSwap * -1
		for i in range(projectiles):
			var bullet_instance = bullet2.instantiate()
			bullet_instance.set_position(weaponPoint.global_position)
			bullet_instance.rotation = get_angle_to(get_global_mouse_position()) - bulletSpreadList[i]
			bullet_instance.bulletSpeed = fireSpeed
			bullet_instance.life_time = bulletLife
			get_parent().add_child(bullet_instance)
		await get_tree().create_timer(rate_of_fire).timeout
		can_fire = true

func move(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("MoveRight") - Input.get_action_strength("MoveLeft")
	input_vector.y = Input.get_action_strength("MoveDown") - Input.get_action_strength("MoveUp")
	
	if input_vector != Vector2.ZERO:
#		if input_vector.x > 0:
#			animationPlayer.play("RunRight")
#			lookDirection = 1
#		elif input_vector.x < 0:
#			animationPlayer.play("RunLeft")
#			lookDirection = 2
		if lookDirection == 1:
			animationPlayer.play("RunRight")
		elif lookDirection == 2:
			animationPlayer.play("RunLeft")
			
		if input_vector.x == 0 && lookDirection == 1:
			animationPlayer.play("RunRight")
		elif input_vector.x == 0 && lookDirection == 2:
			animationPlayer.play("RunLeft")
		velocity.x = move_toward(0, input_vector.x * MAX_SPEED, ACCELERATION * delta)
		velocity.y = move_toward(0, input_vector.y * MAX_SPEED, ACCELERATION * delta)
	elif input_vector == Vector2.ZERO:
#		if input_vector.x > 0:
#			animationPlayer.play("IdleRight")
#			lookDirection = 1
#		elif input_vector.x < 0: 
#			animationPlayer.play("IdleLeft")
#			lookDirection = 2
		if lookDirection == 1:
			animationPlayer.play("IdleRight")
		elif lookDirection == 2:
			animationPlayer.play("IdleLeft")
		velocity.x = move_toward(input_vector.x * MAX_SPEED, 0, FRICTION * delta)
		velocity.y = move_toward(input_vector.y * MAX_SPEED, 0 , FRICTION * delta)
	#normalize velocity
	velocity = velocity.normalized() * MAX_SPEED
	
	move_and_slide()
