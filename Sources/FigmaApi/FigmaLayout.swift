/// Auto-layout and layout grid types.

// MARK: - LayoutMode

public enum LayoutMode: String, Codable, Sendable {
    case none       = "NONE"
    case horizontal = "HORIZONTAL"
    case vertical   = "VERTICAL"
    case grid       = "GRID"
}

// MARK: - LayoutSizing

public enum LayoutSizing: String, Codable, Sendable {
    case fixed = "FIXED"
    case fill  = "FILL"
    case hug   = "HUG"
}

// MARK: - LayoutWrap

public enum LayoutWrap: String, Codable, Sendable {
    case noWrap = "NO_WRAP"
    case wrap   = "WRAP"
}

// MARK: - PrimaryAxisAlignItems / CounterAxisAlignItems

public enum PrimaryAxisAlignItems: String, Codable, Sendable {
    case min          = "MIN"
    case center       = "CENTER"
    case max          = "MAX"
    case spaceBetween = "SPACE_BETWEEN"
}

public enum CounterAxisAlignItems: String, Codable, Sendable {
    case min      = "MIN"
    case center   = "CENTER"
    case max      = "MAX"
    case baseline = "BASELINE"
}

// MARK: - PrimaryAxisSizingMode / CounterAxisSizingMode

public enum AxisSizingMode: String, Codable, Sendable {
    case fixed = "FIXED"
    case auto  = "AUTO"
}

// MARK: - LayoutGrid

public enum GridPattern: String, Codable, Sendable {
    case columns = "COLUMNS"
    case rows    = "ROWS"
    case grid    = "GRID"
}

/// A layout guide/grid attached to a frame (columns, rows, or fine grid).
public struct FigmaLayoutGrid: Codable, Sendable {
    /// Pattern type
    public let pattern: GridPattern

    /// Cell/gutter size in pixels (GRID pattern), or column/row size (COLUMNS/ROWS)
    public let sectionSize: Double?

    /// Number of columns or rows (COLUMNS / ROWS patterns)
    public let count: Int?

    /// Gutter size between tracks (COLUMNS / ROWS)
    public let gutterSize: Double?

    /// Offset from the edge of the frame
    public let offset: Double?

    /// Grid alignment: "MIN" | "CENTER" | "MAX" | "STRETCH"
    public let alignment: String?

    /// RGBA colour of the guide overlay
    public let color: FigmaColor?

    /// Whether the grid is visible in editor
    public let visible: Bool?
}

// MARK: - Constraints

public enum ConstraintType: String, Codable, Sendable {
    case left        = "LEFT"
    case right       = "RIGHT"
    case center      = "CENTER"
    case leftRight   = "LEFT_RIGHT"
    case scale       = "SCALE"
    case top         = "TOP"
    case bottom      = "BOTTOM"
    case topBottom   = "TOP_BOTTOM"
    // Plugin API aliases
    case min         = "MIN"
    case max         = "MAX"
    case stretch     = "STRETCH"
}

public struct FigmaConstraints: Codable, Sendable {
    public let horizontal: ConstraintType
    public let vertical: ConstraintType
}
