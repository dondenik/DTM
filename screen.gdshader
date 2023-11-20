shader_type canvas_item;

// Ranges from 0 to 1 over the course of the transition.
// We use this to actually animate the shader.
uniform float progress : hint_range(0, 1);
uniform float multiplier : hint_range(1, 10) = 3;
uniform float angle : hint_range(0, 360) = 0.0;

// anchor point of the transition (best anchor point result is 0.5, 0.5)
uniform vec2 anchor = vec2(0.5, 0.5);
// use this to increase the distance from the anchor point
uniform float anchorOffset = 1.0;

// Size of each diamond, in pixels.
uniform float diamondPixelSize = 10.0;

float when_lt(float x, float y) {
  return max(sign(y - x), 0.0);
}

void fragment() {
    float xFraction = fract(FRAGCOORD.x / diamondPixelSize);
    float yFraction = fract(FRAGCOORD.y / diamondPixelSize);
    float xDistance = abs(xFraction - 0.5);
    float yDistance = abs(yFraction - 0.5);

    COLOR.a *= when_lt(xDistance + yDistance + cos(radians(angle)) * (UV.x - anchor.x) + sin(radians(angle)) * (UV.y - anchor.y), (-anchorOffset + progress * multiplier));
}