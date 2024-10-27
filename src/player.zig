const rl = @import("raylib");

pub const player = struct {
    aabb: rl.Rectangle,
    texture: rl.Texture2D,
};

const speed: f32 = 15;

pub fn controls(pos: *rl.Vector2) void {
    if (rl.isKeyDown(rl.KeyboardKey.key_a)) {
        pos.x -= speed;
    }
    if (rl.isKeyDown(rl.KeyboardKey.key_d)) {
        pos.x += speed;
    }
    if (rl.isKeyDown(rl.KeyboardKey.key_w)) {
        pos.y -= speed;
    }
    if (rl.isKeyDown(rl.KeyboardKey.key_s)) {
        pos.y += speed;
    }
}
