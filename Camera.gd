extends Camera

var sensitivity_y = 0
var inversion_mult = 1
var max_y = 89

func initializeComponents():
	sensitivity_y = self.get_parent().Sensitivity_Y
	max_y = self.get_parent().Maximum_Y_Look
	if self.get_parent().Invert_Y_Axis:
		inversion_mult = 1
	else:
		inversion_mult = -1

func _ready():
	self.initializeComponents()
	
	pass
	
func _input(event):
	if event is InputEventMouseMotion:
		if inversion_mult * sensitivity_y * event.relative.y >= 0 and self.rotation_degrees.x >= max_y:
			return
		if inversion_mult * sensitivity_y * event.relative.y <= 0  and self.rotation_degrees.x <= -max_y:
			return
		rotate_x(inversion_mult * sensitivity_y * event.relative.y)