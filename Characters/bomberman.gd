extends CharacterBody2D

@onready var bomberman: CharacterBody2D = $"."
@onready var anim: AnimationPlayer = $anim
@onready var bomb_marker: Marker2D = $bomb_marker


const BOMB_SCENE = preload('res://prefabs/bomb.tscn')


const SPEED = 80.0


var can_plant_bomb: bool = true #Define se pode plantar a bomba


func _physics_process(delta: float) -> void:
	
	plant_bomb()
	set_animation()
	move_player()
	move_and_slide()


func move_player():
	var direction_x := Input.get_axis("A", "D")
	if direction_x:
		velocity.x = direction_x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	var direction_y := Input.get_axis("W", "S")
	if direction_y:
		velocity.y = direction_y * SPEED
	else:
		velocity.y = move_toward(velocity.x, 0, SPEED)


func set_animation():
	
	if velocity.x > 0:
		anim.play('walk_right')
	elif velocity.x < 0:
		anim.play('walk_left')
	elif velocity.y > 0:
		anim.play('walk_bottom')
	elif velocity.y < 0:
		anim.play('walk_top')
	elif velocity.x == 0 and velocity.y == 0:
		anim.play('RESET')


func plant_bomb():
	if Input.is_action_just_pressed('bomb') and can_plant_bomb == true:
		can_plant_bomb = false
		
		var new_bomb = BOMB_SCENE.instantiate()
		new_bomb.global_position = bomb_marker.global_position
		get_parent().add_child(new_bomb)
		
		
		
		
		
