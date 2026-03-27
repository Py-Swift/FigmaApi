/// Typography / text-style types used in TEXT nodes.
///
/// Corresponds to `TypeStyle` in the Figma REST API OpenAPI spec.

// MARK: - FigmaHyperlink

/// A link to a URL or another node, embedded in a text run.
public struct FigmaHyperlink: Codable, Sendable {
    /// `"URL"` | `"NODE"`
    public let type: String
    /// Target URL when `type == "URL"`.
    public let url: String?
    /// Target node ID when `type == "NODE"`.
    public let nodeID: String?
}

// MARK: - FigmaTypeStyle

/// Full typography properties for a text node or a character-range override.
///
/// Merges `BaseTypeStyle` and `TypeStyle` from the Figma REST API spec.
public struct FigmaTypeStyle: Codable, Sendable {

    // MARK: Font identity

    /// Font family name (e.g. `"Inter"`).
    public let fontFamily: String?
    /// PostScript font name (e.g. `"Inter-Bold"`). `null` when the font has no PS name.
    public let fontPostScriptName: String?
    /// Human-readable weight/style string (e.g. `"Bold Italic"`).
    public let fontStyle: String?
    /// Whether the text is rendered italic.
    public let italic: Bool?
    /// Numeric font weight (100–900).
    public let fontWeight: Double?
    /// Font size in points/px.
    public let fontSize: Double?

    // MARK: Case / decoration

    /// Text casing.
    /// `"ORIGINAL"` | `"UPPER"` | `"LOWER"` | `"TITLE"` |
    /// `"SMALL_CAPS"` | `"SMALL_CAPS_FORCED"`
    public let textCase: String?
    /// Text decoration. `"NONE"` | `"STRIKETHROUGH"` | `"UNDERLINE"`
    public let textDecoration: String?

    // MARK: Alignment

    /// Horizontal alignment. `"LEFT"` | `"RIGHT"` | `"CENTER"` | `"JUSTIFIED"`
    public let textAlignHorizontal: String?
    /// Vertical alignment. `"TOP"` | `"CENTER"` | `"BOTTOM"`
    public let textAlignVertical: String?

    // MARK: Spacing

    /// Letter-spacing in px.
    public let letterSpacing: Double?
    /// Space between paragraphs in px. Defaults to `0`.
    public let paragraphSpacing: Double?
    /// Paragraph indentation in px. Defaults to `0`.
    public let paragraphIndent: Double?
    /// Space between list items in px. Defaults to `0`.
    public let listSpacing: Double?

    // MARK: Line height

    /// Absolute line height in px.
    public let lineHeightPx: Double?
    /// Line height as a ratio of the font's default line height (100 = normal).
    public let lineHeightPercent: Double?
    /// Line height as a percentage of font size (only when `lineHeightUnit == "FONT_SIZE_%"`).
    public let lineHeightPercentFontSize: Double?
    /// Line height unit. `"PIXELS"` | `"FONT_SIZE_%"` | `"INTRINSIC_%"`
    public let lineHeightUnit: String?

    // MARK: Auto-resize

    /// How the text box resizes to fit its content.
    /// `"NONE"` | `"HEIGHT"` | `"WIDTH_AND_HEIGHT"` | `"TRUNCATE"`
    public let textAutoResize: String?
    /// Whether trailing text is replaced with an ellipsis when it overflows.
    /// `"DISABLED"` | `"ENDING"`
    public let textTruncation: String?
    /// Maximum lines before truncation applies (when `textTruncation == "ENDING"`).
    public let maxLines: Int?

    // MARK: Style-override metadata

    /// Whether this style contains overrides over a linked text style.
    /// When `true`, `semanticWeight`, `semanticItalic`, `hyperlink`, and `textDecoration`
    /// are overrides rather than base values.
    public let isOverrideOverTextStyle: Bool?
    /// Indicates how font weight was overridden. `"BOLD"` | `"NORMAL"`
    public let semanticWeight: String?
    /// Indicates how font style was overridden. `"ITALIC"` | `"NORMAL"`
    public let semanticItalic: String?

    // MARK: Fill & link

    /// Fill paints applied to the characters (overrides the node-level fills for text).
    public let fills: [FigmaPaint]?
    /// Hyperlink attached to this text run.
    public let hyperlink: FigmaHyperlink?

    // MARK: OpenType

    /// OpenType feature flags: feature name → `1` (on) or `0` (off).
    public let opentypeFlags: [String: Int]?
}
