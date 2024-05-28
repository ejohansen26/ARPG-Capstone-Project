class_name CameraPositionTarget extends Node3D

var target: Node3D
var offset: Vector3

func _ready():
	target = get_parent_node_3d()
	offset = position

func _physics_process(delta):
	global_position = target.global_position + offset
