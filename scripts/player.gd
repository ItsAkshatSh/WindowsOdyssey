extends CharacterBody2D

const WALK_SPEED = 550.0
const RUN_SPEED = 750.0
const JUMP_VELOCITY = -800.0

@onready var sprite = $AnimatedSprite2D  # Ensure this matches your scene structure

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jumping
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		sprite.play("jump")  # Play the jump animation

	# Determine movement input
	var direction = Input.get_axis("left", "right")
	var is_running = Input.is_action_pressed("run")  # Check if Shift is pressed

	# Set movement speed
	var speed = RUN_SPEED if is_running else WALK_SPEED

	if direction != 0:
		# Move and flip sprite based on direction
		velocity.x = direction * speed
		sprite.flip_h = direction < 0

		# Play appropriate movement animation
		if is_on_floor():
			sprite.play("run" if is_running else "walk")
	else:
		# Stop movement and play idle animation
		velocity.x = move_toward(velocity.x, 0, WALK_SPEED)
		if is_on_floor():
			sprite.play("idle")

	# Play jump animation if in the air
	if not is_on_floor():
		sprite.play("jump")

	move_and_slide()
