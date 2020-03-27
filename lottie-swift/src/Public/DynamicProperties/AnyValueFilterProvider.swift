import Foundation
import CoreGraphics

/**
 `AnyValueFilterProvider` is a protocol that filters animation data for a property at a
 given time.
 */
public protocol AnyValueFilterProvider {
    /// The Type of the value provider
    var valueType: Any.Type { get }

    /// Asks the provider to update the container with its value for the frame.
    func value(value: Any, frame: AnimationFrameTime) -> Any
}
