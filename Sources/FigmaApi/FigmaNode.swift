/// Figma document node types, matching the REST API JSON shape.
///
/// Spec: https://www.figma.com/developers/api#node-types

// MARK: - FigmaNodeType

public enum FigmaNodeType: String, Codable, Sendable {
    case document        = "DOCUMENT"
    case canvas          = "CANVAS"
    case frame           = "FRAME"
    case group           = "GROUP"
    case section         = "SECTION"
    case component       = "COMPONENT"
    case componentSet    = "COMPONENT_SET"
    case instance        = "INSTANCE"
    case vector          = "VECTOR"
    case star            = "STAR"
    case line            = "LINE"
    case ellipse         = "ELLIPSE"
    case regularPolygon  = "REGULAR_POLYGON"
    case rectangle       = "RECTANGLE"
    case booleanOperation = "BOOLEAN_OPERATION"
    case text            = "TEXT"
    case textPath        = "TEXT_PATH"
    case slice           = "SLICE"
    case sticky          = "STICKY"
    case connector       = "CONNECTOR"
    case shapeWithText   = "SHAPE_WITH_TEXT"
    case table           = "TABLE"
    case tableCell       = "TABLE_CELL"
    case transformGroup  = "TRANSFORM_GROUP"
    case washiTape       = "WASHI_TAPE"
    case widget          = "WIDGET"
    case embed           = "EMBED"
    case linkUnfurl      = "LINK_UNFURL"
}

// MARK: - EasingType

/// Easing curve applied to a prototype transition animation.
public enum EasingType: String, Codable, Sendable {
    case linear             = "LINEAR"
    case easeIn             = "EASE_IN"
    case easeOut            = "EASE_OUT"
    case easeInAndOut       = "EASE_IN_AND_OUT"
    case easeInBack         = "EASE_IN_BACK"
    case easeOutBack        = "EASE_OUT_BACK"
    case easeInAndOutBack   = "EASE_IN_AND_OUT_BACK"
    case customCubicBezier  = "CUSTOM_CUBIC_BEZIER"
    case gentle             = "GENTLE"
    case quick              = "QUICK"
    case bouncy             = "BOUNCY"
    case slow               = "SLOW"
    case customSpring       = "CUSTOM_SPRING"
}

// MARK: - FigmaFlowStartingPoint

/// Named prototype entry point on a CANVAS node.
public struct FigmaFlowStartingPoint: Codable, Sendable {
    /// Human-readable label for this flow.
    public let name: String
    /// Node ID of the frame that acts as the flow's start screen.
    public let nodeID: String

    private enum CodingKeys: String, CodingKey {
        case name
        case nodeID = "nodeId"
    }
}

// MARK: - FigmaSize

/// Local width and height of a node (not accounting for rotation).
public struct FigmaSize: Codable, Hashable, Sendable {
    public let width: Double
    public let height: Double
}

// MARK: - FigmaArcData

/// Start/end angles and inner radius for ELLIPSE nodes (arcs and donuts).
public struct FigmaArcData: Codable, Hashable, Sendable {
    /// Starting angle in radians.
    public let startingAngle: Double
    /// Ending angle in radians.
    public let endingAngle: Double
    /// Inner radius for donut shapes, in the range 0–1.
    public let innerRadius: Double
}

// MARK: - FigmaIndividualStrokeWeights

/// Per-side stroke widths, used when each side has a different weight.
public struct FigmaIndividualStrokeWeights: Codable, Hashable, Sendable {
    public let top: Double
    public let right: Double
    public let bottom: Double
    public let left: Double
}

// MARK: - FigmaDevStatus

/// Handoff (Dev Mode) status applied to a layer.
public struct FigmaDevStatus: Codable, Sendable {
    /// `"NONE"` | `"READY_FOR_DEV"` | `"COMPLETED"`
    public let type: String
    public let description: String?
}

// MARK: - FigmaShapeType

