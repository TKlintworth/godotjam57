shader_type canvas_item;

// Fragment shader for painting black circles
uniform vec2 character_pos; // Character's position
uniform float radius; // Radius of the black circle

void fragment() {
    float dist = distance(FRAGCOORD.xy, character_pos);
    if (dist < radius) {
        COLOR = vec4(0.0, 0.0, 0.0, 1.0); // Black color
    } else {
        COLOR = vec4(0.0, 0.0, 0.0, 0.0); // Otherwise, transparent
    }
}