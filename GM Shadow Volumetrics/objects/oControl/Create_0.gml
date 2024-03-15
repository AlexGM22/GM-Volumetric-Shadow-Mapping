// @Description:

window_set_cursor(cr_none);
gpu_set_ztestenable(1);
gpu_set_tex_filter(1);
gpu_set_tex_repeat(1);

px = -332.73;
py = 578.39;
pz = -155.42;

pSpd = 0.25;

dx = 0;
dy = 0;

sDx = 1;
sDy = 1;
sDz = -1;

xF = 156.01; yF = 219.81; zF = -200;

sceneModel = load_obj("SceneH.obj");

pFov = 60;

viewMatrix = -1;
projMatrix = matrix_build_projection_perspective_fov(pFov, 16/9, 0.01, 10000);

LVM = [ -0.98,0.16,-0.10,0,-0.19,-0.84,0.51,0,0,0.52,0.86,0,106.31,465.18,827.27,1 ];
LPM = -1;

surfShadowMap = surface_create(2048, 2048);
surfScattering = surface_create(room_width, room_height, surface_r32float);
surfRender = surface_create(room_width, room_height);
