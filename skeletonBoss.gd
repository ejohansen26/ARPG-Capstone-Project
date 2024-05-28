extends CharacterBody3D

var player = null

@export var player_path : NodePath

@onready var _player := $Player as CharacterBody3D
@onready var _nav_agent := $NavigationAgent3D as NavigationAgent3D

const SPEED = 3.0
var is_active = false
var health = 10
const ATTACK_RANGE = 2.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	player = get_node(player_path)
	$Skeleton_Warrior/AnimationPlayer.play("Spawn_Ground_Skeletons")
	$Skeleton_Warrior/AnimationPlayer.pause()

func _process(delta):
	if is_active:
		if $Skeleton_Warrior/AnimationPlayer.current_animation == "Spawn_Ground_Skeletons":
			return
	
		velocity = Vector3.ZERO
	
		_nav_agent.set_target_position(player.global_transform.origin)
		var next_nav_point = _nav_agent.get_next_path_position()
		velocity = (next_nav_point - global_transform.origin).normalized() * SPEED
	
		look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
	
		move_and_slide()
	
		if _nav_agent.is_navigation_finished():
			$Skeleton_Warrior/AnimationPlayer.play("Idle")
			return
	
		if is_active:
			$Skeleton_Warrior/AnimationPlayer.play("Walking_D_Skeletons")
		
		
	

	
	
	
func _target_in_range():
	return global_position.distance_to(player.global_position) < ATTACK_RANGE

func set_animation_loops():
	$Skeleton_Warrior/AnimationPlayer.get_animation("Walking_D_Skeletons").loop_mode = true
	$Skeleton_Warrior/AnimationPlayer.get_animation("Idle").loop_mode = true


func _on_visible_on_screen_notifier_3d_screen_entered():
	is_active = true
	$Skeleton_Warrior/AnimationPlayer.play()
