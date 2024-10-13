const std = @import("std");
const rl = @import("raylib");

pub fn draw() void {
    for (0..16) |i| {
        const ii: i32 = @intCast(i);
        for (0..9) |j| {
            const jj: i32 = @intCast(j);
            var offset: i32 = 50;
            if (@mod(ii, 2) == 0) {
                offset = 50;
            } else {
                offset = 0;
            }
            rl.drawRectangle(ii * 50, jj * 100 + offset, 50, 50, rl.Color.black);
        }
    }
}
