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

pub const Player = struct {
    aabb: rl.Rectangle,
    texture: rl.Texture2D,
    pos: rl.Vector2,
    layer: Layer,
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
