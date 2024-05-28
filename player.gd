extends CharacterBody3D


const SPEED = 5.0
var health = 30
var health_regen = 2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var _nav_agent := $NavigationAgent3D as NavigationAgent3D

func _ready():
	set_animation_loops()
	$Knight/AnimationPlayer.play("Idle")


func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

	if _nav_agent.is_navigation_finished():
		$Knight/AnimationPlayer.play("Idle")
		return
	var next_position := _nav_agent.get_next_path_position()
	var offset := next_position - global_position
	global_position = global_position.move_toward(next_position, delta * SPEED)
	
	offset.y = 0
	look_at(global_position + offset, Vector3.UP)

func set_target_position(target_position: Vector3):
	_nav_agent.set_target_position(target_position)
	var start_position := global_transform.origin
	var optimize := true
	var navigation_map := get_world_3d().get_navigation_map()
	var path := NavigationServer3D.map_get_path(
		navigation_map,
		start_position,
		target_position,
		optimize)

func set_animation_loops():
	$Knight/AnimationPlayer.get_animation("Idle").loop_mode = true
	$Knight/AnimationPlayer.get_animation("Walking_A").loop_mode = true
