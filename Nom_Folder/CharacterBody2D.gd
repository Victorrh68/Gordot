extends CharacterBody2D


const SPEED = 8000.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 0 #ProjectSettings.get_setting("physics/2d/default_gravity")
var cell_size = Vector2(1, 1)

func rect_to_iso(cartesian):
	var screen_pos = Vector2()
	#screen_pos.x = cartesian.x - cartesian.y
	#screen_pos.y = (cartesian.x + cartesian.y)/2
	screen_pos.x = int(round(cartesian.x) - round(cartesian.y) )
	screen_pos.y = int(round((round(cartesian.x) + round(cartesian.y))/2))

	return screen_pos

func is_valid_position(pos):
# Check if the next position aligns with the grid
	return (int(pos.x) % int(cell_size.x) == 0) and (int(pos.y) % int(cell_size.y) == 0)

func round_to_grid(pos):
	# Round position to the nearest grid cell
	var x = int(round(pos.x / cell_size.x)) * cell_size.x
	var y = int(round(pos.y / cell_size.y)) * cell_size.y
	return Vector2(x, y)

func _physics_process(delta):
	# Add the gravity.
	#if not is_on_floor():
	#	velocity.y += gravity * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction_x = Input.get_axis("ui_left", "ui_right")
	#var direction_y = Input.get_axis("ui_up", "ui_down")
	
	#if direction_x:
	#	velocity.x = direction_x * SPEED
	#else:
	#	velocity.x = move_toward(velocity.x, 0, SPEED)
		
	#if direction_y:
	#	velocity.y = direction_y * SPEED
	#else:
	#	velocity.y = move_toward(velocity.y, 0, SPEED)
		
	#velocity = rect_to_iso(velocity)
	#velocity = velocity.normalized() * SPEED  * delta
	
	#velocity *= cell_size
	
		# Handle input to move the character
	var movement = Vector2()  # Initialize movement vector
	if Input.is_action_pressed("ui_right"):
		movement.x += 1
	if Input.is_action_pressed("ui_left"):
		movement.x -= 1
	if Input.is_action_pressed("ui_down"):
		movement.y += 1
	if Input.is_action_pressed("ui_up"):
		movement.y -= 1
		
# Normalize movement to ensure consistent speed in all directions
	movement = movement.normalized()
# Multiply by cell size to move in integer increments
	movement *= cell_size

	movement = rect_to_iso(movement) 
# Calculate next position based on the grid
	var next_position = position + movement
# Round next position to ensure it aligns with the grid
	next_position = round_to_grid(next_position)
	#next_position = rect_to_iso(next_position)
# Move only if the next position aligns with the grid
	if is_valid_position(next_position):
		position = next_position
	
	move_and_slide()
