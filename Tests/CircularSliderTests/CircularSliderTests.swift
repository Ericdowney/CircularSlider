
import XCTest
import SwiftUI
import ViewInspector
@testable import CircularSlider

final class CircularSliderTests: XCTestCase {
    
    let currentValue: Double = 4.0
    let upperBound: Double = 24.0
    
    // MARK: - Tests
    
    func test_init_shouldbeConfiguredCorrectly() throws {
        let value: Binding<Double> = .init(get: { self.currentValue }, set: { _ in })
        
        let subject = CircularSlider(value: value, upperBound: upperBound)
        
        let zStack = try subject.inspect().geometryReader().zStack()
        let backgroundPath = try zStack.shape(0)
        let foregroundPath = try zStack.shape(1)
        
        XCTAssertEqual(subject.value.wrappedValue, currentValue)
        XCTAssertEqual(subject.upperBound, upperBound + 1.0)
        
        XCTAssertEqual(try zStack.fixedFrame().width, 0.0)
        XCTAssertEqual(try zStack.fixedFrame().height, 0.0)
        
        XCTAssertEqual(try backgroundPath.strokeStyle().lineWidth, 32.0)
        XCTAssertEqual(try backgroundPath.strokeStyle().lineCap, .round)
        
        XCTAssertEqual(try foregroundPath.strokeStyle().lineWidth, 32.0)
        XCTAssertEqual(try foregroundPath.strokeStyle().lineCap, .round)
    }
    
    func test_inactiveColor_shouldSetInactiveColor() {
        let value: Binding<Double> = .init(get: { self.currentValue }, set: { _ in })
        var subject = CircularSlider(value: value, upperBound: upperBound)
        
        XCTAssertEqual(subject.inactiveColor, Color(UIColor.tertiarySystemBackground))
        
        subject = subject.inactive(color: .yellow)
        
        XCTAssertEqual(subject.inactiveColor, .yellow)
    }
    
    func test_inactiveStrokeStyle_shouldSetInactiveStrokeStyle() {
        let value: Binding<Double> = .init(get: { self.currentValue }, set: { _ in })
        let baselineStrokeStyle = StrokeStyle(lineWidth: 32.0, lineCap: .round)
        let expectedStrokeStyle = StrokeStyle(lineWidth: 16.0, lineCap: .butt, lineJoin: .bevel)
        var subject = CircularSlider(value: value, upperBound: upperBound)
        
        XCTAssertEqual(subject.inactiveStrokeStyle, baselineStrokeStyle)
        
        subject = subject.inactive(stroke: expectedStrokeStyle)
        
        XCTAssertEqual(subject.inactiveStrokeStyle, expectedStrokeStyle)
    }
    
    func test_activeColor_shouldSetActiveColor() {
        let value: Binding<Double> = .init(get: { self.currentValue }, set: { _ in })
        var subject = CircularSlider(value: value, upperBound: upperBound)
        
        XCTAssertEqual(subject.activeColor, Color.blue)
        
        subject = subject.active(color: .yellow)
        
        XCTAssertEqual(subject.activeColor, .yellow)
    }
    
    func test_activeStrokeStyle_shouldSetActiveStrokeStyle() {
        let value: Binding<Double> = .init(get: { self.currentValue }, set: { _ in })
        let baselineStrokeStyle = StrokeStyle(lineWidth: 32.0, lineCap: .round)
        let expectedStrokeStyle = StrokeStyle(lineWidth: 16.0, lineCap: .butt, lineJoin: .bevel)
        var subject = CircularSlider(value: value, upperBound: upperBound)
        
        XCTAssertEqual(subject.activeStrokeStyle, baselineStrokeStyle)
        
        subject = subject.active(stroke: expectedStrokeStyle)
        
        XCTAssertEqual(subject.activeStrokeStyle, expectedStrokeStyle)
    }
    
    // MARK: - Test Registration

    static var allTests = [
        ("test_init_shouldbeConfiguredCorrectly", test_init_shouldbeConfiguredCorrectly),
        ("test_inactiveColor_shouldSetInactiveColor", test_inactiveColor_shouldSetInactiveColor),
        ("test_inactiveStrokeStyle_shouldSetInactiveStrokeStyle", test_inactiveStrokeStyle_shouldSetInactiveStrokeStyle),
        ("test_activeColor_shouldSetActiveColor", test_activeColor_shouldSetActiveColor),
        ("test_activeStrokeStyle_shouldSetActiveStrokeStyle", test_activeStrokeStyle_shouldSetActiveStrokeStyle),
    ]
}

extension CircularSlider: KnownViewType {
    public static var typePrefix: String {
        "CircularSlider"
    }
}

extension CircularSlider: Inspectable {}
