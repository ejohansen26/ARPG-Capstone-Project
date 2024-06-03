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
	
	
		move_and_slide()
	
	
		
		
	

	
	
	
func _target_in_range():
	return global_position.distance_to(player.global_position) < ATTACK_RANGE

func set_animation_loops():
	$Skeleton_Warrior/AnimationPlayer.get_animation("Walking_D_Skeletons").loop_mode = true
	$Skeleton_Warrior/AnimationPlayer.get_animation("Idle").loop_mode = true


func _on_visible_on_screen_notifier_3d_screen_entered():
	is_active = true
	$Skeleton_Warrior/AnimationPlayer.play()
