extends Actor

onready var anim_player: AnimationPlayer = get_node("Dog/AnimationPlayer")
onready var dog: Sprite = get_node("Dog")
export var stomp_impulse = 1000.0

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 0.0
	)

func _on_EnemyDetector_body_entered(body):
	die()

func _physics_process(delta: float) -> void:
	var is_jump_interrupted: = Input.is_action_just_released("jump") and velocity.y < 0.0
	var direction: = get_direction()
	velocity = calculate_move_velocity(velocity, direction, speed, is_jump_interrupted)
	if velocity.x !=  0:
		anim_player.play("Run")
	else:
		anim_player.play("Base")
	if velocity.x < 0:
		dog.flip_h = true
	else:
		dog.flip_h = false
		
	velocity = move_and_slide(velocity, FLOOR_NORMAL)



func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
	var out: = linear_velocity
	out.x = speed.x * direction.x
	out.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		out.y = speed.y * direction.y
	if is_jump_interrupted:
		out.y = 0.0
	return out


func _on_EnemyDetector_area_entered(area):
	velocity = calculate_stomp_velocity(velocity, stomp_impulse)

func calculate_stomp_velocity(linear_velocity: Vector2, impulse: float) -> Vector2:
	var out: = linear_velocity
	out.y = -impulse
	return out

func die():
	queue_free()
	PlayerData.deaths +=1
	#get_tree().change_scene("res://src/actors/EndScreen.tscn")


