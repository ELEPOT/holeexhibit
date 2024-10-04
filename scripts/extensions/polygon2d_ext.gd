extends Polygon2D
class_name Polygon2DExt

func get_global() -> PackedVector2Array:
	return PackedVector2Array(Array(polygon).map(func(point): return to_global(point)))

func set_global(target_polygon: PackedVector2Array):
	polygon = Array(target_polygon).map(func(point): return to_local(point))
