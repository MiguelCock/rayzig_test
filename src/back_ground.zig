const std = @import("std");
const rl = @import("raylib");

// ========= MAIN DRAWING FUNCTION =========

pub fn depth(tex: rl.Texture2D, offset: rl.Vector2, scale: f32, alpha: u8) void {
    var i: f32 = 0;
    while (i < 16) {
        var j: f32 = 0;
        while (j < 6) {
            tex.drawEx(rl.Vector2.init(i * 16 * scale, j * 16 * scale).add(offset), 0, scale, rl.Color.init(255, 255, 255, alpha));
            j += 1;
        }
        i += 1;
    }
}

// ========= CHESS PATTERN =========

pub fn drawCheckers(t1: rl.Texture2D, t2: rl.Texture2D) void {
    var i: i32 = 0;
    var j: i32 = 0;
    while (i < 17) {
        j = 0;
        while (j < 10) {
            var offset1: i32 = 0;
            var offset2: i32 = 64;
            if (@mod(i, 2) == 0) {
                offset1 = 64;
                offset2 = 0;
            } else {
                offset1 = 0;
                offset2 = 64;
            }
            t1.draw(i * 64, j * 128 + offset1, rl.Color.white);
            t2.draw(i * 64, j * 128 + offset2, rl.Color.white);
            j += 1;
        }
        i += 1;
    }
}

// ========= PERLING NOICE =========

fn fade(t: f32) f32 {
    return t * t * t * (t * (t * 6 - 15) + 10);
}

fn lerp(a: f32, b: f32, t: f32) f32 {
    return a + t * (b - a);
}

fn grad(hash: i32, x: f32, y: f32) f32 {
    const h = hash & 3;
    const u = if (h < 2) x else -x;
    const v = if ((h & 1) == 0) y else -y;
    return u + v;
}

fn buildPermutationTable(seed: u64) []u8 {
    var table: [256]u8 = undefined;
    var prng = std.rand.DefaultPrng.init(seed);
    var i: u8 = 0;
    while (i < 255) {
        table[i] = i;
        i += 1;
    }
    for (table) |*v| {
        const j = prng.random().int(u8) % 256;
        const temp = v.*;
        v.* = table[j];
        table[j] = temp;
    }
    return table;
}

fn perlin(x: f32, y: f32) f32 {
    const perm = comptime buildPermutationTable(10);

    const xi: i32 = @floor(x) & 255;
    const yi: i32 = @floor(y) & 255;

    const xf: f32 = x - @floor(x);
    const yf: f32 = y - @floor(y);

    const u = fade(xf);
    const v = fade(yf);

    const aa = perm[xi + perm[yi]] % 256;
    const ab = perm[xi + perm[yi + 1]] % 256;
    const ba = perm[xi + 1 + perm[yi]] % 256;
    const bb = perm[xi + 1 + perm[yi + 1]] % 256;

    const x1 = lerp(grad(aa, xf, yf), grad(ba, xf - 1, yf), u);
    const x2 = lerp(grad(ab, xf, yf - 1), grad(bb, xf - 1, yf - 1), u);

    return (lerp(x1, x2, v) + 1) / 2; // Normalize result to 0.0 - 1.0
}

// ========= MAAAAAP JEJEJEJE =========
