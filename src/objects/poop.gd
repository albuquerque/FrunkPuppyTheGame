extends Actor

var direction = 0
var side =[-1,1]

func start(pos):
#	print(pos)
	position=pos
#	velocity.y=
	direction = side[randi() % 2]
	gravity=400
	var angle=rand_range(-60, -30) 
	speed = Vector2(400,100).rotated(angle)


func _physics_process(delta):
	velocity = calculate_move_velocity(
		velocity,
		speed
	)
	move_and_slide(velocity, FLOOR_NORMAL)
	if is_on_floor():
		queue_free()

func calculate_move_velocity(
		linear_velocity: Vector2,
		speed: Vector2
	) -> Vector2:
	var out: = linear_velocity
	out.x = speed.x * direction
	out.y += gravity * get_physics_process_delta_time()
	return out
	
