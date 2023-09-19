shader_type canvas_item;

uniform float direction = 0.0;

void fragment() {
	float offset = 0.0;
	offset = direction / PI;
	if (UV.x + offset > 0.9) {
		offset -= 0.333333333;
	}
	else if (UV.x + offset < 0.1) {
		offset += 0.333333333;
	}
	COLOR = texture(TEXTURE, vec2(UV.x + offset, UV.y));
	//COLOR.a = float((0.1 < UV.x) && (UV.x < 0.9)) * COLOR.a;
}
