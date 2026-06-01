#pragma header
uniform float iTime;
#define iChannel0 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main

const float minInputBlack = 0.0;
uniform float maxInputBlack;

const float minInputWhite = 0.0;
uniform float maxInputWhite;

const float minGamma = 0.0;
const float maxGamma = 5.0;

const float minOutputBlack = 0.0;
uniform float maxOutputBlack;

const float minOutputWhite = 0.0;
uniform float maxOutputWhite;

vec3 gammaControl(vec3 color, float gamma) {
    float r = pow(color.r, 1.0 / gamma);
    float g = pow(color.g, 1.0 / gamma);
    float b = pow(color.b, 1.0 / gamma);
    return vec3(r, g, b);
}

vec3 inputControl(vec3 color, float minInput, float maxInput) {
    return (color - minInput) / (maxInput - minInput);
}

vec3 outputControl(vec3 color, float minOutput, float maxOutput) {
    float r = mix(minOutput, maxOutput, color.r);
    float g = mix(minOutput, maxOutput, color.g);
    float b = mix(minOutput, maxOutput, color.b);
    return vec3(r, g, b);
}

void mainImage()
{
vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;
vec2 iResolution = openfl_TextureSize;
    vec2 uv = fragCoord/iResolution.xy;
    vec4 outColor = flixel_texture2D(iChannel0, uv);

    float value = abs(sin(iTime * 0.5));
    
    // Generating only inputBlack for demonstration.
    float inputBlack = mix(minInputBlack + 50.0, maxInputBlack - 50.0, value);
    float inputWhite = 255.0;
    float gamma = 1.0;
    float outputBlack = 0.0;
    float outputWhite = 255.0;
    
    outColor.rgb = outputControl(gammaControl(inputControl(outColor.rgb, inputBlack/255.0, inputWhite/255.0), gamma), outputBlack/255.0, outputWhite/255.0);

    fragColor = outColor;
}