/// Geometric shape variant for SHAPE_WITH_TEXT nodes.
public enum FigmaShapeType: String, Codable, Sendable {
    case square              = "SQUARE"
    case ellipse             = "ELLIPSE"
    case roundedRectangle    = "ROUNDED_RECTANGLE"
    case diamond             = "DIAMOND"
    case triangleUp          = "TRIANGLE_UP"
    case triangleDown        = "TRIANGLE_DOWN"
    case parallelogramRight  = "PARALLELOGRAM_RIGHT"
    case parallelogramLeft   = "PARALLELOGRAM_LEFT"
    case engDatabase         = "ENG_DATABASE"
    case engQueue            = "ENG_QUEUE"
    case engFile             = "ENG_FILE"
    case engFolder           = "ENG_FOLDER"
    case trapezoid           = "TRAPEZOID"
    case predefinedProcess   = "PREDEFINED_PROCESS"
    case shield              = "SHIELD"
    case documentSingle      = "DOCUMENT_SINGLE"
    case documentMultiple    = "DOCUMENT_MULTIPLE"
    case manualInput         = "MANUAL_INPUT"
    case hexagon             = "HEXAGON"
    case chevron             = "CHEVRON"
    case pentagon            = "PENTAGON"
    case octagon             = "OCTAGON"
    case star                = "STAR"
    case plus                = "PLUS"
    case arrowLeft           = "ARROW_LEFT"
    case arrowRight          = "ARROW_RIGHT"
    case summingJunction     = "SUMMING_JUNCTION"
    case or                  = "OR"
    case speechBubble        = "SPEECH_BUBBLE"
    case internalStorage     = "INTERNAL_STORAGE"
}

// MARK: - FigmaComponentPropertyType

/// Discriminator for component property definitions and overrides.
public enum FigmaComponentPropertyType: String, Codable, Sendable {
    case boolean      = "BOOLEAN"
    case instanceSwap = "INSTANCE_SWAP"
    case text         = "TEXT"
    case variant      = "VARIANT"
}

// MARK: - FigmaComponentPropertyValue

/// A boolean or string value used as a component property default or override.
public enum FigmaComponentPropertyValue: Codable, Sendable, Equatable {
    case bool(Bool)
    case string(String)

    public init(from decoder: Decoder) throws {
        let c = try decoder.singleValueContainer()
        if let b = try? c.decode(Bool.self) {
            self = .bool(b)
        } else {
            self = .string(try c.decode(String.self))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var c = encoder.singleValueContainer()
        switch self {
        case .bool(let b):   try c.encode(b)
        case .string(let s): try c.encode(s)
        }
    }
}

// MARK: - FigmaComponentPropertyDefinition

/// A property defined on a COMPONENT or COMPONENT_SET node.
public struct FigmaComponentPropertyDefinition: Codable, Sendable {
    public let type: FigmaComponentPropertyType
    public let defaultValue: FigmaComponentPropertyValue
    /// All possible variant option strings. Only present when `type == .variant`.
    public let variantOptions: [String]?
}

// MARK: - FigmaComponentProperty

/// A property override on an INSTANCE node, keyed by property name.
public struct FigmaComponentProperty: Codable, Sendable {
    public let type: FigmaComponentPropertyType
    public let value: FigmaComponentPropertyValue
}

// MARK: - FigmaOverrides

/// Records which fields were directly overridden on an INSTANCE node.
public struct FigmaOverrides: Codable, Sendable {
    /// The node ID of the overridden layer.
    public let id: String
    /// The property names that were overridden.
    public let overriddenFields: [String]
}

// MARK: - FigmaNode

/// A single node in the Figma document tree, as returned by `GET /v1/files/:file_key`.
///
/// Uses a flat struct with optional fields because the Figma REST API returns a
/// heterogeneous `type`-discriminated tree. Check `type` to know which optional
/// fields will be present for a given node.
public struct FigmaNode: Codable, Sendable {

    // MARK: IsLayerTrait — present on every node

    /// Unique stable node ID within the document (e.g. `"1:2"`).
    public let id: String
    /// Layer name as shown in the Figma layers panel.
    public let name: String
    /// Node type discriminator.
    public let type: FigmaNodeType
    /// Whether the node is visible on the canvas. Defaults to `true` when absent.
    public let visible: Bool?
    /// Whether the layer is locked and cannot be edited. Defaults to `false` when absent.
    public let locked: Bool?
    /// Whether the node is fixed during scrolling. Deprecated; use `scrollBehavior`.
    public let isFixed: Bool?
    /// Maps layer property name to component property name for component properties attached to this node.
    public let componentPropertyReferences: [String: String]?
    /// How the layer behaves when its parent frame is scrolled.
    /// `"SCROLLS"` | `"FIXED"` | `"STICKY_SCROLLS"`. Defaults to `"SCROLLS"`.
    public let scrollBehavior: String?
    /// Rotation in degrees (CCW positive). Absent when 0.
    public let rotation: Double?
    /// 2D affine transform of this node relative to its parent, as a 2×3 matrix
    /// `[[a, b, tx], [c, d, ty]]`. Present on most layout nodes.
    public let relativeTransform: [[Double]]?
    /// Local (pre-rotation) width and height of the node.
    public let size: FigmaSize?

