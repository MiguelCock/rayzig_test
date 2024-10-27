const rl = @import("raylib");
const bg = @import("back_ground.zig");
const ply = @import("player.zig");
const uty = @import("utility.zig");

pub fn main() anyerror!void {
    const screenWidth = 1020;
    const screenHeight = 768;

    rl.initWindow(screenWidth, screenHeight, "rat example");
    defer rl.closeWindow();

    rl.setTargetFPS(60);

    const rat = rl.loadTexture("resources/character/ratt.png");
    defer rat.unload();
    const rat2 = rl.loadTexture("resources/character/rati.png");
    defer rat2.unload();

    //const green = rl.loadTexture("resources/map_tiles/green_2.png");
    //defer green.unload();
    //const yellow = rl.loadTexture("resources/map_tiles/yellow_2.png");
    //defer yellow.unload();
    //const rock = rl.loadTexture("resources/map_tiles/rock.png");
    //defer rock.unload();

    const back = rl.loadTexture("resources/tests/back.png");
    defer back.unload();
    const middle = rl.loadTexture("resources/tests/middle.png");
    defer middle.unload();
    const front = rl.loadTexture("resources/tests/front.png");
    defer front.unload();

    var rat_pos = rl.Vector2.init(0, 0);

    var camera = rl.Camera2D{
        .offset = rl.Vector2.init(screenWidth / 2, screenHeight / 2),
        .target = rat_pos,
        .rotation = 0,
        .zoom = 1,
    };

    var dist = rl.Vector2.init(0, 0);
    var len: f32 = 0;
    var speed: f32 = 10;

    while (!rl.windowShouldClose()) {
        dist = rat_pos.add(camera.target.negate());
        len = dist.length();

        speed = uty.lerp(0, len, 0.15);

        if (len < 6) {
            camera.target = rat_pos;
        } else {
            camera.target = camera.target.add(dist.normalize().scale(speed));
        }

        ply.controls(&rat_pos);

        rl.beginDrawing();
        defer rl.endDrawing();

        camera.begin();
        defer camera.end();

        rl.clearBackground(rl.Color.white);

        bg.back(back, rl.Vector2.init(0, 0));
        bg.middle(middle, rl.Vector2.init(0, 0));
        bg.front(front, rl.Vector2.init(0, 0));

        rat2.drawEx(camera.target, 0, 4, rl.Color.white);

        rat.drawEx(rat_pos, 0, 4, rl.Color.white);
    }
}
