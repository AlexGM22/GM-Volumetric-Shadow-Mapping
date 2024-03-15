// @Description:

if(keyboard_check(vk_shift)) {
	pFov = lerp(pFov, 75, 0.1);
	pSpd = lerp(pSpd, 3.75, 0.1);
} else {
	pFov = lerp(pFov, 60, 0.1);
	pSpd = lerp(pSpd, 3.60, 0.1);
}

if(keyboard_check(vk_space))
{
	xF = px; yF = py; zF = pz;
	LVM = viewMatrix;
}
