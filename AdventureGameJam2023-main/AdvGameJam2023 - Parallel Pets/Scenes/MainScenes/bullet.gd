extends RigidBody2D

@export var bulletSpeed = 500
@export var life_time = 1
@export var damage = 1
@onready var animationPlayer = $AnimationPlayer

var destroyTime = false

func _ready():
	self.apply_impulse(Vector2(bulletSpeed, 0).rotated(rotation), Vector2())
	nuke()

func nuke():
	await get_tree().create_timer(life_time).timeout
	destroyTime = true
	animationPlayer.stop()
	animationPlayer.play("blueBulletHit")

func _on_body_entered(body):
	print("entered body")
	animationPlayer.stop()
	animationPlayer.play("blueBulletHit")
	self.hide()
	
	for child in body.get_children():
		if child is Damageable: 
			child.hit(damage)
			print_debug(body.name + "took" + str(damage) + ".")

func shotHitEnd():
	if destroyTime:
		queue_free()
	else:
		self.hide()

func shotEnded():
	animationPlayer.play("bulletTravel")
