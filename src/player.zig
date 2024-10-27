const rl = @import("raylib");

pub const player = struct {
    aabb: rl.Rectangle,
    texture: rl.Texture2D,
};

pub fn controls(pos: *rl.Vector2) void {
    if (rl.isKeyDown(rl.KeyboardKey.key_a)) {
        pos.x -= 10;
    }
    if (rl.isKeyDown(rl.KeyboardKey.key_d)) {
        pos.x += 10;
    }
    if (rl.isKeyDown(rl.KeyboardKey.key_w)) {
        pos.y -= 10;
    }
    if (rl.isKeyDown(rl.KeyboardKey.key_s)) {
        pos.y += 10;
    }
}
