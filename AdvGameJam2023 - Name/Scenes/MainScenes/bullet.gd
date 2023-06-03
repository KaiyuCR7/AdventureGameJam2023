extends CharacterBody2D

var bulletSpeed = 10
var inputVelocity = Vector2.ZERO

func setBulletSpeed(speed):
	self.bulletSpeed = speed
	
func setVelocity(bulletVel):
	print(bulletVel)
	self.inputVelocity = bulletVel

func _ready():
	print("bullet Ready")
#	print(velocity)
#	print(inputVelocity)


func _process(delta):
#	velocity.x = move_toward(0,inputVelocity.x * bulletSpeed, delta * bulletSpeed)
#	velocity.y = move_toward(0,inputVelocity.y * bulletSpeed, delta * bulletSpeed)
	velocity = inputVelocity
	velocity = velocity.normalized() * bulletSpeed
	move_and_slide()
