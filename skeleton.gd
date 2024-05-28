extends CharacterBody3D

signal hit
signal dead

const SPEED = 5.0
var is_active = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	move_and_slide()

func _on_visible_on_screen_notifier_screen_entered():
	is_active = true
