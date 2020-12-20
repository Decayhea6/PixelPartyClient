extends Node2D

export var mode = ""
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
#	print("Hi")
	if not vars.loaded:
		vars.loaded = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Host_pressed():
	get_tree().change_scene("res://Menus/LobbyFinder.tscn")

func _on_Setup_pressed():
	get_tree().change_scene("res://Menus/Settings.tscn")


func _on_Exit_pressed():
	get_tree().quit()
