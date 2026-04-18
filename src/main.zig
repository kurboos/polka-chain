const std = @import("std");
const Sha256 = std.crypto.hash.sha2.Sha256;

const Block = struct {
    index: u64,
    timestamp: i64,
    prev_hash: [32]u8,
    nonce: u64,
    hash: [32]u8,
};

fn calculateHash(block: Block) [32]u8 {
    var hasher = Sha256.init(.{});

    hasher.update(std.mem.asBytes(&block.index));
    hasher.update(std.mem.asBytes(&block.timestamp));
    hasher.update(&block.prev_hash);
    hasher.update(std.mem.asBytes(&block.nonce));

    var out: [32]u8 = undefined;
    hasher.final(&out);
    return out;
}

fn createGenesisBlock() Block {
    var block = Block{
        .index = 0,
        .timestamp = 0,
        .prev_hash = [_]u8{0} ** 32, // no previous block
        .nonce = 0,
        .hash = undefined,
    };

    block.hash = calculateHash(block);
    return block;
}

pub fn main() void {
    std.debug.print("Polka L1 Blockchain\n", .{});

    const genesis = createGenesisBlock();

    std.debug.print("Genesis Block:\n", .{});
    std.debug.print("Index: {d}\n", .{genesis.index});
    std.debug.print("Timestamp: {d}\n", .{genesis.timestamp});
    std.debug.print("Hash: {x}\n", .{genesis.hash});
}
