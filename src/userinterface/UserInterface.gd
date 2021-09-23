extends Control

onready var scene_tree:=get_tree()
onready var pause_overlay:=get_node("PauseOverlay")
onready var score: Label = get_node("Label")
onready var paused_title: Label = get_node("PauseOverlay/Title")

var level_start_score = 0
var paused: = false setget set_paused

func _ready():
	PlayerData.connect("score_updated", self, "update_interface")
	PlayerData.connect("player_died", self, "_PlayerData_player_died")
	level_start_score = PlayerData.score
	update_interface()
	

func update_interface()->void:
	score.text = "Score: %s" % PlayerData.score

func _PlayerData_player_died()->void:
	self.paused = true
	paused_title.text = "You died"

func _unhandled_input(event: InputEvent)->void:
	if event.is_action_pressed("pause") and paused_title.text != "You died":
		self.paused = not paused
		scene_tree.set_input_as_handled()

func set_paused(value: bool) -> void:
	paused = value
	scene_tree.paused = value
	pause_overlay.visible = value
