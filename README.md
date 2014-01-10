# AS3 Game Tools

A library of tools useful in game development. Contains array and vector manipulation,
memory management, random number generators, object pooling, and other convenient utilities.

It also includes parts of as3corelib from Adobe (utilities for strong hashing (MD5, SHA, HMAC),
web interop, and image encoding) which have been modified to remove any Flex dependencies,
and updated to work with Flash 11.x and later.

 

## Components 

### somasim.fn

Standard functional list operations, such as `map`, `filter`, `fold`, `any`, or `all`.
They accept both Array and Vector.<?> sequences.

Example: 
```actionscript
var done :Array = filter(isDone, _running);
```

### somasim.math

Math utilities, including things like random number generators, and a `CRC32` checksum. 

### somasim.math.random

Predictable random number generators. Given a seed value, they will always produce
the same sequence of random numbers, and their internal state can be saved and reloaded. 
This way, when the game loads from a save file, the same random numbers can be generated.

`MersenneTwister` is an implementation of MT19937, a random number generator with an 
extremely long period of 2^19937 − 1. `TinyMT` is a much faster implementation,
with a tiny internal state footprint, but a shorter period of 2^127 - 1.

Example:
```actionscript
```

### somasim.malloc

Manual memory allocation, for use with [avm2 fast memory intrinsics](http://www.adobe.com/devnet/air/articles/faster-byte-array-operations.html). 

The main problem is that fast memory intrinsics work best if all 
operations work on a single ByteArray instance instead of multiple ones
(because switching domain memory references is computationally expensive).

This component fixes the problem by initializing and managing a single ByteArray 
instance, and letting the user allocate sub-ranges of it for their own purposes.
See [this pull request](https://github.com/PrimaryFeather/Starling-Framework/pull/382) 
for additional background.

Example:
```actionscript

var mem :DomainMemoryManager = new DomainMemoryManager(1024, true);
var start :uint = mem.allocate(128);

// now use this memory
sf32(someValue, start); 
var someValueCopy :Number = lf32(start); // etc.

// finally when done with it
mem.free(start);
```

### somasim.pools

Object pool implementation, where the pool is responsible for resetting each object
back to a "clean" state before reusing it.

Example:
```actionscript
var obj :IObjectPoolEntry = pool.alloc();

// then later
pool.free(obj);

// then even later
obj = pool.alloc(); // obj might be the same instance as before, or it might not...
```

### somasim.utils

Various utilities for operation on arrays/vectors, dictionaries, etc.



