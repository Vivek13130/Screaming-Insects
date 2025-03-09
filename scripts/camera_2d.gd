extends Camera2D

# Responsibility: 
# Control zoom in and out with limits
# Panning via W, A, S, D
# Click and drag

# Zooming:
var zoomTarget: Vector2
@export var zoomSpeed: float = 5

# Panning:
@export var panSpeed: int = 2

# Click and drag:
var dragStartMousePos: Vector2
var dragStartCameraPos: Vector2
var isDragging: bool = false

# Position reset:
var positionTarget: Vector2 = Vector2.ZERO

func _ready() -> void:
	zoomTarget = zoom

func _process(delta: float) -> void:
	simple_zoom(delta)
	click_and_drag(delta)

	# Smoothly move the camera to the target position
	position = position.lerp(positionTarget, zoomSpeed  * delta)

	# Handle camera reset
	if Input.is_action_just_pressed("reset_camera"):
		zoomTarget = Vector2.ONE
		positionTarget = Vector2.ZERO
		isDragging = false  # Stop dragging when reset is triggered

func simple_zoom(delta: float) -> void:
	# Handle zooming
	if Input.is_action_just_pressed("camera_zoom_in"):
		zoomTarget *= 1.1
	if Input.is_action_just_pressed("camera_zoom_out"):
		zoomTarget *= 0.9

	zoom = zoom.slerp(zoomTarget, zoomSpeed * delta)

func click_and_drag(_delta: float) -> void:
	if not isDragging and Input.is_action_just_pressed("camera_dragging"):
		dragStartCameraPos = position
		dragStartMousePos = get_viewport().get_mouse_position()
		isDragging = true

	if isDragging:
		var moveVector: Vector2 = get_viewport().get_mouse_position() - dragStartMousePos
		positionTarget = dragStartCameraPos - moveVector * (1 / zoom.x)
	
	if isDragging and Input.is_action_just_released("camera_dragging"):
		isDragging = false
