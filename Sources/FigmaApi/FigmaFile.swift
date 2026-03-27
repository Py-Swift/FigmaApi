/// Top-level Figma REST API file response and associated metadata types.
///
/// Endpoint: `GET https://api.figma.com/v1/files/:file_key`

// MARK: - FigmaDocumentationLink

/// A documentation link attached to a component or component set.
public struct FigmaDocumentationLink: Codable, Sendable {
    public let uri: String
}

// MARK: - FigmaComponent

/// Metadata for a main component, keyed by node ID in `FigmaFileResponse.components`.
public struct FigmaComponent: Codable, Sendable {
    /// Stable publish key for this component.
    public let key: String
    public let name: String
    public let description: String
    /// ID of the parent component set, if any.
    public let componentSetId: String?
    public let documentationLinks: [FigmaDocumentationLink]
    /// Whether this component is from a remote (external) library.
    public let remote: Bool
}

// MARK: - FigmaComponentSet

/// Metadata for a component set, keyed by node ID in `FigmaFileResponse.componentSets`.
public struct FigmaComponentSet: Codable, Sendable {
    public let key: String
    public let name: String
    public let description: String
    public let documentationLinks: [FigmaDocumentationLink]
    public let remote: Bool
}

// MARK: - FigmaStyleType

public enum FigmaStyleType: String, Codable, Sendable {
    case fill   = "FILL"
    case text   = "TEXT"
    case effect = "EFFECT"
    case grid   = "GRID"
}

// MARK: - FigmaPublishedStyle

/// Metadata for a published style, keyed by style ID in `FigmaFileResponse.styles`.
public struct FigmaPublishedStyle: Codable, Sendable {
    /// Stable publish key for this style.
    public let key: String
    public let name: String
    public let description: String?
    public let styleType: FigmaStyleType?
    /// Whether this style is from a remote (external) library.
    public let remote: Bool?
}

// MARK: - FigmaFileBranch

/// Summary of a branch that diverges from (and can be merged back into) the main file.
public struct FigmaFileBranch: Codable, Sendable {
    public let key: String
    public let name: String
    public let thumbnailUrl: String
    /// UTC ISO 8601 timestamp of last modification.
    public let lastModified: String

    private enum CodingKeys: String, CodingKey {
        case key, name
        case thumbnailUrl = "thumbnail_url"
        case lastModified = "last_modified"
    }
}

// MARK: - FigmaFileResponse

/// The top-level response body from `GET /v1/files/:file_key`.
///
/// ```swift
/// let data = try Data(contentsOf: responseURL)
/// let file = try JSONDecoder().decode(FigmaFileResponse.self, from: data)
/// let pages = file.document.children ?? []
/// ```
public struct FigmaFileResponse: Codable, Sendable {
    /// File name as shown in the Figma editor.
    public let name: String
    /// Authenticated user's role: `"owner"` | `"editor"` | `"viewer"`.
    public let role: String?
    /// UTC ISO 8601 timestamp of the last modification.
    public let lastModified: String
    /// Editor product: `"figma"` | `"figjam"`.
    public let editorType: String
    /// URL of the file thumbnail image.
    public let thumbnailUrl: String?
    /// Monotonically increasing version string.
    public let version: String

    /// The root `DOCUMENT` node. Its children are `CANVAS` (page) nodes.
    public let document: FigmaNode

    /// All main components in the file, keyed by node ID.
    public let components: [String: FigmaComponent]
    /// All component sets in the file, keyed by node ID.
    public let componentSets: [String: FigmaComponentSet]
    /// All published styles in the file, keyed by style ID.
    public let styles: [String: FigmaPublishedStyle]

    /// File schema version.
    public let schemaVersion: Int

    /// Link share permission level.
    public let linkAccess: String?
    /// Key of the main file when this response is for a branch component.
    public let mainFileKey: String?
    /// Branches of this file, if any.
    public let branches: [FigmaFileBranch]?
}
