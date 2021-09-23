extends Control

func _ready():
	var label=get_node("Label")
	label.text = label.text % [PlayerData.score, PlayerData.deaths]
