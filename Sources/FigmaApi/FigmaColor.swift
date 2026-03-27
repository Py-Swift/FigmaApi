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

    /// Kivy-style RGBA tuple string: ``(r, g, b, a)``
    public var kivyRGBA: String {
        String(format: "(%.4f, %.4f, %.4f, %.4f)", r, g, b, alpha)
    }

    /// CSS-style #RRGGBB hex string (ignores alpha)
    public var cssHex: String {
        let ri = Int((r * 255).rounded())
        let gi = Int((g * 255).rounded())
        let bi = Int((b * 255).rounded())
        return String(format: "#%02x%02x%02x", ri, gi, bi)
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
