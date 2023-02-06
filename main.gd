extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(_delta):
	if Input.is_mouse_button_pressed(1): # Left click
		$Camera2D.zoom*=0.992
		if $Camera2D.zoom.x < 0.05:
			$ColorRect.color.a += 0.01
