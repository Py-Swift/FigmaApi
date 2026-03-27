/// Fill and stroke paints.

// MARK: - PaintType

public enum PaintType: String, Codable, Sendable {
    case solid           = "SOLID"
    case gradientLinear  = "GRADIENT_LINEAR"
    case gradientRadial  = "GRADIENT_RADIAL"
    case gradientAngular = "GRADIENT_ANGULAR"
    case gradientDiamond = "GRADIENT_DIAMOND"
    case image           = "IMAGE"
    case emoji           = "EMOJI"
    case video           = "VIDEO"
}

// MARK: - ScaleMode (for IMAGE paints)

public enum ScaleMode: String, Codable, Sendable {
    case fill    = "FILL"
    case fit     = "FIT"
    case tile    = "TILE"
    case stretch = "STRETCH"
    case crop    = "CROP"
}

// MARK: - GradientStop

public struct FigmaGradientStop: Codable, Hashable, Sendable {
    public let color: FigmaColor
    /// Position along the gradient: 0.0 (start) … 1.0 (end)
    public let position: Double
}

// MARK: - Paint

/// A single paint layer in a fills or strokes array.
public struct FigmaPaint: Codable, Sendable {
    /// Paint type identifier
    public let type: PaintType

    /// Whether the paint is visible. Defaults to `true` when absent.
    public let visible: Bool?

    /// Opacity of this paint layer (0-1). Distinct from node-level opacity.
    public let opacity: Double?

    // MARK: SOLID fields
    /// RGBA colour for SOLID paints
    public let color: FigmaColor?

    // MARK: Gradient fields
    /// Gradient handle positions (3 control points)
    public let gradientHandlePositions: [FigmaVector2]?
    /// Colour stops defining the gradient
    public let gradientStops: [FigmaGradientStop]?

    // MARK: IMAGE fields
    /// Image hash from Figma assets API
    public let imageRef: String?
    /// How the image is scaled inside its container
    public let scaleMode: ScaleMode?
    /// Image transform matrix when scaleMode == TILE or CROP
    public let imageTransform: [[Double]]?
    /// Tile scale factor (scaleMode == TILE only)
    public let scalingFactor: Double?

    public var isVisible: Bool { visible ?? true }
    public var effectiveOpacity: Double { opacity ?? 1.0 }
}

// MARK: - StrokeAlign

public enum StrokeAlign: String, Codable, Sendable {
    case inside  = "INSIDE"
    case outside = "OUTSIDE"
    case center  = "CENTER"
}

// MARK: - StrokeCap / StrokeJoin

public enum StrokeCap: String, Codable, Sendable {
    case none             = "NONE"
    case round            = "ROUND"
    case square           = "SQUARE"
    case lineArrow        = "LINE_ARROW"
    case triangleArrow    = "TRIANGLE_ARROW"
    case circleFilled     = "CIRCLE_FILLED"
    case diamondFilled    = "DIAMOND_FILLED"
}

public enum StrokeJoin: String, Codable, Sendable {
    case miter = "MITER"
    case bevel = "BEVEL"
    case round = "ROUND"
}
