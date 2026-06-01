
#pragma header
uniform float iTime;
#define iChannel0 bitmap
#define iChannel1 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main

uniform float Shadow;
uniform float Outlining;

void mainImage()
{
vec2 uv = openfl_TextureCoordv.xy;

vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;


vec2 iResolution = openfl_TextureSize;
    // Obtenemos el color del pixel actual
    vec4 color = texture(iChannel0, fragCoord.xy / iResolution.xy);

    // Calculamos los colores del borde mediante el efecto de bisel y relieve
    vec4 edge1 = texture(iChannel0, fragCoord.xy / iResolution.xy + vec2(-0.003,-0.004));
    vec4 edge2 = texture(iChannel0, fragCoord.xy / iResolution.xy - vec2(-0.001,-0.001));
    vec3 colorR = vec3(edge1.r - color.r + 0.6);
    vec3 colorG = vec3(edge1.g - color.g + 0.6);
    vec3 colorB = vec3(edge1.b - color.b + 0.6);
    vec3 color2R = vec3(color.r - edge2.r + 0.6);
    vec3 color2G = vec3(color.g - edge2.g + 0.6);
    vec3 color2B = vec3(color.b - edge2.b + 0.6);
    vec3 finalColor = vec3(1.0) - min(vec3(1.0), colorR + color2R) * min(vec3(1.0), colorG + color2G) * min(vec3(1.0), colorB + color2B);

    // Obtenemos los colores originales de la sprite
    vec3 spriteColor = color.rgb;

    // Ajustamos el brillo de la parte iluminada
    vec3 lightColor = spriteColor + finalColor;
    lightColor = mix(spriteColor, lightColor, Outlining);

    // Ajustamos el brillo de la parte oscura
    vec3 darkColor = spriteColor * spriteColor - 1.0;
    darkColor = mix(spriteColor, darkColor, Shadow);

    // Mezclamos los colores ajustados con los colores originales de la sprite
    finalColor = mix(darkColor, lightColor, 0.5);

    // Devolvemos el color final con el efecto de bisel y relieve
    fragColor = vec4(finalColor, color.a);
}
