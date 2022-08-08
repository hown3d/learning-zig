const expect = @import("std").testing.expect;

// An error set is like an enum (details on Zig's enums later),
// where each error in the set is a value. There are no exceptions in Zig;
// errors are values. Let's create an error set.
const FileOpenError = error{
    AccessDenied,
    OutOfMemory,
    FileNotFound,
};

const AllocationError = error{OutOfMemory};

test "coerce error from a subset to a superset" {
    const err: FileOpenError = AllocationError.OutOfMemory;
    try expect(err == FileOpenError.OutOfMemory);
}

// An error set type and a normal type can be combined with the ! operator to form an error union type.
// Values of these types may be an error value, or a value of the normal type.
// Let's create a value of an error union type. Here catch is used, which is followed by an expression which is evaluated when the value before it is an error.
// The catch here is used to provide a fallback value, but could instead be a noreturn - the type of return, while (true) and others.

test "error union" {
    const maybe_error: AllocationError!u16 = 10;
    const no_error = maybe_error catch 0;
    try expect(@TypeOf(no_error) == u16);
    try expect(no_error == 10);
}

fn failingFunction() error{Oops}!void {
    return error.Oops;
}

test "returning an error" {
    failingFunction() catch |err| {
        try expect(err == error.Oops);
    };
}

// try x is a shortcut for x catch |err| return err,
// and is commonly used in places where handling an error isn't appropriate.
// Zig's try and catch are unrelated to try-catch in other languages.
fn failFn() error{Oops}!i32 {
    try failingFunction();
    return 12;
}

test "try" {
    // if return of failFn is an error, the catch block will be used.
    // else v = the value inside the error union
    var v = failFn() catch |err| {
        try expect(err == error.Oops);
        return;
    };
    try expect(v == 12); // is never reached
}

var problems: u32 = 98;

// errdefer works like defer, but only executing when the function is returned from with an error inside of the errdefer's block.
fn failFnCounter() error{Oops}!void {
    errdefer problems += 1;
    try failingFunction();
}

test "errdefer" {
    failFnCounter() catch |err| {
        try expect(err == error.Oops);
        try expect(problems == 99);
        return;
    };
}

fn createFile() !void {
    return error.AccessDenied;
}

test "inferred error set" {
    //type coercion successfully takes place
    const x: error{AccessDenied}!void = createFile();

    //Zig does not let us ignore error unions via _ = x;
    //we must unwrap it with "try", "catch", or "if" by any means
    _ = x catch {};
}

// Error sets can be merged.
const A = error{ NotDir, PathNotFound };
const B = error{ OutOfMemory, PathNotFound };
const C = A || B;
// anyerror is the global error set which due to being the superset of all error sets,
// can have an error from any set coerce to a value of it. Its usage should be generally avoided.
