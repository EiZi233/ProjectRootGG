extends ParallaxBackground

var viewport_size
var relative_x
var relative_y

func _ready():
	get_tree().get_root().connect("size_changed", self, "viewport_changed") # register event if viewport changes
	viewport_changed()
	relative_x = 0
	relative_y = 0

func _input(event):
	if event is InputEventMouseMotion:
		var mouse_x = event.position.x
		var mouse_y = event.position.y
		relative_x = -1 * (mouse_x - (viewport_size.x/2)) / (viewport_size.x/2)
		relative_y = -1 * (mouse_y - (viewport_size.y/2)) / (viewport_size.y/2)
		# print("relative_y: " + str(relative_y))
		# print("relative_x: " + str(relative_x))
		var count = 3
		for child in self.get_children(): # for each parallaxlayer do...
			if count > 50:
				count = 10
			child.motion_offset.x = count * relative_x
			child.motion_offset.y = count * relative_y
			count = count * 3


# gets called on the start of the application once and every time the viewport changes
# centers the images
func viewport_changed():
	viewport_size = get_viewport().size
#	for child in self.get_children():
#		child.get_node("node").offset.x = viewport_size.x / 2
#		child.get_node("node").offset.y = viewport_size.y / 2
