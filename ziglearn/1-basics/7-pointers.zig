const expect = @import("std").testing.expect;

fn increment(num: *u8) void {
    // dereferencing with .*
    num.* += 1;
}

test "pointers" {
    var x: u8 = 1;
    // creating a reference to a normal type
    increment(&x);
    try expect(x == 2);
}

// Trying to set a *T to the value 0 is detectable illegal behaviour.
test "naughty pointer" {
    var x: u16 = 0;
    var y: *u8 = @intToPtr(*u8, x);
    _ = y;
}

test "many item pointers" {
    var pointer = [*]u8{ 1, 2, 3, 4 };
    _ = pointer;
}
