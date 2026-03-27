/// Figma colour and geometry primitives.

// MARK: - Color

/// RGBA colour with each channel in the 0…1 range
/// (matches Figma REST API and plugin serialisation format).
public struct FigmaColor: Codable, Hashable, Sendable {
    public let r: Double
    public let g: Double
    public let b: Double
    /// Alpha channel. Figma REST API omits `a` for fully-opaque values;
    /// defaults to 1 when absent.
    public let a: Double?

    public var alpha: Double { a ?? 1.0 }

    public init(r: Double, g: Double, b: Double, a: Double? = nil) {
        self.r = r; self.g = g; self.b = b; self.a = a
    }

    private static let hexTable: [Character] =
        ["0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f"]

    private static func hex(_ value: Double) -> (Character, Character) {
        let i = Int((value * 255).rounded()).clamped(to: 0...255)
        return (hexTable[(i >> 4) & 0xF], hexTable[i & 0xF])
    }

    /// CSS-style hex string: `#RRGGBB` when fully opaque, `#RRGGBBAA` otherwise.
    public var cssHex: String {
        let (r0, r1) = Self.hex(r)
        let (g0, g1) = Self.hex(g)
        let (b0, b1) = Self.hex(b)
        if alpha >= 1.0 {
            return String(["#", r0, r1, g0, g1, b0, b1])
        } else {
            let (a0, a1) = Self.hex(alpha)
            return String(["#", r0, r1, g0, g1, b0, b1, a0, a1])
        }
    }

    /// Kivy-style RGBA tuple string: `(r, g, b, a)` with 4 decimal places.
    public var kivyRGBA: String {
        "(\(r.rounded4), \(g.rounded4), \(b.rounded4), \(alpha.rounded4))"
    }
}

// MARK: - Bounds

/// Absolute on-canvas bounding rectangle
public struct FigmaBounds: Codable, Hashable, Sendable {
    public let x: Double
    public let y: Double
    public let width: Double
    public let height: Double

    public init(x: Double, y: Double, width: Double, height: Double) {
        self.x = x; self.y = y; self.width = width; self.height = height
    }
}

// MARK: - Vector2

/// A 2-D point or offset used in gradients, shadows, etc.
public struct FigmaVector2: Codable, Hashable, Sendable {
    public let x: Double
    public let y: Double

    public init(x: Double, y: Double) { self.x = x; self.y = y }
}

// MARK: - Internal helpers (no Foundation)

extension Comparable {
    func clamped(to range: ClosedRange<Self>) -> Self {
        min(max(self, range.lowerBound), range.upperBound)
    }
}

extension Double {
    /// String representation rounded to 4 decimal places, no Foundation needed.
    var rounded4: String {
        let scaled = (self * 10_000).rounded()
        let int = Int(scaled)
        let whole = int / 10_000
        let frac  = abs(int % 10_000)
        let fracStr = String(frac)
        let padded  = String(repeating: "0", count: 4 - fracStr.count) + fracStr
        return "\(whole).\(padded)"
    }
}
