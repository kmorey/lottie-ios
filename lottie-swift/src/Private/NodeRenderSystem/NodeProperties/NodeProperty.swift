//
//  NodeProperty.swift
//  lottie-swift
//
//  Created by Brandon Withrow on 1/30/19.
//

import Foundation
import CoreGraphics

/// A node property that holds a reference to a T ValueProvider and a T ValueContainer.
class NodeProperty<T>: AnyNodeProperty {
  
  var valueType: Any.Type { return T.self }
  
  var value: T {
    return typedContainer.outputValue
  }
  
  var valueContainer: AnyValueContainer {
    return typedContainer
  }

  var valueProvider: AnyValueProvider

  var valueFilterProvider: AnyValueFilterProvider?
  
  init(provider: AnyValueProvider) {
    self.valueProvider = provider
    self.typedContainer = ValueContainer<T>(provider.value(frame: 0) as! T)
    self.typedContainer.setNeedsUpdate()
  }
  
  func needsUpdate(frame: CGFloat) -> Bool {
    return valueContainer.needsUpdate || valueProvider.hasUpdate(frame: frame)
  }
  
  func setProvider(provider: AnyValueProvider) {
    guard provider.valueType == valueType else { return }
    self.valueProvider = provider
    valueContainer.setNeedsUpdate()
  }

  /// Sets the value filter provider for the property.
  func setFilterProvider(provider: AnyValueFilterProvider) {
    guard provider.valueType == valueType else { return }
    self.valueFilterProvider = provider
    valueContainer.setNeedsUpdate()
  }
  
  func update(frame: CGFloat) {
    var value = valueProvider.value(frame: frame)
    if let valueFilterProvider = valueFilterProvider {
        value = valueFilterProvider.value(value: value, frame: frame)
    }
    typedContainer.setValue(value, forFrame: frame)
  }
  
  fileprivate var typedContainer: ValueContainer<T>
}
