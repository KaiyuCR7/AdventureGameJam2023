extends RigidBody2D


@export var bulletSpeed = 300
@export var life_time = 2
@onready var animationPlayer = $AnimationPlayer 
@export var damage = 1

var destroyTime = false
var rotateTime = false
var speedVector = Vector2()
var currentVector = Vector2()

func _ready():
	speedVector = Vector2(bulletSpeed, 0)
	currentVector = speedVector.rotated(rotation)
	self.apply_impulse(currentVector, Vector2())
	animationPlayer.play("shotBullet")
	nuke()

func nuke():
	await get_tree().create_timer(life_time).timeout
	destroyTime = true
	animationPlayer.stop()
	animationPlayer.play("blueBulletHit")
	
func bounceTime():
	await get_tree().create_timer(0.5).timeout
	rotateTime = true

func _on_body_entered(body):
	print("bulletHitSomeething")
	var bulletCanBounce = Global.canBounce
	if bulletCanBounce:
		var bounceCount = Global.bounceAmount
		var bounceAngleVector = currentVector.bounce(Vector2(1,0))
		var bounceVector = speedVector.rotated(bounceAngleVector.angle())
		self.apply_impulse(bounceVector, Vector2())
		currentVector = bounceVector
		bounceTime()
	else:
		animationPlayer.stop()
		animationPlayer.play("blueBulletHit")
	
	for child in body.get_children():
		if child is Damageable: 
			child.hit(damage)
			print_debug(body.name + "took" + str(damage) + ".")
	

func _process(delta):
	if rotateTime:
		self.rotation = currentVector.angle()
		rotateTime = false

func shotHitEnd():
	if destroyTime:
		queue_free()
	else:
		self.hide()

func shotEnded():
	animationPlayer.play("bulletTravel")


