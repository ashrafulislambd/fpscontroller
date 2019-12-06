extends Camera
class_name FpsCamera

onready var fpsController: Spatial = get_parent()

var sensitivity_y := 0.0
var inversion_mult := 1.0
var max_y := 89.0

var heldObject: Spatial

func initializeComponents():
	sensitivity_y = self.get_parent().Sensitivity_Y
	max_y = self.get_parent().Maximum_Y_Look
	if self.get_parent().Invert_Y_Axis:
		inversion_mult = 1
	else:
		inversion_mult = -1

func _ready():
	self.initializeComponents()

func _input(event):
	# Don't process input if we aren't capturing the mouse
	if not fpsController.mouseCaptured:
		return
	
	if event is InputEventMouseMotion:
		var rotateBy = inversion_mult * sensitivity_y * event.relative.y
		
		if rotateBy >= 0 and self.rotation_degrees.x >= max_y:
			return
		if rotateBy <= 0  and self.rotation_degrees.x <= -max_y:
			return
		
		rotate_x(rotateBy)
		
		if heldObject != null:
			heldObject.rotate_x(rotateBy)