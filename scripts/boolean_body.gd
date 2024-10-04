extends PhysicsBody2D
class_name BooleanBody

enum BooleanType {
	HOLE,
	SOLID,
}

@export var boolean_type: BooleanType
@export var show_debug_polygon: bool

@onready var overlapper: Area2D = $OverlapDetector
@onready var overlapper_polygon: CollisionPolygon2DExt = $OverlapDetector/CollisionPolygon2D

@onready var booleaned_segments: Array[CollisionShape2DExt]

func _ready() -> void:
	collision_layer = Layers.LEVEL
	collision_mask = Layers.DEFAULT
	
	match boolean_type:
		BooleanType.HOLE:
			overlapper.collision_layer = Layers.HOLE_OVERLAPPER
			overlapper.collision_mask = Layers.SOLID_OVERLAPPER
		_:
			overlapper.collision_layer = Layers.SOLID_OVERLAPPER
			overlapper.collision_mask = Layers.HOLE_OVERLAPPER
			
	var polygon: PackedVector2Array = overlapper_polygon.get_global()
			
	if show_debug_polygon:
		var debug_polygon = Polygon2DExt.new()
		add_child(debug_polygon)
		debug_polygon.set_global(polygon)
		
		match boolean_type:
			BooleanType.HOLE:
				debug_polygon.color = Color.INDIAN_RED
			_:
				debug_polygon.color = Color.WHITE
	
	#if (boolean_type == BooleanType.HOLE):
		#overlapper_polygon.set_global(PackedVector2Array(Array(polygon).map(
			#func(point): return point - point.direction_to(global_position).round())))
				
func _physics_process(_delta: float) -> void:
	var polylines: Array[PackedVector2Array] = [overlapper_polygon.get_global()]
	polylines[0].append(polylines[0][0])
	
	var booleaned
	
	match boolean_type:
		BooleanType.HOLE:
			booleaned = []
			
			for area in overlapper.get_overlapping_areas():
				var polygon: PackedVector2Array = (area.get_child(0) as CollisionPolygon2DExt).get_global()
				
				for polyline in polylines:
					booleaned.append_array(Geometry2D.intersect_polyline_with_polygon(polyline, polygon))
		_:
			for area in overlapper.get_overlapping_areas():
				var polygon: PackedVector2Array = (area.get_child(0) as CollisionPolygon2DExt).get_global()
				var partially_booleaned: Array[PackedVector2Array]
				
				for polyline in polylines:
					partially_booleaned.append_array(Geometry2D.clip_polyline_with_polygon(polyline, polygon))
				
				polylines = partially_booleaned
				
			booleaned = polylines
	
	if (boolean_type == BooleanType.HOLE):
		booleaned = booleaned.map(
			func(polyline): return PackedVector2Array(Array(polyline).map(
				func(point): return point + point.direction_to(global_position) * 0.01)))
			
	var curr_segment_index: int = 0
		
	for polyline in booleaned:
		for start_index in polyline.size() - 1:
			var end_index = start_index + 1
			var segment: CollisionShape2DExt
			
			if (booleaned_segments.size() > curr_segment_index):
				segment = booleaned_segments[curr_segment_index]
				segment.disabled = false
			else:
				segment = CollisionShape2DExt.new()
				add_child(segment)
				booleaned_segments.append(segment)
			
			var start = polyline[start_index]
			var end = polyline[end_index]
			
			var forward = start.direction_to(end)
			segment.set_global_segment(start + forward * 0.25, end - forward * 0.25)
			curr_segment_index += 1
	
	for disable_index in range(curr_segment_index, booleaned_segments.size()):
		booleaned_segments[disable_index].disabled = true
