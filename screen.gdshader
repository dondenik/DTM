shader_type canvas_item;

uniform float circle_size : hint_range(0.0, 1.05);
uniform float screen_width: hint_range(0.0, 1.0, 0.1);
uniform float screen_height: hint_range(0.0, 1.0, 0.1);
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

void fragment() {
	// circle transition
	//float ratio = screen_width / screen_height;
	//float dist = distance(vec2(0.5, 0.5), vec2(mix(0.5, UV.x, ratio), UV.y));
	//COLOR.a = step(circle_size, dist);
	//vec4 screen = textureLod(screen_texture, SCREEN_UV, 0.0);
	//COLOR = screen + vec4(1, 1, 0, 1);
	COLOR.a = 0.0;
}