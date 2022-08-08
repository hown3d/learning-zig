// Slices can be thought of as a pair of [*]T (the pointer to the data) and a usize (the element count).
// Their syntax is given as []T, with T being the child type.
// Slices are used heavily throughout Zig for when you need to operate on arbitrary amounts of data.
// Slices have the same attributes as pointers, meaning that there also exists const slices.
// For loops also operate over slices. String literals in Zig coerce to []const u8.

const expect = @import("std").testing.expect;
fn total(values: []const u8) usize {
    var sum: usize = 0;
    for (values) |v| sum += v;
    return sum;
}
test "slices" {
    const array = [_]u8{ 1, 2, 3, 4, 5 };
    // create a slice from an array n till m-1
    const slice = array[0..3];
    try expect(total(slice) == 6);
}

// when n and m 
test "slices 2" {
    const array = [_]u8{ 1, 2, 3, 4, 5 };
    const slice = array[0..3];
    try expect(@TypeOf(slice) == *const [3]u8);
}