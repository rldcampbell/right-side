import Foundation

struct SeededRandomGenerator: RandomNumberGenerator {
    private var state: UInt64

    init(seed: UUID) {
        var value: UInt64 = 0xcbf29ce484222325
        let uuid = seed.uuid

        withUnsafeBytes(of: uuid) { bytes in
            for byte in bytes {
                value ^= UInt64(byte)
                value &*= 0x100000001b3
            }
        }

        state = value
    }

    mutating func next() -> UInt64 {
        state &+= 0x9e3779b97f4a7c15
        var result = state
        result = (result ^ (result >> 30)) &* 0xbf58476d1ce4e5b9
        result = (result ^ (result >> 27)) &* 0x94d049bb133111eb

        return result ^ (result >> 31)
    }
}
