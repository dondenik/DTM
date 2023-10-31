shader_type canvas_item;

uniform float outside_time;

void fragment() {
	float elapsed_time = TIME-outside_time;
	COLOR = vec4(COLOR.r, COLOR.g, COLOR.b, COLOR.a - (1.0 - (0.4 * elapsed_time * -1)));
}
