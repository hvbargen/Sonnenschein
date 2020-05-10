extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const UP_DIRECTION = Vector2(0,-1)

signal score_changed(score)

export var MAX_GROUND_SPEED : float = 100.0
export var ACCEL : float = 100.0
export var GROUND_FRICTION : float = 0.93
export var GRAVITY : float = 800.0
export var jump_power : float = 500.0

export var score = 0 setget set_score

var flipped = false

var velocity = Vector2(0,0)

onready var screen_size = get_viewport_rect().size

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	var sprite = $AnimatedSprite as AnimatedSprite
	
	var on_floor : bool = is_on_floor()
	if on_floor:
		velocity.y = 0
		# Abbremsen durch Reibung
		if abs(velocity.x) > 1:
			velocity.x *= 0.9 * delta
		else:
			velocity.x = 0
	else:
		# Schwerkraft
		velocity.y += GRAVITY * delta	
	
	if Input.is_action_pressed("ui_right"):
		# print("right ", sprite.animation)
		if not flipped:
			sprite.flip_h = true
			flipped = true
		if sprite.animation != "run":
			sprite.play("run")
		velocity.x = max(MAX_GROUND_SPEED, velocity.x + ACCEL * delta)
	elif Input.is_action_pressed("ui_left"):
		# print("left ", sprite.animation)
		if  flipped:
			sprite.flip_h = false
			flipped = false
		if sprite.animation != "run":
			sprite.play("run")
		velocity.x = min(-MAX_GROUND_SPEED, velocity.x - ACCEL * delta)
	if Input.is_action_pressed("ui_up"):
		if on_floor:
			# print("jump ", sprite.animation)
			velocity.y = -jump_power
			sprite.play("jump")
		else:
			pass #print("not on floor")
	velocity = move_and_slide(velocity, UP_DIRECTION)
	#print(velocity)
	for _ in range(get_slide_count()):
		pass 
		# var coll_obj = get_slide_collision(i)
		# print(coll_obj)
	on_floor = is_on_floor()
	if on_floor:
		if velocity.length_squared() < 1:
			sprite.play("idle")
	else:
		if velocity.y > 5:
			sprite.play("fall")
			
	if position.x < -16:
		position.x = screen_size.x + 16
	elif position.x > screen_size.x + 16:
		position.x = -16

	#print("delta:", delta, " velocity: ", velocity)		

func set_score(new_score):
	score = new_score
	print("new score: ", score)
	emit_signal("score_changed", score)

