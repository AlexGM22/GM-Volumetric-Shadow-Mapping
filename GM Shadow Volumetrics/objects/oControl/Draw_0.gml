// @Description:

var cx, cy, mx, my;

cx = window_get_width()/2;
cy = window_get_height()/2;

mx = window_mouse_get_x()-cx;
my = window_mouse_get_y()-cy;

window_mouse_set(cx, cy);

dx = dx + mx * 0.20;
dy = clamp(dy + my * 0.20, -89, 89);

//projMatrix = matrix_build_projection_perspective_fov(pFov, 16/9, 1, 10000);

var kx, ky, kz;

kx = (keyboard_check(ord("W"))-keyboard_check(ord("S")));
ky = (keyboard_check(ord("A"))-keyboard_check(ord("D")));
kz = (keyboard_check(ord("E"))-keyboard_check(ord("Q")));

px += ((dcos(dx)*kx)+(dsin(dx)*ky)) * pSpd;
py += ((dsin(dx)*kx)-(dcos(dx)*ky)) * pSpd;
pz += kz * pSpd;

var S = 100;

#region Shadow Map

//var xF = 306.01, yF = 369.81, zF = -350;

surface_set_target(surfShadowMap);
draw_clear(999);

shader_set(shDepth);

//shader_set_uniform_f(shader_get_uniform(shLight, "lightPos"), px, py, pz);

LPM = matrix_build_projection_ortho(2048, 2048, 0.01, 10000);
//LVM = matrix_build_lookat(xF, yF, zF, xF + (dcos(36)*dcos(246)), yF + (dcos(36)*dsin(246)), zF + dsin(36), 0, 0, 1);
var camera = camera_get_active();

camera_set_proj_mat(camera, LPM);
camera_set_view_mat(camera, LVM);
camera_apply(camera);

matrix_set(matrix_world, matrix_build(0,0, 0, 0, 0, 0, S, S, -S));
vertex_submit(sceneModel, pr_trianglelist, -1);
matrix_set(matrix_world, matrix_build_identity());

shader_reset();
surface_reset_target();

#endregion


#region Final Render
// Render

//shader_set_uniform_f(shader_get_uniform(shLight, "lightPos"), px, py, pz);
surface_set_target_ext(0, surfRender);
surface_set_target_ext(1, surfScattering);

draw_clear(1);

projMatrix = matrix_build_projection_perspective_fov(pFov, 16/9, 1, 10000);
viewMatrix = matrix_build_lookat(px, py, pz, px + (dcos(dy)*dcos(dx)), py + (dcos(dy)*dsin(dx)), pz + dsin(dy), 0, 0, 1);
var camera = camera_get_active();

shader_set(shLighting);

texture_set_stage(shader_get_sampler_index(shLighting, "uDT"), surface_get_texture(surfShadowMap));
texture_set_stage(shader_get_sampler_index(shLighting, "uB"), sprite_get_texture(surfShadowMap, -1));

shader_set_uniform_f(shader_get_uniform(shLighting, "uP"), px, py, pz);
shader_set_uniform_f(shader_get_uniform(shLighting, "uS"), xF, yF, zF);

shader_set_uniform_f_array(shader_get_uniform(shLighting, "uLPM"), LPM);
shader_set_uniform_f_array(shader_get_uniform(shLighting, "uLVM"), LVM);

camera_set_proj_mat(camera, projMatrix);
camera_set_view_mat(camera, viewMatrix);
camera_apply(camera);

matrix_set(matrix_world, matrix_build(0,0, 0, 0, 0, 0, S, S, -S));
vertex_submit(sceneModel, pr_trianglelist, -1);
matrix_set(matrix_world, matrix_build_identity());
shader_reset();
surface_reset_target();
#endregion