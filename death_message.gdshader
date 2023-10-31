shader_type canvas_item;

void fragment() {
	COLOR = vec4(COLOR.r, COLOR.g, COLOR.b, COLOR.a - (1.0 - (0.4 * TIME)));
}
