shader_type canvas_item;

uniform float direction = 0.0;

void fragment() {
	COLOR = texture(TEXTURE, vec2(UV.x + (direction/(2.0*PI)), UV.y));
	COLOR.a = float((0.4 < UV.x) && (UV.x < 0.6)) * COLOR.a;
}
