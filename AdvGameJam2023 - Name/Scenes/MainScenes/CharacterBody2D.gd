extends CharacterBody2D


const MAX_SPEED = 200
const ACCELERATION = 100 
const FRICTION = 80
#const FACTOR = 10

var lookDirection = 1

enum {
	MOVE,
	ATTACK
}
var state = MOVE

@onready var animationPlayer = $AnimationPlayer 

func _process(delta):
	match state:
		MOVE:
			moveState(delta)
	
		ATTACK:
			pass

func moveState(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("MoveRight") - Input.get_action_strength("MoveLeft")
	input_vector.y = Input.get_action_strength("MoveDown") - Input.get_action_strength("MoveUp")
	
	if input_vector != Vector2.ZERO:
		if input_vector.x < 0:
			animationPlayer.play("RunRight")
			lookDirection = 1
		elif input_vector.x > 0:
			animationPlayer.play("RunLeft")
			lookDirection = 2
		if input_vector.x == 0 && lookDirection == 1:
			animationPlayer.play("RunRight")
		elif input_vector.x == 0 && lookDirection == 2:
			animationPlayer.play("RunLeft")
		velocity.x = move_toward(0, input_vector.x * MAX_SPEED, ACCELERATION * delta)
		velocity.y = move_toward(0, input_vector.y * MAX_SPEED, ACCELERATION * delta)
	elif input_vector == Vector2.ZERO:
		if input_vector.x < 0:
			animationPlayer.play("IdleRight")
			lookDirection = 1
		elif input_vector.x > 0: 
			animationPlayer.play("IdleLeft")
			lookDirection = 2
		velocity.x = move_toward(input_vector.x * MAX_SPEED, 0, FRICTION * delta)
		velocity.y = move_toward(input_vector.y * MAX_SPEED, 0 , FRICTION * delta)
	#normalize velocity
	velocity = velocity.normalized() * MAX_SPEED
	
	move_and_slide()
