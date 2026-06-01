#pragma header
uniform float iTime;
#define iChannel0 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main


void mainImage() {
vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;
vec2 iResolution = openfl_TextureSize;
    float currentTime = iTime * 1.0;
    float randomColor = fract(sin(dot(fragCoord.xy + vec2(currentTime), vec2(1.9898, 7.233))) * 13758.5453);
    fragColor = vec4(randomColor, randomColor, randomColor, 1.0);
}