const rl = @import("raylib");
const bg = @import("back_ground.zig");

pub fn main() anyerror!void {
    const screenWidth = 800;
    const screenHeight = 450;

    rl.initWindow(screenWidth, screenHeight, "raylib-zig [core] example - basic window");
    defer rl.closeWindow();

    rl.setTargetFPS(60);

    const val = rl.loadTexture("resources/character/vale.png");
    defer val.unload();
    const rat = rl.loadTexture("resources/character/rat.png");
    defer rat.unload();
    const green = rl.loadTexture("resources/map_tiles/green.png");
    defer green.unload();
    const yellow = rl.loadTexture("resources/map_tiles/yellow.png");
    defer yellow.unload();

    var pos = rl.Vector2.init(400, 225);
    var vel = rl.Vector2.init(2, -5);
    const acc = rl.Vector2.init(0, 0.1);

    var rat_pos = rl.Vector2.init(0, 0);

    while (!rl.windowShouldClose()) {
        pos = pos.add(vel);
        vel = vel.add(acc);

        switch (rl.getKeyPressed()) {
            rl.KeyboardKey.key_a => rat_pos.x -= 64,
            rl.KeyboardKey.key_d => rat_pos.x += 64,
            rl.KeyboardKey.key_s => rat_pos.y += 64,
            rl.KeyboardKey.key_w => rat_pos.y -= 64,
            else => {},
        }

        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(rl.Color.white);

        bg.drawCheckers(green, yellow);

        //rl.drawText("Congrats! You created your first window!", 190, 200, 20, rl.Color.light_gray);

        val.drawEx(pos.add(rl.Vector2.init(-32, -32)), 0, 0.5, rl.Color.white);

        rat.drawEx(rat_pos, 0, 1, rl.Color.white);
    }
}
