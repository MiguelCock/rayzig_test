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

    var pos = rl.Vector2.init(400, 225);
    var vel = rl.Vector2.init(2, -5);
    const acc = rl.Vector2.init(0, 0.1);

    while (!rl.windowShouldClose()) {
        pos = pos.add(vel);
        vel = vel.add(acc);

        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(rl.Color.white);

        bg.draw();

        //rl.drawText("Congrats! You created your first window!", 190, 200, 20, rl.Color.light_gray);

        rl.drawCircleV(pos, 20, rl.Color.dark_gray);

        rl.drawTextureEx(val, pos, 0, 1, rl.Color.white);
    }
}
