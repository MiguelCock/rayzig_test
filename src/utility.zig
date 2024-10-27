const rl = @import("raylib");

pub fn v2lerp(v1: rl.Vector2, v2: rl.Vector2, t: f32) rl.Vector2 {
    const res = rl.Vector2{
        .x = (1 - t) * v1.x + v2.x * t,
        .y = (1 - t) * v1.y + v2.y * t,
    };
    return res;
}

pub fn lerp(a: f32, b: f32, t: f32) f32 {
    return (1 - t) * a + b * t;
}
