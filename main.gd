extends Node2D


var initial = 0.999
var zooming = true
var zoomspeed = 0.999
var holding = false
var delay = 0
var end = false
var temp = 0

func _ready():
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseButton:
		#zoomspeed = 0.999
		if Input.is_mouse_button_pressed(1):
			holding = true
			$AudioStreamPlayer.play(temp)
			var tween = create_tween().set_trans(Tween.TRANS_CUBIC)
			tween.tween_property(self, "zoomspeed", 0.995, 3)
		else:
			temp = $AudioStreamPlayer.get_playback_position( )

func end():
	$Timer.start()



func _process(_delta):
	if Input.is_mouse_button_pressed(1): # Left click
		if zooming:
			#lerp(zoomspeed,0.992,0.01)
			$Camera2D.zoom *= zoomspeed
			if $Camera2D.zoom.x < 0.05:
				$ParallaxBackground/ParallaxLayer4/node/ColorRect.color.a += 0.006
				if $ParallaxBackground/ParallaxLayer4/node/ColorRect.color.a >= 1:
					$Camera2D.zoom = Vector2(1,1)
					var tween = create_tween().set_trans(Tween.TRANS_CUBIC)
					tween.tween_property($"ParallaxBackground/ParallaxLayer4/node/Arid-21799480", "modulate", Color(1,1,1,0.04), 4)
					zooming = false
		else:
			delay += 1
			if delay > 300:
				if delay == 301:
					var tween = create_tween().set_trans(Tween.TRANS_CUBIC)
					tween.tween_property($ParallaxBackground/ParallaxLayer4/node/Light, "modulate", Color(1,1,1,1), 5)
				$ParallaxBackground/ParallaxLayer4/node/Light.scale /= zoomspeed
			if $ParallaxBackground/ParallaxLayer4/node/Light.scale.x > 60:
				if end == false:
					end()
					var tween = create_tween().set_trans(Tween.TRANS_CUBIC)
					tween.tween_property($ParallaxBackground/ParallaxLayer4/node/Label, "modulate", Color(0.27,0.3,0.27,1), 5)
					end = true
			
	elif(holding == true and not end):
		#holding = false
		if zooming:
			zoomspeed = lerp(zoomspeed,0.999,0.1)
			
			$Camera2D.zoom *= zoomspeed
			$AudioStreamPlayer.volume_db -= 1

			if zoomspeed > 0.998:
				holding = false
				$AudioStreamPlayer.playing = false
				$AudioStreamPlayer.volume_db = -80
		else:
			$AudioStreamPlayer.volume_db -= 1
			zoomspeed = lerp(zoomspeed,0.999,0.1)
			$ParallaxBackground/ParallaxLayer4/node/Light.scale /= zoomspeed
			if zoomspeed > 0.998:
				$AudioStreamPlayer.playing = false
				$AudioStreamPlayer.volume_db = -80
				holding = false
		


func _on_Timer_timeout():
	$AnimationPlayer.play("New Anim")
	$AudioStreamPlayer.playing = false

func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().reload_current_scene()
