extends KinematicBody
class_name FpsController

onready var camera := $Camera as FpsCamera

export(float) var Sensitivity_X := 0.01
export(float) var Sensitivity_Y := 0.005
export(bool) var Invert_Y_Axis := false
export(bool) var Exit_On_Escape := true
export(float) var Maximum_Y_Look := 45
export(float) var Walk_Accelaration := 3.0
export(float) var Maximum_Walk_Speed := 5.0
export(float) var Sprint_Accelaration := 6.0
export(float) var Maximum_Sprint_Speed := 10.0
export(float) var Jump_Speed := 4.0
export(float) var Gravity := 9.8
export(bool) var CameraIsCurrentOnStart: bool = true

export(NodePath) var HeldObjectPath: NodePath
var heldObject: Spatial setget held_object_set, held_object_get
func held_object_set(value: Spatial):
	heldObject = value
	self.camera.heldObject = self.heldObject
func held_object_get() -> Spatial:
	return heldObject

var mouseCaptured: bool setget mouse_captured_set, mouse_captured_get
func mouse_captured_set(value: bool):
	mouseCaptured = value
	if mouseCaptured:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
func mouse_captured_get() -> bool:
	return mouseCaptured

var velocity := Vector3(0,0,0)
var forward_velocity := 0.0
var Movement_Speed := 0.0

func _ready():
	self.mouseCaptured = true
	self.heldObject = get_node_or_null(HeldObjectPath)
	self.camera.current = CameraIsCurrentOnStart
	forward_velocity = Movement_Speed

func _process(delta):
	if Exit_On_Escape:
		if Input.is_key_pressed(KEY_ESCAPE):
			get_tree().quit()
	else:
		if Input.is_key_pressed(KEY_ESCAPE):
			self.mouseCaptured = false

func _physics_process(delta):
	velocity.x = 0
	velocity.z = 0
	velocity.y -= Gravity * delta
	
	var Accelaration: float
	var Maximum_Speed: float
	if Input.is_key_pressed(KEY_SHIFT):
		Accelaration = Sprint_Accelaration
		Maximum_Speed = Maximum_Sprint_Speed
	else:
		Accelaration = Walk_Accelaration
		Maximum_Speed = Maximum_Walk_Speed
	
	if Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_UP):
		Movement_Speed += Accelaration
		if Movement_Speed > Maximum_Speed:
			Movement_Speed = Maximum_Speed
		velocity.x += -global_transform.basis.z.x * Movement_Speed
		velocity.z += -global_transform.basis.z.z * Movement_Speed
	elif Input.is_key_pressed(KEY_S) or Input.is_key_pressed(KEY_DOWN):
		Movement_Speed += Accelaration
		if Movement_Speed > Maximum_Speed:
			Movement_Speed = Maximum_Speed
		velocity.x += global_transform.basis.z.x * Movement_Speed
		velocity.z += global_transform.basis.z.z * Movement_Speed
	
	if Input.is_key_pressed(KEY_LEFT) or Input.is_key_pressed(KEY_A):
		Movement_Speed += Accelaration
		if Movement_Speed > Maximum_Speed:
			Movement_Speed = Maximum_Speed
		velocity.x += -global_transform.basis.x.x * Movement_Speed
		velocity.z += -global_transform.basis.x.z * Movement_Speed
	elif Input.is_key_pressed(KEY_RIGHT) or Input.is_key_pressed(KEY_D):
		Movement_Speed += Accelaration
		if Movement_Speed > Maximum_Speed:
			Movement_Speed = Maximum_Speed
		velocity.x += global_transform.basis.x.x * Movement_Speed
		velocity.z += global_transform.basis.x.z * Movement_Speed
		
	if not(Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_S) or Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_UP) or Input.is_key_pressed(KEY_DOWN) or Input.is_key_pressed(KEY_LEFT) or Input.is_key_pressed(KEY_RIGHT)):
		velocity.x = 0
		velocity.z = 0
		
	if is_on_floor():
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = Jump_Speed
	velocity = move_and_slide(velocity, Vector3(0,1,0))

func _input(event):
	# Don't process input if we aren't capturing the mouse
	if not self.mouseCaptured:
		return
	
	if event is InputEventMouseMotion:
		rotate_y(-Sensitivity_X * event.relative.x)

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_FOCUS_IN:
		self.mouseCaptured = true
	elif what == MainLoop.NOTIFICATION_WM_FOCUS_OUT:
		self.mouseCaptured = false