shader_type canvas_item;

uniform vec2 amplitude = vec2(10.0,5.0);

void vertex() {
	UV.x += TIME * .05;
	UV.y += TIME * .05;
	
	VERTEX.x += cos(TIME * 1.0 + VERTEX.x + VERTEX.y) * amplitude.x;
	
	// Called for every vertex the material is visible on.
}


