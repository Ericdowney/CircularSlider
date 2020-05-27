
import Foundation
import UIKit
import SwiftUI

/// A circular slider view allowing users to input values between zero and the upper limit.
public struct CircularSlider: View {
    private enum PathType {
        case start, end
    }
    
    // MARK: - Properties
    
    public var body: some View { viewBody() }
    
    var value: Binding<Double>
    var upperBound: Double
    var inactiveColor: Color = Color(UIColor.tertiarySystemBackground)
    var activeColor: Color = Color.blue
    var inactiveStrokeStyle: StrokeStyle = .init(lineWidth: 32.0, lineCap: .round)
    var activeStrokeStyle: StrokeStyle = .init(lineWidth: 32.0, lineCap: .round)
    
    // MARK: - Lifecycle
    
    public init(value: Binding<Double>, upperBound: Double) {
        self.value = value
        self.upperBound = upperBound + 1
    }
    
    init(value: Binding<Double>,
         upperBound: Double,
         inactiveColor: Color,
         activeColor: Color,
         inactiveStrokeStyle: StrokeStyle,
         activeStrokeStyle: StrokeStyle) {
        self.value = value
        self.upperBound = upperBound + 1
        self.inactiveColor = inactiveColor
        self.activeColor = activeColor
        self.inactiveStrokeStyle = inactiveStrokeStyle
        self.activeStrokeStyle = activeStrokeStyle
    }
    
    // MARK: - Methods
    
    private func viewBody() -> some View {
        GeometryReader { geometry in
            ZStack {
                self.arcPath(for: .start, geometry)
                    .stroke(style: self.inactiveStrokeStyle)
                    .foregroundColor(self.inactiveColor)
                
                self.arcPath(for: .end, geometry)
                    .stroke(style: self.activeStrokeStyle)
                    .foregroundColor(self.activeColor)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .gesture(DragGesture(minimumDistance: 1.0, coordinateSpace: .local).onChanged { value in
                self.updateValue(with: value, radius: geometry.size.height / 2.0)
            })
        }
    }
    
    private func arcPath(for type: PathType, _ geometry: GeometryProxy) -> Path {
        Path(UIBezierPath(arcCenter: arcCenter(for: geometry),
                          radius: geometry.size.height / 2.0,
                          startAngle: startAngle(for: type),
                          endAngle: endAngle(for: type, geometry: geometry),
                          clockwise: true).cgPath)
    }
    
    private func arcCenter(for geometry: GeometryProxy) -> CGPoint {
        .init(x: geometry.size.width / 2.0, y: geometry.size.height / 2.0)
    }
    
    private func startAngle(for type: PathType) -> CGFloat {
        type == .start ? .pi / 2.0 : .pi * 1.5
    }
    
    private func endAngle(for type: PathType, geometry: GeometryProxy) -> CGFloat {
        let startEndAngle: CGFloat = (.pi / 2.0) + (2.0 * .pi)
        let endEndAngle: CGFloat = (CGFloat(self.value.wrappedValue) / CGFloat(self.upperBound) * 2.0 * .pi) - (.pi / 2.0)
        return type == .start ? startEndAngle : endEndAngle
    }
    
    private func updateValue(with dragValue: DragGesture.Value, radius: CGFloat) {
        let vector = CGVector(dx: dragValue.location.x - radius, dy: dragValue.location.y - radius)
        let angle = atan2(vector.dy, vector.dx) + .pi / 2.0
        let fixedAngle = angle < 0.0 ? angle + 2.0 * .pi : angle
        value.wrappedValue = Double(Int(max(0, fixedAngle / (2.0 * .pi) * CGFloat(upperBound))))
    }
}

struct CircularSliderView_Previews: PreviewProvider {
    static var previews: some View {
        CircularSlider(value: .constant(40.0), upperBound: 80.0)
            .frame(height: 250.0)
    }
}
