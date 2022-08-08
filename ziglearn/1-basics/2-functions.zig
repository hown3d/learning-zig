const expect = @import("std").testing.expect;

// function parameters are immutable by default
fn addFive(x: u32) u32 {
    return x + 5;
}

test "function" {
    const y = addFive(0);
    try expect(@TypeOf(y) == u32);
    try expect(y == 5);
}

fn fibonacci(n: u16) u16 {
    if (n == 0 or n == 1) return n;
    return fibonacci(n - 1) + fibonacci(n - 2);
}

test "function recursive" {
    const x = fibonacci(10);
    try expect(x == 55);
}

// Defer is used to execute a statement while exiting the current block.
test "defer" {
    var x: u16 = 5;
    {
        defer x += 2;
        try expect(x == 5);
    }
    try expect(x == 7);
}
