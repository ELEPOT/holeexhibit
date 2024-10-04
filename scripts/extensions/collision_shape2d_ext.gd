extends CollisionShape2D
class_name CollisionShape2DExt

func set_global_segment(a: Vector2, b: Vector2):
	if (shape is not SegmentShape2D):
		shape = SegmentShape2D.new()
		
	shape = shape as SegmentShape2D
	shape.a = to_local(a)
	shape.b = to_local(b)
