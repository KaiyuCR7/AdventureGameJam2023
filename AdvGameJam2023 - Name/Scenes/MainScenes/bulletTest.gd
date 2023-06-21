extends CharacterBody2D

@export var bulletSpeed = 300
@export var life_time = 2
@onready var animationPlayer = $AnimationPlayer 

var destroyTime = false
var rotateTime = false
var speedVector = Vector2()
var currentVector = Vector2()
var oneTimeCall = true

func _ready():
	speedVector = Vector2(bulletSpeed, 0)
	currentVector = speedVector.rotated(rotation)
	animationPlayer.play("shotBullet")
	nuke()

func nuke():
	await get_tree().create_timer(life_time).timeout
	destroyTime = true
	animationPlayer.stop()
	animationPlayer.play("blueBulletHit")


#func _on_body_entered(body):
#	var bulletCanBounce = Global.canBounce
#	if bulletCanBounce:
#		var bounceCount = Global.bounceAmount
#		var bounceAngleVector = currentVector.bounce(Vector2(1,0))
#		var bounceVector = speedVector.rotated(bounceAngleVector.angle())
#		currentVector = bounceVector
#	else:
#		animationPlayer.stop()
#		animationPlayer.play("blueBulletHit")
	

func _process(delta):
	var collision = move_and_collide(currentVector)
	if collision && oneTimeCall:
		collisionHandler(collision)
	if rotateTime && !collision:
		rotateBullet()
	if !collision:
		oneTimeCall = true
		

func rotateBullet():
	self.rotation = currentVector.angle()
	rotateTime = false
	

func collisionHandler(collision : KinematicCollision2D):
	if Global.canBounce:
		var bounceAngleVector = currentVector.bounce(collision.get_normal())
		var bounceVector = speedVector.rotated(bounceAngleVector.angle())
		currentVector = bounceVector
		rotateTime = true
	else:
		animationPlayer.stop()
		animationPlayer.play("blueBulletHit")
	oneTimeCall = false
		
	
func shotHitEnd():
	if destroyTime:
		queue_free()
	else:
		self.hide()

func shotEnded():
	animationPlayer.play("bulletTravel")


