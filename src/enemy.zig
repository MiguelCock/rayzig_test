const rl = @import("raylib");
const ly = @import("layer.zig");
const uty = @import("utility.zig");
const ply = @import("player.zig");

const bg = @import("back_ground.zig");

pub const Enemy = struct {
    aabb: rl.Rectangle,
    texture: rl.Texture2D,
    pos: rl.Vector2,
    layer: ly.Layer,
    speed: f32,

    pub fn draw(self: *Enemy, player: ply.Player, offset: rl.Vector2) void {
        switch (player.layer) {
            .back => bg.draw(self.*.pos.x, self.*.pos.y, self.*.texture, offset, 3.5, 255),
            .front => bg.draw(self.*.pos.x, self.*.pos.y, self.*.texture, offset, 4, 255),
        }
    }

    pub fn movement(self: *Enemy, player: rl.Vector2) void {
        self.pos = player.add(self.pos.invert()).normalize().scale(5);
    }
};
