const rl = @import("raylib");

pub fn drawCheckers(t1: rl.Texture2D, t2: rl.Texture2D) void {
    var i: i32 = 0;
    var j: i32 = 0;
    while (i < 17) {
        j = 0;
        while (j < 10) {
            var offset1: i32 = 0;
            var offset2: i32 = 64;
            if (@mod(i, 2) == 0) {
                offset1 = 64;
                offset2 = 0;
            } else {
                offset1 = 0;
                offset2 = 64;
            }
            t1.draw(i * 64, j * 128 + offset1, rl.Color.white);
            t2.draw(i * 64, j * 128 + offset2, rl.Color.white);
            j += 1;
        }
        i += 1;
    }
}

pub fn rockNoice(tex: rl.Texture2D) void {
    var i: f32 = 0;
    while (i < 16) {
        var j: f32 = 0;
        while (j < 6) {
            tex.drawEx(rl.Vector2.init(i * 64, 384 + (j * 64)), 0, 4, rl.Color.white);
            j += 1;
        }
        i += 1;
    }
}

pub fn front(tex: rl.Texture2D, offset: rl.Vector2) void {
    var i: f32 = 0;
    while (i < 16) {
        var j: f32 = 0;
        while (j < 6) {
            tex.drawEx(rl.Vector2.init(i * 64, 384 + (j * 64)).add(offset), 0, 4, rl.Color.init(255, 255, 255, 60));
            j += 1;
        }
        i += 1;
    }
}

pub fn middle(tex: rl.Texture2D, offset: rl.Vector2) void {
    var i: f32 = 0;
    while (i < 16) {
        var j: f32 = 0;
        while (j < 6) {
            tex.drawEx(rl.Vector2.init(i * 16 * 3.5, 384 + (j * 16 * 3.5)).add(offset), 0, 3.5, rl.Color.init(255, 255, 255, 120));
            j += 1;
        }
        i += 1;
    }
}

pub fn back(tex: rl.Texture2D, offset: rl.Vector2) void {
    var i: f32 = 0;
    while (i < 16) {
        var j: f32 = 0;
        while (j < 6) {
            tex.drawEx(rl.Vector2.init(i * 16 * 3, 384 + (j * 16 * 3)).add(offset), 0, 3, rl.Color.white);
            j += 1;
        }
        i += 1;
    }
}
