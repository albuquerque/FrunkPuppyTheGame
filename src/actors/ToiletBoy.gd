extends Actor

onready var anim_player: AnimationPlayer = get_node("ToiletBoy/AnimationPlayer")
var score = 10
onready var poop = preload("res://src/objects/poop.tscn")
onready var tick  = 0
func _ready():
	set_physics_process(false)

func _physics_process(delta:float)->void:
	
	tick+=1
	if not tick % 60:
		var p=poop.instance()
		p.start($Spiegel.global_position)
		get_parent().add_child(p)

func _on_StompDetector_body_entered(body: PhysicsBody2D) -> void:
	if body.global_position.y > get_node("StompDetector").global_position.y:
		return
	get_node("CollisionShape2D").disabled = true
	die()

func die():
	queue_free()
	PlayerData.score +=score
		
