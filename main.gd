extends Control

@export var save_name = "user://save.dat"

var score: int = 0

@onready var label: Label = $Label

func _ready() -> void:
	load_score()

func update_label() -> void:
	label.text = str(score)

func save_score() -> void:
	var save_file = FileAccess.open(save_name, FileAccess.WRITE)
	if FileAccess.get_open_error() != OK:
		printerr("Failed to open file: " + save_name)
		return
	save_file.store_64(score)

func load_score() -> void:
	if not FileAccess.file_exists(save_name):
		return
	
	var save_file = FileAccess.open(save_name, FileAccess.READ)
	if FileAccess.get_open_error() == OK and save_file.get_length() >= 8:
		score = save_file.get_64()
	else:
		score = 0
	
	update_label()

func _on_add_pressed() -> void:
	score += 1
	save_score()
	update_label()


func _on_reset_pressed() -> void:
	score = 0
	save_score()
	update_label()
