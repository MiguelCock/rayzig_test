const std = @import("std");
const rl = @import("raylib");
const bg = @import("back_ground.zig");
const ply = @import("player.zig");
const uty = @import("utility.zig");

pub fn main() anyerror!void {
    const screenWidth = 1920;
    const screenHeight = 980;

    rl.initWindow(screenWidth, screenHeight, "rat example");
    defer rl.closeWindow();

    rl.setTargetFPS(60);

    const rat2 = rl.loadTexture("resources/character/rati.png");
    defer rat2.unload();

    var rat_player = ply.Player{
        .aabb = rl.Rectangle.init(16, 0, 16 * 4, 16 * 4),
        .layer = ply.Layer.front,
        .pos = rl.Vector2.init(0, 0),
        .texture = rl.loadTexture("resources/character/ratt.png"),
        .speed = 15,
    };

    var offset = rl.Vector2.init(0, 0);

    defer rat_player.texture.unload();

    const back = rl.loadTexture("resources/tests/back.png");
    defer back.unload();
    const middle = rl.loadTexture("resources/tests/middle.png");
    defer middle.unload();
    const front = rl.loadTexture("resources/tests/front.png");
    defer front.unload();

    var camera = rl.Camera2D{
        .offset = rl.Vector2.init(screenWidth / 2, screenHeight / 2),
        .target = rat_player.pos,
        .rotation = 0,
        .zoom = 1,
    };

    var dist = rl.Vector2.init(0, 0);
    var len: f32 = 0;
    var speed: f32 = 10;

    //rl.toggleFullscreen();

    while (!rl.windowShouldClose()) {
        dist = rat_player.pos.add(camera.target.negate());
        len = dist.length();

        offset = rat_player.pos.scale(0.1255);

        speed = uty.lerp(0, len, 0.15);

        if (len < 6) {
            camera.target = rat_player.pos;
        } else {
            camera.target = camera.target.add(dist.normalize().scale(speed));
        }

        rat_player.layer.change();
        rat_player.controls();

        rl.beginDrawing();
        defer rl.endDrawing();

        camera.begin();
        defer camera.end();

        rl.clearBackground(rl.Color.white);

        switch (rat_player.layer) {
            .back => {
                bg.perlingMap(back, rl.Vector2.init(0, 0).add(offset), 3.5, 255);

                rat_player.texture.drawEx(rat_player.pos.add(rl.Vector2.init(-16 * 1.75, -32 * 1.75)), 0, 3.5, rl.Color.white);

                bg.perlingMap(front, rl.Vector2.init(0, 0), 4, 150);
            },
            .front => {
                bg.perlingMap(back, rl.Vector2.init(0, 0).add(offset), 3.5, 255);
                bg.perlingMap(front, rl.Vector2.init(0, 0), 4, 255);

                rat_player.texture.drawEx(rat_player.pos.add(rl.Vector2.init(-16 * 2, -32 * 2)), 0, 4, rl.Color.white);
            },
        }
        rat2.drawEx(camera.target, 0, 4, rl.Color.white);
    }
}
