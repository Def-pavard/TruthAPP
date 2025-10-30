#version 460 core
#include <flutter/runtime_effect.glsl>

uniform vec2 uSize;
uniform float uTime;
uniform float uGen;        // Nouvelle uniform : génération actuelle
uniform float uHealth;     // Santé (0=mort, 1=plein forme)

out vec4 fragColor;

// --- Bruit & FBM (inchangé) ---
float hash(vec2 p) { return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453); }
float noise(vec2 p) {
    vec2 i = floor(p), f = fract(p), u = f*f*(3.0-2.0*f);
    return mix(mix(hash(i), hash(i+vec2(1,0)), u.x),
               mix(hash(i+vec2(0,1)), hash(i+vec2(1,1)), u.x), u.y);
}
float fbm(vec2 p) {
    float v = 0.0, a = 0.5, f = 1.0;
    for (int i = 0; i < 6; i++) { v += a * noise(p*f); a *= 0.5; f *= 2.0; }
    return v;
}

// --- Système Organique (discrétisé dans le shader) ---
struct Organism {
    float x;       // état
    float amp;     // amplitude de base
    float freq;    // fréquence interne
    float age;     // âge depuis renaissance
    float health;  // santé (décroît avec maladie)
    bool alive;
};

Organism updateOrganism(Organism org, float dt, float genSeed) {
    if (!org.alive) return org;

    org.age += dt;

    // Phase de vie (croissance → pic → déclin)
    float lifeCycle = sin(org.age * 0.3);
    float A = org.amp * (1.0 + 0.8 * lifeCycle) * mix(0.8, 1.3, hash(vec2(genSeed, 1.0)));
    float B = org.freq * (1.0 + 0.6 * abs(lifeCycle)) * mix(0.9, 1.2, hash(vec2(genSeed, 2.0)));

    // Maladie : oscillation parasite
    float diseaseAmp = 0.4 * sin(org.age * 0.1) * hash(vec2(genSeed, 3.0));
    float D = diseaseAmp * sin(2.5 * org.age + hash(vec2(genSeed, 4.0)) * 6.28);

    // Bruit + phase
    float phi = hash(vec2(genSeed, 5.0)) * 6.28;
    float eps = (noise(vec2(org.age * 10.0, genSeed)) - 0.5) * 0.25;

    // Régénération si proche de zéro
    float R = 0.0;
    if (abs(org.x) < 0.2) R = mix(-0.4, 0.4, hash(vec2(org.age, genSeed)));

    // Mise à jour
    float x_new = A * sin(B * org.x + phi) + R + eps + D;

    // --- Mort ---
    if (abs(x_new) > org.amp * 7.0) { org.alive = false; } // Crise
    if (abs(x_new) < 0.12 && abs(org.x) < 0.12) { org.health -= 0.3; } // Stagnation
    if (org.health <= 0.0) { org.alive = false; }

    org.x = org.alive ? x_new : 0.0;
    org.health = org.alive ? org.health : 0.0;

    return org;
}

void main() {
    vec2 uv = FlutterFragCoord().xy / uSize;
    float t = uTime * 0.8;

    // --- Initialisation persistante (via seed) ---
    float genSeed = floor(uGen);
    Organism org = Organism(
        0.1,
        1.0 + 0.5 * hash(vec2(genSeed, 0.0)),  // amp mutée
        1.5 + 0.7 * hash(vec2(genSeed, 1.0)),  // freq mutée
        mod(uTime, 1000.0),                    // âge
        uHealth,
        uHealth > 0.01
    );

    // Simuler 20 pas discrets pour stabilité
    float dt = 0.05;
    for (int i = 0; i < 20; i++) {
        org = updateOrganism(org, dt, genSeed);
    }

    // --- Animation des aurores ---
    vec2 distorted = uv + vec2(
        fbm(uv * 0.5 + t * 0.1 + org.x * 0.3) * 0.25,
        fbm(uv * 0.3 - t * 0.05 + org.x * 0.2) * 0.15
    );

    float pulse = abs(org.x) * 0.5 + 0.5; // battement
    float aurora = pow(sin(distorted.x * 12.0 + t * 0.6 + org.x) * 0.5 + 0.5, 2.5);
    aurora *= fbm(distorted * 2.5 + t * 0.3) * pulse;
    aurora *= (1.0 - uv.y) * 1.8;

    // --- Palette évolutive par génération ---
    vec3 colors[5] = vec3[](
        vec3(0.243, 0.706, 0.537), // #3EB489 - vert menthe (gen 1)
        vec3(0.780, 0.082, 0.522), // #C71585 - rose profond
        vec3(0.541, 0.169, 0.886), // #8A2BE2 - violet
        vec3(0.490, 0.976, 1.0),   // #7DF9FF - bleu électrique
        vec3(1.0, 0.8, 0.3)         // orange doré (vieillesse)
    );

    int genIdx = int(mod(genSeed, 5.0));
    vec3 baseCol = colors[genIdx];
    vec3 nextCol = colors[(genIdx + 1) % 5];
    vec3 col = mix(baseCol, nextCol, fract(genSeed));

    // Maladie = teinte rougeâtre
    col = mix(col, vec3(0.8, 0.2, 0.2), (1.0 - uHealth) * 0.6);

    // Luminosité pulsée
    col *= aurora * (0.8 + 0.7 * pulse);

    // Assombrir le bas + santé
    col *= smoothstep(0.0, 0.5, uv.y) * (0.5 + 0.5 * uHealth);

    fragColor = vec4(col, 1.0);
}
