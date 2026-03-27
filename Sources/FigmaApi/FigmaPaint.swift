/// Fill and stroke paints.

// MARK: - PaintType

public enum PaintType: String, Codable, Sendable {
    case solid           = "SOLID"
    case gradientLinear  = "GRADIENT_LINEAR"
    case gradientRadial  = "GRADIENT_RADIAL"
    case gradientAngular = "GRADIENT_ANGULAR"
    case gradientDiamond = "GRADIENT_DIAMOND"
    case image           = "IMAGE"
    case pattern         = "PATTERN"
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

// MARK: - ImageFilters

/// Per-channel image adjustments applied to an IMAGE paint.
public struct FigmaImageFilters: Codable, Sendable {
    public let exposure: Double?
    public let contrast: Double?
    public let saturation: Double?
    public let temperature: Double?
    public let tint: Double?
    public let highlights: Double?
    public let shadows: Double?
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

    /// Blend mode for this paint layer.
    public let blendMode: BlendMode?

    // MARK: IMAGE fields
    /// Image hash from Figma assets API
    public let imageRef: String?
    /// How the image is scaled inside its container
    public let scaleMode: ScaleMode?
    /// Image transform matrix when scaleMode == TILE or CROP
    public let imageTransform: [[Double]]?
    /// Tile scale factor (scaleMode == TILE only)
    public let scalingFactor: Double?
    /// Image rotation in degrees.
    public let rotation: Double?
    /// Image filters (exposure, contrast, saturation, etc.) applied to an IMAGE paint.
    public let filters: FigmaImageFilters?
    /// Reference to an animated GIF embedded in an IMAGE paint.
    public let gifRef: String?

    // MARK: PATTERN fields
    /// Node ID of the source node used as the pattern tile.
    public let sourceNodeId: String?
    /// Tiling arrangement. `"RECTANGULAR"` | `"HORIZONTAL_HEXAGONAL"` | `"VERTICAL_HEXAGONAL"`
    public let tileType: String?
    /// Per-axis spacing between pattern tiles.
    public let spacing: FigmaVector2?
    /// Horizontal alignment within a tile. `"START"` | `"CENTER"` | `"END"`
    public let horizontalAlignment: String?
    /// Vertical alignment within a tile. `"START"` | `"CENTER"` | `"END"`
    public let verticalAlignment: String?

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
    case triangleFilled   = "TRIANGLE_FILLED"
    case circleFilled     = "CIRCLE_FILLED"
    case diamondFilled    = "DIAMOND_FILLED"
    case washiTape1       = "WASHI_TAPE_1"
    case washiTape2       = "WASHI_TAPE_2"
    case washiTape3       = "WASHI_TAPE_3"
    case washiTape4       = "WASHI_TAPE_4"
    case washiTape5       = "WASHI_TAPE_5"
    case washiTape6       = "WASHI_TAPE_6"
}

public enum StrokeJoin: String, Codable, Sendable {
    case miter = "MITER"
    case bevel = "BEVEL"
    case round = "ROUND"
}
