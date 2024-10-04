shader_type canvas_item;

uniform float rect_size = 0.25;
uniform float location_x = 0.0;
uniform float location_y = 0.0;
uniform float ratio_width = 1.0;
uniform float ratio_height = 1.0;
uniform bool invert_mask = false;

void fragment() {
	float alpha1 = step((0.5 - rect_size * 0.5) + location_x, mix(0.5, UV.x, ratio_width));
	float alpha2 = step((0.5 - rect_size * 0.5) - location_x, mix(0.5, 1.0-UV.x, ratio_width));
	float alpha3 = step((0.5 - rect_size * 0.5) + location_y, mix(0.5, UV.y, ratio_height));
	float alpha4 = step((0.5 - rect_size * 0.5) - location_y, mix(0.5, 1.0-UV.y, ratio_height));
	float alpha_total = alpha1 * alpha2 * alpha3 * alpha4;
	vec4 orig_color = texture(TEXTURE, UV);
	COLOR.rgb = orig_color.rgb;
	if (invert_mask == true) {
		alpha_total = 1.0 - alpha_total;
	}
	COLOR.a = alpha_total * orig_color.a;
}