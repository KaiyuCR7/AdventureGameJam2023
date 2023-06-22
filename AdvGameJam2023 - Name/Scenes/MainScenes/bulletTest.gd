extends CharacterBody2D

@export var bulletSpeed = 300
@export var life_time = 2
@onready var animationPlayer = $AnimationPlayer
@export var damage = 1 

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
	var hitObject = collision.get_collider()
	var isEnemy = false
	
	for child in hitObject.get_children():
		if child is Damageable: 
			child.hit(damage)
			print("Enemy took " + str(damage) + " Damage")
			isEnemy = true
	if !isEnemy:
		if Global.canBounce:
			var bounceAngleVector = currentVector.bounce(collision.get_normal())
			var bounceVector = speedVector.rotated(bounceAngleVector.angle())
			currentVector = bounceVector
			rotateTime = true
		else:
			animationPlayer.stop()
			animationPlayer.play("blueBulletHit")
	else:
		animationPlayer.stop()
		animationPlayer.play("blueBulletHit")
		

#	if collision.get_collider(): 
#			child.hit(damage)
#			print_debug(body.name + "took" + str(damage) + ".")
			
	oneTimeCall = false
		
	
func shotHitEnd():
	if destroyTime:
		queue_free()
	else:
		self.hide()

func shotEnded():
	animationPlayer.play("bulletTravel")


