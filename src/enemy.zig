const rl = @import("raylib");

const frog = rl.loadTexture("resources/character/rati.png");

pub const enemy = struct {
    aabb: rl.Rectangle,
    texture: rl.Texture2D,

    pub fn draw() void {}
};

pub fn free() void {
    frog.unload();
}
