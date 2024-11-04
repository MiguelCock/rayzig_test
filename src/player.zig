const rl = @import("raylib");
const ly = @import("layer.zig");

pub const Player = struct {
    aabb: rl.Rectangle,
    texture: rl.Texture2D,
    pos: rl.Vector2,
    layer: ly.Layer,
    speed: f32,

    pub fn controls(self: *Player) void {
        if (rl.isKeyDown(rl.KeyboardKey.key_a)) {
            self.pos.x -= self.speed;
        }
        if (rl.isKeyDown(rl.KeyboardKey.key_d)) {
            self.pos.x += self.speed;
        }
        if (rl.isKeyDown(rl.KeyboardKey.key_w)) {
            self.pos.y -= self.speed;
        }
        if (rl.isKeyDown(rl.KeyboardKey.key_s)) {
            self.pos.y += self.speed;
        }
    }
};
