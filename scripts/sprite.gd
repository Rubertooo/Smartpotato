extends CharacterBody2D
@onready var area_2d: Area2D = $"../StaticBody2D/Area2D"
@onready var animate: AnimatedSprite2D = $AnimatedSprite2D


const SPEED = 5.0
const JUMP_VELOCITY = -400.0
var first_position
var last_position
var animation


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Handle jump.
	if Input.is_action_just_pressed("Left click") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_pressed("Left click"):
		first_position = get_local_mouse_position()
	if Input.is_action_just_released("Left click"):
		last_position = get_local_mouse_position()
		var both = first_position - last_position
		print(both)
		velocity = both * SPEED

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	get_tree().reload_current_scene()


func _on_knife_area_body_entered(body: Node2D) -> void:
	print("aaaaa")
	animate.play("Peeled1")
	
