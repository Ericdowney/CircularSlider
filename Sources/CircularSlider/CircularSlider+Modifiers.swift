
import SwiftUI

extension CircularSlider {
    
    /// Applies the specified color on the background circular slider
    /// - Parameter color: The color to use as the background for the circular slider
    /// - Returns: The modified view
    public func inactive(color: Color) -> CircularSlider {
        CircularSlider(value: value,
                       upperBound: upperBound,
                       inactiveColor: color,
                       activeColor: activeColor,
                       inactiveStrokeStyle: inactiveStrokeStyle,
                       activeStrokeStyle: activeStrokeStyle)
    }
    
    /// Applies the specified color as the foreground to the circular slider
    /// - Parameter color: The color to use as the foreground for the circular slider
    /// - Returns: The modified view
    public func active(color: Color) -> CircularSlider {
        CircularSlider(value: value,
                       upperBound: upperBound,
                       inactiveColor: inactiveColor,
                       activeColor: color,
                       inactiveStrokeStyle: inactiveStrokeStyle,
                       activeStrokeStyle: activeStrokeStyle)
    }
    
    /// Applies the specified stroke style on the background circular slider
    /// - Parameter style: The stroke style to use on the background circular slider
    /// - Returns: The modified view
    public func inactive(stroke style: StrokeStyle) -> CircularSlider {
        CircularSlider(value: value,
                       upperBound: upperBound,
                       inactiveColor: inactiveColor,
                       activeColor: activeColor,
                       inactiveStrokeStyle: style,
                       activeStrokeStyle: activeStrokeStyle)
    }
    
    /// Applies the specified stroke style on the foreground circular slider
    /// - Parameter style: The stroke style to use on the foreground circular slider
    /// - Returns: The modified view
    public func active(stroke style: StrokeStyle) -> CircularSlider {
        CircularSlider(value: value,
                       upperBound: upperBound,
                       inactiveColor: inactiveColor,
                       activeColor: activeColor,
                       inactiveStrokeStyle: inactiveStrokeStyle,
                       activeStrokeStyle: style)
    }
}
