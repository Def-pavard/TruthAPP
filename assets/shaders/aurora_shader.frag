// assets/shaders/aurora_shader.frag
#version 460 core
#include <flutter/runtime_effect.glsl>

uniform vec2 uSize;
uniform float uTime;
uniform float uGen;        // Génération actuelle
uniform float uHealth;     // Santé (0 = mort, 1 = plein forme)

out vec4 fragColor;

// === BRUIT & FBM ===
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

// === ORGANISME (discrétisé dans le shader) ===
struct Organism {
    float x, amp, freq, age, health;
    bool alive;
};

Organism update(Organism o, float dt, float seed) {
    if (!o.alive) return o;
    o.age += dt;

    float life = sin(o.age * 0.3);
    float A = o.amp * (1.0 + 0.8 * life) * mix(0.8, 1.3, hash(vec2(seed,1)));
    float B = o.freq * (1.0 + 0.6 * abs(life)) * mix(0.9, 1.2, hash(vec2(seed,2)));
    float phi = hash(vec2(seed,5)) * 6.28;
    float eps = (noise(vec2(o.age*10, seed)) - 0.5) * 0.25;

    float R = abs(o.x) < 0.2 ? mix(-0.4, 0.4, hash(vec2(o.age, seed))) : 0.0;
    float D = 0.4 * sin(o.age * 0.1) * hash(vec2(seed,3)) * sin(2.5 * o.age + hash(vec2(seed,4))*6.28);

    float x_new = A * sin(B * o.x + phi) + R + eps + D;

    // Mort
    if (abs(x_new) > o.amp * 7.0 || (abs(x_new) < 0.12 && abs(o.x) < 0.12)) {
        o.health -= 0.3;
    }
    if (o.health <= 0.0) o.alive = false;

    o.x = o.alive ? x_new : 0.0;
    return o;
}

void main() {
    vec2 uv = FlutterFragCoord().xy / uSize;
    float t = uTime * 0.8;
    float seed = floor(uGen);

    Organism org = Organism(
        0.1,
        1.0 + 0.5 * hash(vec2(seed,0)),
        1.5 + 0.7 * hash(vec2(seed,1)),
        mod(uTime, 1000.0),
        uHealth,
        uHealth > 0.01
    );

    float dt = 0.05;
    for (int i = 0; i < 20; i++) org = update(org, dt, seed);

    // === AURORES PULSANTES ===
    vec2 d = uv + vec2(
        fbm(uv*0.5 + t*0.1 + org.x*0.3)*0.25,
        fbm(uv*0.3 - t*0.05 + org.x*0.2)*0.15
    );

    float pulse = abs(org.x)*0.5 + 0.5;
    float aurora = pow(sin(d.x*12.0 + t*0.6 + org.x)*0.5 + 0.5, 2.5);
    aurora *= fbm(d*2.5 + t*0.3) * pulse;
    aurora *= (1.0 - uv.y)*1.8;

    // === PALETTE PAR GÉNÉRATION ===
    vec3[5] palette = vec3[](
        vec3(0.243, 0.706, 0.537), // vert menthe
        vec3(0.780, 0.082, 0.522), // rose profond
        vec3(0.541, 0.169, 0.886), // violet
        vec3(0.490, 0.976, 1.0),   // bleu électrique
        vec3(1.0, 0.8, 0.3)        // doré
    );

    int i = int(mod(seed, 5.0));
    vec3 col = mix(palette[i], palette[(i+1)%5], fract(seed));
    col = mix(col, vec3(0.8, 0.2, 0.2), (1.0 - uHealth)*0.6); // maladie = rouge
    col *= aurora * (0.8 + 0.7 * pulse);
    col *= smoothstep(0.0, 0.5, uv.y) * (0.5 + 0.5 * uHealth);

    fragColor = vec4(col, 1.0);
}
