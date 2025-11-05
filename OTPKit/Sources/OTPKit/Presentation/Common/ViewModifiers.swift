//
//  ViewModifiers.swift
//  OTPKit
//
//  Created by Claude on 11/5/25.
//

import SwiftUI

// MARK: - Card Styling

/// A view modifier that applies consistent card styling with rounded corners, shadows, and backgrounds
struct CardStyle: ViewModifier {
    var cornerRadius: CGFloat = 12
    var shadowRadius: CGFloat = 10
    var shadowOpacity: Double = 0.1
    var shadowY: CGFloat = -5
    var backgroundColor: Color = .clear
    var backgroundMaterial: Material? = nil

    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(backgroundMaterial != nil ? AnyShapeStyle(backgroundMaterial!) : AnyShapeStyle(backgroundColor))
                    .shadow(
                        color: Color.black.opacity(shadowOpacity),
                        radius: shadowRadius,
                        x: 0,
                        y: shadowY
                    )
            )
    }
}

/// A view modifier for elevated card styling with stronger shadow
struct ElevatedCardStyle: ViewModifier {
    var cornerRadius: CGFloat = 12

    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(.background)
                    .shadow(color: .black.opacity(0.15), radius: 16, x: 0, y: 8)
            )
    }
}

/// A view modifier for subtle card styling with light shadow
struct SubtleCardStyle: ViewModifier {
    var cornerRadius: CGFloat = 8

    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(.regularMaterial)
                    .shadow(color: .black.opacity(0.08), radius: 4, x: 0, y: 2)
            )
    }
}

// MARK: - Shadow Modifiers

/// A view modifier that applies a subtle shadow
struct SubtleShadow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .black.opacity(0.08), radius: 4, x: 0, y: 2)
    }
}

/// A view modifier that applies a standard shadow
struct StandardShadow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: -5)
    }
}

/// A view modifier that applies a strong shadow for elevated elements
struct ElevatedShadow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .black.opacity(0.15), radius: 16, x: 0, y: 8)
    }
}

// MARK: - View Extensions

extension View {
    /// Applies consistent card styling with customizable parameters
    func cardStyle(
        cornerRadius: CGFloat = 12,
        shadowRadius: CGFloat = 10,
        shadowOpacity: Double = 0.1,
        shadowY: CGFloat = -5,
        backgroundColor: Color = .clear,
        backgroundMaterial: Material? = nil
    ) -> some View {
        modifier(CardStyle(
            cornerRadius: cornerRadius,
            shadowRadius: shadowRadius,
            shadowOpacity: shadowOpacity,
            shadowY: shadowY,
            backgroundColor: backgroundColor,
            backgroundMaterial: backgroundMaterial
        ))
    }

    /// Applies elevated card styling with stronger shadow
    func elevatedCardStyle(cornerRadius: CGFloat = 12) -> some View {
        modifier(ElevatedCardStyle(cornerRadius: cornerRadius))
    }

    /// Applies subtle card styling with light shadow
    func subtleCardStyle(cornerRadius: CGFloat = 8) -> some View {
        modifier(SubtleCardStyle(cornerRadius: cornerRadius))
    }

    /// Applies a subtle shadow
    func subtleShadow() -> some View {
        modifier(SubtleShadow())
    }

    /// Applies a standard shadow
    func standardShadow() -> some View {
        modifier(StandardShadow())
    }

    /// Applies a strong shadow for elevated elements
    func elevatedShadow() -> some View {
        modifier(ElevatedShadow())
    }
}
