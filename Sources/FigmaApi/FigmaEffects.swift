/// Visual effects (shadows, blurs).

// MARK: - EffectType

public enum EffectType: String, Codable, Sendable {
    case innerShadow       = "INNER_SHADOW"
    case dropShadow        = "DROP_SHADOW"
    case layerBlur         = "LAYER_BLUR"
    case backgroundBlur    = "BACKGROUND_BLUR"
    case texture           = "TEXTURE"
    case noise             = "NOISE"
}

// MARK: - BlendMode

public enum BlendMode: String, Codable, Sendable {
    case passThrough  = "PASS_THROUGH"
    case normal       = "NORMAL"
    case darken       = "DARKEN"
    case multiply     = "MULTIPLY"
    case linearBurn   = "LINEAR_BURN"
    case colorBurn    = "COLOR_BURN"
    case lighten      = "LIGHTEN"
    case screen       = "SCREEN"
    case linearDodge  = "LINEAR_DODGE"
    case colorDodge   = "COLOR_DODGE"
    case overlay      = "OVERLAY"
    case softLight    = "SOFT_LIGHT"
    case hardLight    = "HARD_LIGHT"
    case difference   = "DIFFERENCE"
    case exclusion    = "EXCLUSION"
    case hue          = "HUE"
    case saturation   = "SATURATION"
    case color        = "COLOR"
    case luminosity   = "LUMINOSITY"
}

// MARK: - Effect

public struct FigmaEffect: Codable, Sendable {
    /// Effect category
    public let type: EffectType

    /// Whether this effect is applied. Defaults to `true` when absent.
    public let visible: Bool?

    /// Effect-level opacity / strength modifier
    public let radius: Double?

    // DROP_SHADOW / INNER_SHADOW fields
    public let color: FigmaColor?
    public let blendMode: BlendMode?
    /// Shadow offset
    public let offset: FigmaVector2?
    /// Shadow spread (positive = expand, negative = shrink)
    public let spread: Double?
    /// Whether shadow uses "show shadow behind transparent areas"
    public let showShadowBehindNode: Bool?

    // MARK: TEXTURE effect fields

    /// Size of the texture. Present when `type == .texture`.
    public let noiseSize: Double?
    /// Whether the texture is clipped to the node shape. Present when `type == .texture`.
    public let clipToShape: Bool?

    // MARK: NOISE effect fields

    /// Density of the noise effect, 0–1. Present when `type == .noise`.
    public let density: Double?

    public var isVisible: Bool { visible ?? true }
}

// MARK: - ExportSetting

public enum ExportFormat: String, Codable, Sendable {
    case jpg = "JPG"
    case png = "PNG"
    case svg = "SVG"
    case pdf = "PDF"
}

/// Sizing constraint attached to an export setting.
public struct FigmaExportConstraint: Codable, Sendable {
    /// `"SCALE"` | `"WIDTH"` | `"HEIGHT"`
    public let type: String
    /// Scale factor (SCALE) or target dimension in px (WIDTH / HEIGHT).
    public let value: Double
}

public struct FigmaExportSetting: Codable, Sendable {
    public let format: ExportFormat
    public let suffix: String
    public let constraint: FigmaExportConstraint
}
