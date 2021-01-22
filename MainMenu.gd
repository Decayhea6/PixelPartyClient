extends Node2D

export var mode = ""

func _ready():
#	print("Hi")
	if not vars.loaded:
		vars.loaded = true


func _on_Host_pressed():
	get_tree().change_scene("res://Menus/LobbyFinder.tscn")

func _on_Setup_pressed():
	get_tree().change_scene("res://Menus/Settings.tscn")


func _on_Exit_pressed():
	get_tree().quit()
