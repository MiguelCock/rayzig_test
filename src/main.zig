const rl = @import("raylib");
const bg = @import("back_ground.zig");
const ply = @import("player.zig");

pub fn main() anyerror!void {
    const screenWidth = 1020;
    const screenHeight = 768;

    rl.initWindow(screenWidth, screenHeight, "rat example");
    defer rl.closeWindow();

    rl.setTargetFPS(60);

    const rat = rl.loadTexture("resources/character/ratt.png");
    defer rat.unload();
    const frog = rl.loadTexture("resources/character/rati.png");
    defer frog.unload();

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
    var frog_pos = rl.Vector2.init(400, 400);

    var camera = rl.Camera2D{
        .offset = rl.Vector2.init(screenWidth / 2, screenHeight / 2),
        .target = frog_pos,
        .rotation = 0,
        .zoom = 1,
    };

    var dist = rl.Vector2.init(0, 0);

    while (!rl.windowShouldClose()) {
        dist = rat_pos.add(frog_pos.negate());

        if (dist.x < 1 or dist.x > -1 and dist.y < 1 or dist.y > -1) {
            frog_pos = rl.Vector2.init(0, 0);
        } else {
            frog_pos = frog_pos.add(dist).normalize().scale(10);
        }

        camera.target = frog_pos;

        ply.controls(&rat_pos);

        rl.beginDrawing();
        defer rl.endDrawing();

        camera.begin();
        defer camera.end();

        rl.clearBackground(rl.Color.white);

        bg.back(back, rl.Vector2.init(0, 0));
        bg.middle(middle, rl.Vector2.init(0, 0));
        bg.front(front, rl.Vector2.init(0, 0));

        frog.drawEx(frog_pos, 0, 4, rl.Color.white);

        rat.drawEx(rat_pos, 0, 4, rl.Color.white);
    }
}
