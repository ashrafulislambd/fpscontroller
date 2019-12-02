extends KinematicBody
class_name FpsController

export var Sensitivity_X = 0.01
export var Sensitivity_Y = 0.005
export var Invert_Y_Axis = false
export var Exit_On_Escape = true
export var Maximum_Y_Look = 45
export var Walk_Accelaration = 5
export var Maximum_Walk_Speed = 10
export var Sprint_Accelaration = 10
export var Maximum_Sprint_Speed = 20
export var Jump_Speed = 3

const GRAVITY = 0.098
var velocity = Vector3(0,0,0)
var forward_velocity = 0
var Movement_Speed = 0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	forward_velocity = Movement_Speed
	set_process(true)

func _process(delta):
	if Exit_On_Escape:
		if Input.is_key_pressed(KEY_ESCAPE):
			get_tree().quit()

func _physics_process(delta):
	velocity.y -= GRAVITY
	
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
		velocity.x = -global_transform.basis.z.x * Movement_Speed
		velocity.z = -global_transform.basis.z.z * Movement_Speed
	if Input.is_key_pressed(KEY_S) or Input.is_key_pressed(KEY_DOWN):
		Movement_Speed += Accelaration
		if Movement_Speed > Maximum_Speed:
			Movement_Speed = Maximum_Speed
		velocity.x = global_transform.basis.z.x * Movement_Speed
		velocity.z = global_transform.basis.z.z * Movement_Speed
	if Input.is_key_pressed(KEY_LEFT) or Input.is_key_pressed(KEY_A):
		Movement_Speed += Accelaration
		if Movement_Speed > Maximum_Speed:
			Movement_Speed = Maximum_Speed
		velocity.x = -global_transform.basis.x.x * Movement_Speed
		velocity.z = -global_transform.basis.x.z * Movement_Speed
		
	if Input.is_key_pressed(KEY_RIGHT) or Input.is_key_pressed(KEY_D):
		Movement_Speed += Accelaration
		if Movement_Speed > Maximum_Speed:
			Movement_Speed = Maximum_Speed
		velocity.x = global_transform.basis.x.x * Movement_Speed
		velocity.z = global_transform.basis.x.z * Movement_Speed
		
	if not(Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_S) or Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_UP) or Input.is_key_pressed(KEY_DOWN) or Input.is_key_pressed(KEY_LEFT) or Input.is_key_pressed(KEY_RIGHT)):
		velocity.x = 0
		velocity.z = 0
		
	if is_on_floor():
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = Jump_Speed
	velocity = move_and_slide(velocity, Vector3(0,1,0))

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(-Sensitivity_X * event.relative.x)