    // MARK: HasBlendModeAndOpacityTrait — most visible nodes

    public let blendMode: BlendMode?
    /// Layer opacity 0–1. Defaults to `1` when absent.
    public let opacity: Double?

    // MARK: HasChildrenTrait — DOCUMENT, CANVAS, FRAME, GROUP, COMPONENT, INSTANCE, etc.

    public let children: [FigmaNode]?

    // MARK: HasLayoutTrait — most visible nodes

    /// Bounding box in absolute canvas coordinates (origin: top-left of canvas).
    public let absoluteBoundingBox: FigmaBounds?
    /// Actual render bounds, including drop-shadow / thick-stroke overhang.
    /// `null` when the node is invisible.
    public let absoluteRenderBounds: FigmaBounds?
    /// Whether the aspect ratio is locked when resizing.
    public let preserveRatio: Bool?
    /// Layout constraints relative to the containing frame.
    public let constraints: FigmaConstraints?
    /// Alignment within an auto-layout parent.
    /// `"INHERIT"` | `"MIN"` | `"CENTER"` | `"MAX"` | `"STRETCH"`
    public let layoutAlign: String?
    /// Auto-layout grow factor: `0` = fixed size, `1` = fill available space.
    public let layoutGrow: Double?
    /// How the node is positioned. `"AUTO"` | `"ABSOLUTE"`
    public let layoutPositioning: String?
    public let minWidth: Double?
    public let maxWidth: Double?
    public let minHeight: Double?
    public let maxHeight: Double?
    /// Horizontal sizing within an auto-layout parent.
    public let layoutSizingHorizontal: LayoutSizing?
    /// Vertical sizing within an auto-layout parent.
    public let layoutSizingVertical: LayoutSizing?

    // MARK: HasFramePropertiesTrait — FRAME, GROUP, COMPONENT, COMPONENT_SET, INSTANCE

    /// Whether child content is clipped to this node's bounds.
    public let clipsContent: Bool?
    /// Layout guide / grid overlays attached to this frame.
    public let layoutGrids: [FigmaLayoutGrid]?
    /// Primary-axis scrolling direction.
    /// `"HORIZONTAL_SCROLLING"` | `"VERTICAL_SCROLLING"` |
    /// `"HORIZONTAL_AND_VERTICAL_SCROLLING"` | `"NONE"`
    public let overflowDirection: String?
    /// Auto-layout direction: `"NONE"` | `"HORIZONTAL"` | `"VERTICAL"` | `"GRID"`
    public let layoutMode: LayoutMode?
    public let primaryAxisSizingMode: AxisSizingMode?
    public let counterAxisSizingMode: AxisSizingMode?
    public let primaryAxisAlignItems: PrimaryAxisAlignItems?
    public let counterAxisAlignItems: CounterAxisAlignItems?
    /// Alignment of wrapped lines when `layoutWrap == .wrap`.
    /// `"AUTO"` | `"SPACE_BETWEEN"`
    public let counterAxisAlignContent: String?
    public let layoutWrap: LayoutWrap?
    public let paddingLeft: Double?
    public let paddingRight: Double?
    public let paddingTop: Double?
    public let paddingBottom: Double?
    /// Gap between children along the primary axis.
    public let itemSpacing: Double?
    /// Gap between rows / columns when layout wraps.
    public let counterAxisSpacing: Double?
    public let itemReverseZIndex: Bool?
    public let strokesIncludedInLayout: Bool?
    /// Number of columns this node spans inside a GRID-mode parent. Default 1.
    public let gridColumnSpan: Int?
    /// Number of rows this node spans inside a GRID-mode parent. Default 1.
    public let gridRowCount: Int?
    /// Column index this node anchors to inside a GRID-mode parent. Default 0.
    public let gridColumnAnchorIndex: Int?
    /// Row index this node anchors to inside a GRID-mode parent. Default 0.
    public let gridRowAnchorIndex: Int?

    // MARK: MinimalFillsTrait + MinimalStrokesTrait

    /// Maps `FigmaStyleType` raw value (e.g. `"fill"`, `"stroke"`, `"text"`, `"effect"`,
    /// `"grid"`) to the style ID. Cross-reference with `FigmaFileResponse.styles`.
    public let styles: [String: String]?
    /// Fill paints applied to this node (ordered bottom to top).
    public let fills: [FigmaPaint]?
    /// Stroke paints applied to this node.
    public let strokes: [FigmaPaint]?

    // MARK: HasGeometryTrait — stroke / path details

