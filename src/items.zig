//const std = @import("std");

const rl = @import("raylib");
const uty = @import("utility.zig");
const ply = @import("player.zig");

pub const Item = struct {
    texture: rl.Texture2D,
    pos: rl.Vector2,
    timer: f32,
    use: bool,

    pub var i: f32 = 0;

    pub fn draw(self: *Item, offset: rl.Vector2, scale: f32, alpha: u8) void {
        if (i < self.timer) {
            self.*.texture.drawEx(offset, i, scale, rl.Color.init(255, 255, 255, alpha));
            i += 10;
        }

        if (i >= self.timer) {
            i = 0;
            self.*.use = false;
        }
    }
};
