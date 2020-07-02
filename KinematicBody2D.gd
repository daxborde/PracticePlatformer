extends KinematicBody2D

const GRAVITY = 30
const SPEED = 200
const JUMPFORCE = 600
const TERMINAL_VELOCITY = 500

var motion = Vector2()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	flip_anim()
	motion = move_and_slide(handle_jump(handle_gravity(handle_movement(motion))))
	pass
	
func flip_anim():
	var isleft = Input.is_action_pressed("ui_left")
	var isright = Input.is_action_pressed("ui_right")
	if isright and not isleft:
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("run")
	elif isleft and not isright:
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("run")
	else:
		$AnimatedSprite.play("idle")

# Handle jump input
func handle_jump(motion):
	var shouldJump = Input.is_action_just_pressed("ui_up")
	if shouldJump:
		motion.y = -JUMPFORCE
	return motion

func handle_gravity(motion):
	motion.y = min(motion.y + GRAVITY, TERMINAL_VELOCITY)
	#print_debug(motion.y)
	return motion

# Handle left and right movement input
func handle_movement(motion):
	var isleft = Input.is_action_pressed("ui_left")
	var isright = Input.is_action_pressed("ui_right")
	if isright and not isleft:
		motion.x = SPEED
	elif isleft and not isright:
		motion.x = -SPEED
	else:
		motion.x = 0
	return motion
