shader_type canvas_item;

uniform float direction = 0.0;

void fragment() {
	COLOR = texture(TEXTURE, vec2(UV.x + (direction/(2.0*PI)), UV.y));
//	COLOR.a = float(1.0-5.0*abs(UV.x-0.5))* float(COLOR.a > 0.0);
	COLOR.a = (1.0 - 50.0 * pow(UV.x-0.5, 2)) * float(COLOR.a > 0.0);
}

