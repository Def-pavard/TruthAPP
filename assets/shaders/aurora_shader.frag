// assets/shaders/aurora_shader.frag
#version 460 core

#include <flutter/runtime_effect.glsl>

uniform vec2 uSize;
uniform float uTime;

out vec4 fragColor;

// Fonction de bruit
float hash(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453);
}

float noise(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);
    vec2 u = f * f * (3.0 - 2.0 * f);
    
    return mix(
        mix(hash(i + vec2(0.0, 0.0)), hash(i + vec2(1.0, 0.0)), u.x),
        mix(hash(i + vec2(0.0, 1.0)), hash(i + vec2(1.0, 1.0)), u.x),
        u.y
    );
}

// Fonction pour créer des formes organiques
float fbm(vec2 p) {
    float value = 0.0;
    float amplitude = 0.5;
    float frequency = 1.0;
    
    for (int i = 0; i < 6; i++) {
        value += amplitude * noise(p * frequency);
        amplitude *= 0.5;
        frequency *= 2.0;
    }
    
    return value;
}

void main() {
    vec2 uv = FlutterFragCoord().xy / uSize;
    
    // Déformer les UV pour créer des formes d'aurores
    vec2 distortedUv = uv + vec2(
        fbm(uv * 0.5 + uTime * 0.1) * 0.2,
        fbm(uv * 0.3 - uTime * 0.05) * 0.1
    );
    
    // Créer des bandes verticales
    float aurora = sin(distortedUv.x * 10.0 + uTime * 0.5) * 0.5 + 0.5;
    aurora = pow(aurora, 3.0); // Augmenter le contraste
    
    // Ajouter de la variation avec du bruit
    float noisePattern = fbm(distortedUv * 2.0 + uTime * 0.2);
    aurora *= noisePattern;
    
    // Appliquer un gradient vertical
    float verticalGradient = 1.0 - uv.y;
    aurora *= verticalGradient * 1.5;
    
    // Définir les couleurs des aurores
    vec3 mintGreen = vec3(0.243, 0.706, 0.537); // #3EB489
    vec3 deepPink = vec3(0.780, 0.082, 0.522);  // #C71585
    vec3 blueViolet = vec3(0.541, 0.169, 0.886); // #8A2BE2
    vec3 electricBlue = vec3(0.490, 0.976, 1.0); // #7DF9FF
    
    // Mélanger les couleurs en fonction de l'intensité
    vec3 color;
    if (aurora < 0.3) {
        color = mix(vec3(0.0), mintGreen, aurora / 0.3);
    } else if (aurora < 0.6) {
        color = mix(mintGreen, deepPink, (aurora - 0.3) / 0.3);
    } else if (aurora < 0.8) {
        color = mix(deepPink, blueViolet, (aurora - 0.6) / 0.2);
    } else {
        color = mix(blueViolet, electricBlue, (aurora - 0.8) / 0.2);
    }
    
    // Ajouter de la luminosité
    color *= aurora * 1.5;
    
    // Assombrir le bas de l'écran
    color *= smoothstep(0.0, 0.5, uv.y);
    
    fragColor = vec4(color, 1.0);
}