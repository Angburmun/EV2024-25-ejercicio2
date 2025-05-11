shader_type spatial;

uniform sampler2D bump_texture;
uniform float bump_strength = 1.0;

void fragment() {
    vec2 tex_size = vec2(textureSize(bump_texture, 0));
    vec2 texel = 1.0 / tex_size;

    // Pixel actual
    float height_l = texture(bump_texture, UV - vec2(texel.x, 0.0)).r;
    float height_r = texture(bump_texture, UV + vec2(texel.x, 0.0)).r;
    float height_u = texture(bump_texture, UV - vec2(0.0, texel.y)).r;
    float height_d = texture(bump_texture, UV + vec2(0.0, texel.y)).r;

    // Derivada de la imagen
    float dX = (height_r - height_l);
    float dY = (height_d - height_u);

    // Normal modificada de cada píxel
    vec3 bumped_normal = normalize(vec3(-dX * bump_strength, -dY * bump_strength, 1.0));

    // Return
    NORMAL = bumped_normal;
}


//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
