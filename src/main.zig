const std = @import("std");
const rl = @import("raylib");
const bg = @import("back_ground.zig");
const ly = @import("layer.zig");
const ply = @import("player.zig");
const itm = @import("items.zig");
const enm = @import("enemy.zig");
const uty = @import("utility.zig");

pub fn main() anyerror!void {
    const screenWidth = 1800;
    const screenHeight = 900;

    rl.initWindow(screenWidth, screenHeight, "rat example");
    defer rl.closeWindow();

    rl.setTargetFPS(60);

    const rat2 = rl.loadTexture("resources/character/rati.png");
    defer rat2.unload();

    var rat_player = ply.Player{
        .aabb = rl.Rectangle.init(16, 0, 16 * 4, 16 * 4),
        .layer = ly.Layer.front,
        .pos = rl.Vector2.init(0, 0),
        .texture = rl.loadTexture("resources/character/ratt.png"),
        .speed = 15,
    };

    defer rat_player.texture.unload();

    var frog_enemy = enm.Enemy{
        .aabb = rl.Rectangle.init(16, 0, 16 * 4, 16 * 4),
        .pos = rl.Vector2.init(500, 0),
        .texture = rl.loadTexture("resources/character/frog.png"),
        .speed = 15,
    };

    defer frog_enemy.texture.unload();

    var pik = itm.Item{
        .texture = rl.loadTexture("resources/items/pik.png"),
        .pos = rl.Vector2.init(0, 0),
        .timer = 100,
        .use = false,
    };

    defer pik.texture.unload();

    const background = rl.loadTexture("resources/background/background.png");
    defer background.unload();
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

    var offset = rl.Vector2.init(0, 0);
    var offset2 = rl.Vector2.init(0, 0);

    //rl.toggleFullscreen();

    while (!rl.windowShouldClose()) {
        dist = rat_player.pos.add(camera.target.negate());
        len = dist.length();

        offset = rat_player.pos.scale(0.125);
        offset2 = rat_player.pos.scale(0.25);

        speed = uty.lerp(0, len, 0.15);

        camera.target = camera.target.add(dist.normalize().scale(speed));

        frog_enemy.movement(rat_player.pos);

        rat_player.layer.change();
        rat_player.controls();

        rl.beginDrawing();
        defer rl.endDrawing();

        //rl.clearBackground(rl.Color.white);

        background.drawEx(rl.Vector2.init(0, 0), 0, 3, rl.Color.white);

        if (rl.isMouseButtonPressed(rl.MouseButton.mouse_button_left)) pik.use = true;

        camera.begin();
        defer camera.end();

        switch (rat_player.layer) {
            .back => {
                bg.perlingMap(back, rl.Vector2.init(0, 0).add(offset), 3.5, 255, 0.55);

                frog_enemy.texture.drawEx(frog_enemy.pos.add(rl.Vector2.init(-16 * 1.75, -16 * 1.75)), 0, 3.5, rl.Color.white);

                rat_player.texture.drawEx(rat_player.pos.add(rl.Vector2.init(-16 * 1.75, -32 * 1.75)), 0, 3.5, rl.Color.white);

                if (pik.use and itm.Item.i < pik.timer) {
                    pik.draw(rat_player.pos.add(rl.Vector2.init(-16 * 1.75, -16 * 1.75)), 3.5, 255);
                }

                bg.perlingMap(front, rl.Vector2.init(0, 0), 4, 150, 0.5);
            },
            .front => {
                bg.perlingMap(back, rl.Vector2.init(0, 0).add(offset), 3.5, 255, 0.55);
                bg.perlingMap(front, rl.Vector2.init(0, 0), 4, 255, 0.5);

                frog_enemy.texture.drawEx(frog_enemy.pos.add(rl.Vector2.init(-16 * 2, -16 * 2)), 0, 4, rl.Color.white);

                rat_player.texture.drawEx(rat_player.pos.add(rl.Vector2.init(-16 * 2, -32 * 2)), 0, 4, rl.Color.white);

                if (pik.use and itm.Item.i < pik.timer) {
                    pik.draw(rat_player.pos.add(rl.Vector2.init(-16 * 2, -16 * 2)), 4, 255);
                }
            },
        }
        rl.drawRectangleV(camera.target.add(rl.Vector2.init(-5, -5)), rl.Vector2.init(10, 10), rl.Color.black);
        //rat2.drawEx(camera.target, 0, 4, rl.Color.white);
    }
}
