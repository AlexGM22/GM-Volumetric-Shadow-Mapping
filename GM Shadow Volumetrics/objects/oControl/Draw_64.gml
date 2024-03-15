// @Description:

shader_set(shColor);
texture_set_stage(shader_get_sampler_index(shColor, "uf"), surface_get_texture(surfScattering));
draw_surface(surfRender, 0, 0);
shader_reset();

//draw_surface_stretched(surfShadowMap, 0, 0, 124, 124);

draw_sprite(sCross, -1, 640, 360);

//draw_text(20, 20, "X SUN: " + string(xF) + "\nY SUN: " + string(yF) + "\nZ SUN: " + string(zF) + "\nSUN: " + string(LVM));
draw_text(20, 20, "Press SPACE to change the light direction");