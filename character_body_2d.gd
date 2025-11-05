extends CharacterBody2D

const SPEED = 300.0
var speed_threshold = 10  

func _physics_process(delta: float) -> void:

	var direction_x := Input.get_axis("ui_left", "ui_right")
	var direction_y := Input.get_axis("ui_up", "ui_down")
	var direction := Vector2(direction_x, direction_y).normalized()


	velocity = direction * SPEED
	move_and_slide()


	if direction_x < 0:
		$AnimatedSprite2D.flip_h = true
	elif direction_x > 0:
		$AnimatedSprite2D.flip_h = false


	if velocity.length() > speed_threshold:
		$AnimatedSprite2D.play("run")  # correndo
	else:
		$AnimatedSprite2D.play("idle")  # parado
