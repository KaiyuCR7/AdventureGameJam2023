extends RigidBody2D

@export var bulletSpeed = 500
var inputVelocity = Vector2.ZERO

func setBulletSpeed(speed):
	self.bulletSpeed = speed

func setDvelocity(bulletVel):
	print(bulletVel)
	self.inputVelocity = bulletVel

func _ready():
	self.apply_impulse(Vector2(bulletSpeed, 0).rotated(rotation), Vector2())

func _process(delta):
#	velocity.x = move_toward(0,inputVelocity.x * bulletSpeed, delta * bulletSpeed)
#	velocity.y = move_toward(0,inputVelocity.y * bulletSpeed, delta * bulletSpeed)
#	velocity = inputVelocity
#	move_and_collide(velocity.normalized() * delta * bulletSpeed)
	pass


func _on_body_entered(body):
	print("entered body")
	queue_free()
