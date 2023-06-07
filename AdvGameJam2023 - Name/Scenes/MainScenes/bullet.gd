extends RigidBody2D

@export var bulletSpeed = 500
@export var life_time = 1

func _ready():
	self.apply_impulse(Vector2(bulletSpeed, 0).rotated(rotation), Vector2())
	nuke()

func nuke():
	await get_tree().create_timer(life_time).timeout
	queue_free()

func _on_body_entered(body):
	print("entered body")
	self.hide()
