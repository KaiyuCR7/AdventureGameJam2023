extends RigidBody2D

@export var bulletSpeed = 300
@export var life_time = 2
@onready var animationPlayer = $AnimationPlayer 

var destroyTime = false

func _ready():
	self.apply_impulse(Vector2(bulletSpeed, 0).rotated(rotation), Vector2())
	animationPlayer.play("shotBullet")
	nuke()

func nuke():
	await get_tree().create_timer(life_time).timeout
	destroyTime = true
	animationPlayer.stop()
	animationPlayer.play("blueBulletHit")

func _on_body_entered(body):
	animationPlayer.stop()
	animationPlayer.play("blueBulletHit")
	
func shotHitEnd():
	if destroyTime:
		queue_free()
	else:
		self.hide()

func shotEnded():
	animationPlayer.play("bulletTravel")
