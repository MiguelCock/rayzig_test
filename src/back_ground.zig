const std = @import("std");
const rl = @import("raylib");
const uty = @import("utility.zig");

pub fn draw(x: f32, y: f32, tex: rl.Texture2D, offset: rl.Vector2, scale: f32, alpha: u8) void {
    tex.drawEx(rl.Vector2.init(x * 16 * scale, y * 16 * scale).add(offset), 0, scale, rl.Color.init(255, 255, 255, alpha));
}

// ========= MAIN DRAWING FUNCTION =========

pub fn depth(tex: rl.Texture2D, offset: rl.Vector2, scale: f32, alpha: u8) void {
    var i: f32 = 0;
    while (i < 100) {
        var j: f32 = 1;
        while (j < 100) {
            draw(i, j, tex, offset, scale, alpha);
            j += 2;
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

// ========= MAAAAAP JEJEJEJE =========

pub fn perlingMap(tex: rl.Texture2D, offset: rl.Vector2, scale: f32, alpha: u8, percent: f32) void {
    var i: f32 = 0;
    while (i < 100) {
        var j: f32 = 0;
        while (j < 100) {
            const perl = uty.perlin(i / 5, j / 5);
            if (perl < percent) draw(i, j, tex, offset, scale, alpha);
            j += 1;
        }
        i += 1;
    }
}
