shader_type canvas_item;

uniform sampler2D mask_texture;
uniform bool mask_with_alpha = false;

void fragment() {
	vec4 mask = texture(mask_texture, UV);
	if (mask_with_alpha) {
		vec4 color = texture(TEXTURE,UV);
		color.a = 1.0 - mask.r;
		COLOR = color;
	} else {
		if(mask.r>0.5) {
			discard;
	}
}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}