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
