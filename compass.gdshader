shader_type canvas_item;

uniform float direction = 0.0;

void fragment() {
	COLOR = texture(TEXTURE, vec2(UV.x + ((direction/(-2.0*PI))*0.74584983567), UV.y));
	COLOR.a = (1.0 - 80.0 * pow(UV.x-0.5, 2)) * float(COLOR.a > 0.0);
}




 