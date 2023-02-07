extends Control
 
onready var spectrum = AudioServer.get_bus_effect_instance(0,0)
 
onready var bottomRightArray = $CircleBase/Right/Bottom.get_children()
 
 
const VU_COUNT = 6
const HEIGHT = 1
const FREQ_MAX = 11050.0
 
const MIN_DB = 100
const init_size =Vector2(0.377,0.401)
var targetVec
 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
 
 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
 
	var prev_hz = 0
#	for i in range(1,VU_COUNT+1):   
	var hz = FREQ_MAX / VU_COUNT;
	var f = spectrum.get_magnitude_for_frequency_range(prev_hz,hz)
	var energy = clamp((MIN_DB + linear2db(f.length()))/MIN_DB,0,1)
	var height = energy * HEIGHT	
	var targetVec = Vector2(0.377,0.401) * (1+(height/10))
	#print(height/60)
	$"../ParallaxBackground/ParallaxLayer/node/SunflowerSeedsKaldari-removebg-preview".scale = lerp($"../ParallaxBackground/ParallaxLayer/node/SunflowerSeedsKaldari-removebg-preview".scale,targetVec,0.1)
#		prev_hz = hz
#
#		var bottomRightRect = bottomRightArray[i - 1]
#
#		var tween = get_tree().create_tween()
#
#		tween.tween_property(bottomRightRect, "rect_size", Vector2(bottomRightRect.rect_size.x, height), 0.1)
#
