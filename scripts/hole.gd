extends BooleanBody
class_name Hole

@export var velMultiplier: float

@onready var mainground: AnimatedSprite2D = $"/root/MainScene/mainground"

var self_rigidbody: RigidBody2D = self as PhysicsBody2D as RigidBody2D


func _ready() -> void:
	global_position = PositionCursor.position
	super._ready()
	
func _process(delta: float) -> void:
	mainground.material.set("shader_parameter/location_x", position.x)
	mainground.material.set("shader_parameter/location_y", position.y)
	
func _integrate_forces(_state: PhysicsDirectBodyState2D) -> void:
	var target_velocity = (PositionCursor.position - global_position) * velMultiplier
	self_rigidbody.linear_velocity = target_velocity
