extends CharacterBody2D

@onready var animationPlayer = $AnimationPlayer
@onready var damageable = $Damageable

var ACCELERATION = 150
var MAX_SPEED = 100
var deathTimer = 3
var state = IDLE
var direction = Vector2(0,0)

enum {
	IDLE,
	CHASE
}

func _ready():
	state = IDLE
	
	MAX_SPEED = Global.getEnemySpeed()
	
	if Global.getPlayerPositionX() > self.global_position.x:
		$Sprite2D.set_flip_h(false)
		$Marker2D.set_rotation(0)
	elif Global.getPlayerPositionX() < self.global_position.x:
		$Sprite2D.set_flip_h(true)
		$Marker2D.set_rotation(PI)

func dieAnimFinish():
	queue_free()

func _process(delta):
#	if get_node("AttackArea/CollisionShape2D").overlaps_body(playerBody):
#		attack()
		
	match state: 
		IDLE: 
			if Global.getEnemyDead() == false:
				animationPlayer.play("Idle")
		
		CHASE:
			if Global.getPlayerPositionX() > self.global_position.x:
				$Sprite2D.set_flip_h(true)
				$Marker2D.set_rotation(PI)
			elif Global.getPlayerPositionX() < self.global_position.x:
				$Sprite2D.set_flip_h(false)
				$Marker2D.set_rotation(0)
		
			direction.x = (Global.getPlayerPositionX() - self.global_position.x)
			direction.y = (Global.getPlayerPositionY() - self.global_position.y)
			velocity.x = move_toward(direction.x * Global.getEnemySpeed(), 0, ACCELERATION * delta)
			velocity.y = move_toward(direction.y * Global.getEnemySpeed(), 0, ACCELERATION * delta)
			velocity = velocity.normalized() * MAX_SPEED
	
	move_and_slide()

func attack():
	print("In Attack")
	animationPlayer.play("Attack")
	

func _on_area_2d_body_entered(body):
	print("entered")
	state = CHASE

#func _on_attack_area_body_entered(body):
#	print("In Attack Area Detector")
#	for child in body.get_children():
#		if child is playerBody:
#			attack()

func _on_hitbox_body_entered(body):
	print("Hit")
	for child in body.get_children():
		if child is playerBody:
			child.damaged()
			print_debug(body.name + "took" + str(Global.getEnemyDamage()) + ".")
	attack()

func attackAnimFinished():
	state = IDLE
	
	
func takeDamage(damage):
	damageable.hit(damage)


