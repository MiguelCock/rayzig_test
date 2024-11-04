const rl = @import("raylib");

pub fn v2lerp(v1: rl.Vector2, v2: rl.Vector2, t: f32) rl.Vector2 {
    const res = rl.Vector2{
        .x = (1 - t) * v1.x + v2.x * t,
        .y = (1 - t) * v1.y + v2.y * t,
    };
    return res;
}

// ========= PERLING NOICE =========

fn fade(t: f32) f32 {
    return t * t * t * (t * (t * 6 - 15) + 10);
}

pub fn lerp(a: f32, b: f32, t: f32) f32 {
    return a + t * (b - a);
}

fn grad(hash: i32, x: f32, y: f32) f32 {
    const h = hash & 3;
    const u = if (h < 2) x else -x;
    const v = if ((h & 1) == 0) y else -y;
    return u + v;
}

const perm = [256]u8{
    151, 160, 137, 91,  90,  15,  131, 13,  201, 95,  96,  53,  194, 233, 7,   225,
    140, 36,  103, 30,  69,  142, 8,   99,  37,  240, 21,  10,  23,  190, 6,   148,
    247, 120, 234, 75,  0,   26,  197, 62,  94,  252, 219, 203, 117, 35,  11,  32,
    57,  177, 33,  88,  237, 149, 56,  87,  174, 20,  125, 136, 171, 168, 68,  175,
    74,  165, 71,  134, 139, 48,  27,  166, 77,  146, 158, 231, 83,  111, 229, 122,
    60,  211, 133, 230, 220, 105, 92,  41,  55,  46,  245, 40,  244, 102, 143, 54,
    65,  25,  63,  161, 1,   216, 80,  73,  209, 76,  132, 187, 208, 89,  18,  169,
    200, 196, 135, 130, 116, 188, 159, 86,  164, 100, 109, 198, 173, 186, 3,   64,
    52,  217, 226, 250, 124, 123, 5,   202, 38,  147, 118, 126, 255, 82,  85,  212,
    207, 206, 59,  227, 47,  16,  58,  17,  182, 189, 28,  42,  223, 183, 170, 213,
    119, 248, 152, 2,   44,  154, 163, 70,  221, 153, 101, 155, 167, 43,  172, 9,
    129, 22,  39,  253, 19,  98,  108, 110, 79,  113, 224, 232, 178, 185, 112, 104,
    218, 246, 97,  228, 251, 34,  242, 193, 238, 210, 144, 12,  191, 179, 162, 241,
    81,  51,  145, 235, 249, 14,  239, 107, 49,  192, 214, 31,  181, 199, 106, 157,
    184, 84,  204, 176, 115, 121, 50,  45,  127, 4,   150, 254, 138, 236, 205, 93,
    222, 114, 67,  29,  24,  72,  243, 141, 128, 195, 78,  66,  215, 61,  156, 180,
};

pub fn perlin(x: f32, y: f32) f32 {
    const xi: usize = @intCast(@as(usize, @intFromFloat(@floor(x))) & 255);
    const yi: usize = @intCast(@as(usize, @intFromFloat(@floor(y))) & 255);

    const xf: f32 = x - @floor(x);
    const yf: f32 = y - @floor(y);

    const u = fade(xf);
    const v = fade(yf);

    const aa = perm[xi + perm[yi]] % 255;
    const ab = perm[xi + perm[yi + 1]] % 255;
    const ba = perm[xi + 1 + perm[yi]] % 255;
    const bb = perm[xi + 1 + perm[yi + 1]] % 255;

    const x1 = lerp(grad(aa, xf, yf), grad(ba, xf - 1, yf), u);
    const x2 = lerp(grad(ab, xf, yf - 1), grad(bb, xf - 1, yf - 1), u);

    return (lerp(x1, x2, v) + 1) / 2; // Normalize result to 0.0 - 1.0
}
