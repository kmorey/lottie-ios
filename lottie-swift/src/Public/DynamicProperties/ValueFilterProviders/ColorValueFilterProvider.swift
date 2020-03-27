import Foundation
import CoreGraphics

/// A `ValueFilterProvider` that returns a CGColor Value
public final class ColorValueFilterProvider: AnyValueFilterProvider {
    /// Returns a Color for a CGColor(Frame Time)
    public typealias ColorValueFilterBlock = (Color, CGFloat) -> Color
    
    /// Initializes with a block provider
    public init(block: @escaping ColorValueFilterBlock) {
        self.block = block
    }
    
    // MARK: ValueProvider Protocol
    
    public var valueType: Any.Type {
        return Color.self
    }
    
    public func value(value color: Any, frame: CGFloat) -> Any {
        return block(color as! Color, frame)
    }
    
    // MARK: Private

    private var block: ColorValueFilterBlock
}
