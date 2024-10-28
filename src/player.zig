const rl = @import("raylib");

pub const Layer = enum {
    back,
    front,

    pub fn change(self: *Layer) void {
        if (rl.isKeyPressed(rl.KeyboardKey.key_e)) {
            switch (self.*) {
                .back => self.* = Layer.front,
                .front => {},
            }
        }
        if (rl.isKeyPressed(rl.KeyboardKey.key_q)) {
            switch (self.*) {
                .back => {},
                .front => self.* = Layer.back,
            }
        }
    }
};

pub const player = struct {
    aabb: rl.Rectangle,
    texture: rl.Texture2D,
    pos: rl.Vector2,
    layer: Layer,
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
