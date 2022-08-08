const constant: i32 = 5;
var variable: i32 = 5;

// @as performs an explicit type coercion
const inferred_constant = @as(i32, 5);
var inferred_variable = @as(u32, 5000);

// variables and constans must have a value.
// you can use undefined if the value of the variable is not yet known.
// they must have a valid type though
const a: i32 = undefined;
const b: u32 = undefined;

// arrays
const a = [5]u8{ 'h', 'e', 'l', 'l', 'o' };
// arrays with unknown size
const b = [_]u8{ 'h', 'e', 'l', 'l', 'o' };

const len = b.len;