    /// Uniform stroke weight. Use `individualStrokeWeights` when sides differ.
    public let strokeWeight: Double?
    public let strokeAlign: StrokeAlign?
    public let strokeCap: StrokeCap?
    public let strokeJoin: StrokeJoin?
    /// Dash pattern: alternating dash length, gap length (in px).
    public let strokeDashes: [Double]?
    /// Miter angle below which the join falls back to bevel (degrees). Default 28.96.
    public let strokeMiterAngle: Double?
    /// Per-side stroke weights, present when sides differ.
    public let individualStrokeWeights: FigmaIndividualStrokeWeights?

    // MARK: CornerTrait — FRAME, COMPONENT, RECTANGLE, and some others

    /// Uniform corner radius. Use `rectangleCornerRadii` when corners differ.
    public let cornerRadius: Double?
    /// Per-corner radii: [top-left, top-right, bottom-right, bottom-left].
    public let rectangleCornerRadii: [Double]?
    /// Corner smoothing factor 0–1. `0` = circular arc; `0.6` ≈ iOS 7 squircle.
    public let cornerSmoothing: Double?

    // MARK: HasEffectsTrait

    public let effects: [FigmaEffect]?

    // MARK: HasExportSettingsTrait

    public let exportSettings: [FigmaExportSetting]?

    // MARK: HasMaskTrait

    public let isMask: Bool?
    /// `"ALPHA"` | `"VECTOR"` | `"LUMINANCE"`
    public let maskType: String?

    // MARK: TransitionSourceTrait — prototyping

    /// ID of the node to transition to.
    public let transitionNodeID: String?
    /// Duration of the prototyping transition in milliseconds.
    public let transitionDuration: Double?
    /// Easing curve applied to the prototyping transition.
    public let transitionEasing: EasingType?

    // MARK: TypePropertiesTrait — TEXT nodes

    /// Raw characters in the text node.
    public let characters: String?
    /// Typography style for the entire text node.
    public let style: FigmaTypeStyle?
    /// Per-character style overrides; each value indexes into `styleOverrideTable`.
    public let characterStyleOverrides: [Int]?
    /// Map from override index → `FigmaTypeStyle`.
    public let styleOverrideTable: [String: FigmaTypeStyle]?
    /// List type per line: `"NONE"` | `"ORDERED"` | `"UNORDERED"`.
    public let lineTypes: [String]?
    /// Indentation level per line.
    public let lineIndentations: [Double]?

    // MARK: InstanceNode

    /// ID of the main component this instance was created from.
    public let componentId: String?
    /// Whether this instance is exposed to its containing component or component set.
    public let isExposedInstance: Bool?
    /// IDs of instances that have been exposed to this node's level.
    public let exposedInstances: [String]?
    /// Component property overrides for this instance, keyed by property name.
    public let componentProperties: [String: FigmaComponentProperty]?
    /// Fields directly overridden on this instance (inherited overrides not included).
    public let overrides: [FigmaOverrides]?

    // MARK: ComponentPropertiesTrait — COMPONENT and COMPONENT_SET nodes

    /// Component property definitions, keyed by property name.
    public let componentPropertyDefinitions: [String: FigmaComponentPropertyDefinition]?

    // MARK: BooleanOperationNode

    /// `"UNION"` | `"INTERSECT"` | `"SUBTRACT"` | `"EXCLUDE"`
    public let booleanOperation: String?

    // MARK: CanvasNode (pages)

    /// Background colour of the canvas (page).
    public let backgroundColor: FigmaColor?
    /// Node ID of the prototype start frame. Deprecated; prefer `flowStartingPoints`.
    public let prototypeStartNodeID: String?
    /// Named prototype entry points on this page.
    public let flowStartingPoints: [FigmaFlowStartingPoint]?

    // MARK: EllipseNode

    public let arcData: FigmaArcData?

    // MARK: StickyNode

    /// Whether the author name is shown on the sticky note.
    public let authorVisible: Bool?

    // MARK: ShapeWithTextNode

    /// Geometric shape variant. Most names match their tooltip; see `FigmaShapeType` for exceptions.
    public let shapeType: FigmaShapeType?

    // MARK: SectionNode

    public let sectionContentsHidden: Bool?

    // MARK: DevStatusTrait

    public let devStatus: FigmaDevStatus?

    // MARK: - Convenience

    public var isVisible: Bool { visible ?? true }
    public var effectiveOpacity: Double { opacity ?? 1.0 }
    public var effectiveRotation: Double { rotation ?? 0.0 }
}
