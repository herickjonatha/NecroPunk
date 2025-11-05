extends CharacterBody2D

const SPEED = 200.0
const ATTACK_RANGE = 50.0

enum State { IDLE, RUNNING, ATTACKING }

var target: Node2D = null
var state = State.IDLE

func _ready():
	target = get_tree().current_scene.get_node("Player")
	if target == null:
		push_error("Player não encontrado na cena!")

func _physics_process(delta):
	if target == null:
		state = State.IDLE
		velocity = Vector2.ZERO
		$AnimatedSprite2D.play("idle")
		return

	var direction = (target.position - position)
	var distance = direction.length()
	var horizontal_dir = direction.x


	if distance <= ATTACK_RANGE:
		if state != State.ATTACKING:
			state = State.ATTACKING
			if horizontal_dir != 0:
				$AnimatedSprite2D.flip_h = horizontal_dir < 0
			velocity = Vector2.ZERO
			$AnimatedSprite2D.play("attack")
	else:
		state = State.RUNNING
		if horizontal_dir != 0:
			$AnimatedSprite2D.flip_h = horizontal_dir < 0
		velocity = direction.normalized() * SPEED
		move_and_slide()
		$AnimatedSprite2D.play("run")
