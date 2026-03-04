//
//  MettaBrand.swift
//  Metta
//
//  Metta Labs Brand System
//  Design Philosophy: Luminous Stillness
//

import SwiftUI

// MARK: - Brand Colors

extension Color {
    // Primary Colors
    static let mettaGold = Color(hex: "D4AF37")
    static let cream = Color(hex: "FAF9F5")
    static let dark = Color(hex: "141413")
    static let lightGray = Color(hex: "E8E6DC")
    
    // Semantic Colors
    static let brandPrimary = mettaGold
    static let brandBackground = cream
    static let brandText = dark
    static let brandSubtle = lightGray
    
    // Dark Mode Adaptations
    static let mettaGoldDark = Color(hex: "E5C76B")
    static let creamDark = Color(hex: "1A1A19")
    static let darkDark = Color(hex: "F5F4F0")
    static let lightGrayDark = Color(hex: "2A2A28")
}

extension ShapeStyle where Self == Color {
    static var mettaGold: Color { .mettaGold }
    static var cream: Color { .cream }
    static var dark: Color { .dark }
    static var lightGray: Color { .lightGray }
}

// MARK: - Hex Color Initializer

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - Brand Typography

enum MettaTypography {
    // Headlines - Cormorant Garamond
    static let largeTitle = Font.system(size: 34, weight: .light, design: .serif)
    static let title1 = Font.system(size: 28, weight: .light, design: .serif)
    static let title2 = Font.system(size: 22, weight: .light, design: .serif)
    static let title3 = Font.system(size: 20, weight: .medium, design: .serif)
    
    // Body - Crimson Pro (using system serif as fallback)
    static let body = Font.system(size: 17, weight: .regular, design: .default)
    static let bodyBold = Font.system(size: 17, weight: .semibold, design: .default)
    static let callout = Font.system(size: 16, weight: .regular, design: .default)
    static let subheadline = Font.system(size: 15, weight: .regular, design: .default)
    static let footnote = Font.system(size: 13, weight: .regular, design: .default)
    static let caption = Font.system(size: 12, weight: .regular, design: .default)
    
    // Custom weights
    static let headlineLight = Font.system(size: 17, weight: .light, design: .serif)
    static let headlineMedium = Font.system(size: 17, weight: .medium, design: .serif)
}

// MARK: - Spacing System

enum MettaSpacing {
    static let xxs: CGFloat = 4
    static let xs: CGFloat = 8
    static let sm: CGFloat = 12
    static let md: CGFloat = 16
    static let lg: CGFloat = 24
    static let xl: CGFloat = 32
    static let xxl: CGFloat = 48
    static let xxxl: CGFloat = 64
    
    // Semantic
    static let cardPadding: CGFloat = 20
    static let screenPadding: CGFloat = 24
    static let elementSpacing: CGFloat = 16
}

// MARK: - Corner Radius

enum MettaCornerRadius {
    static let small: CGFloat = 8
    static let medium: CGFloat = 12
    static let large: CGFloat = 16
    static let xlarge: CGFloat = 24
    static let circular: CGFloat = 9999
}

// MARK: - Shadows

enum MettaShadow {
    static let subtle = ShadowStyle(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
    static let medium = ShadowStyle(color: .black.opacity(0.1), radius: 16, x: 0, y: 4)
    static let prominent = ShadowStyle(color: .mettaGold.opacity(0.2), radius: 24, x: 0, y: 8)
    
    struct ShadowStyle {
        let color: Color
        let radius: CGFloat
        let x: CGFloat
        let y: CGFloat
    }
}

// MARK: - View Modifiers

struct MettaCard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(MettaSpacing.cardPadding)
            .background(Color.cream)
            .cornerRadius(MettaCornerRadius.large)
            .shadow(color: MettaShadow.subtle.color, radius: MettaShadow.subtle.radius, x: MettaShadow.subtle.x, y: MettaShadow.subtle.y)
    }
}

struct MettaButton: ViewModifier {
    var isPrimary: Bool
    
    func body(content: Content) -> some View {
        content
            .font(MettaTypography.bodyBold)
            .foregroundColor(isPrimary ? .dark : .mettaGold)
            .padding(.horizontal, MettaSpacing.lg)
            .padding(.vertical, MettaSpacing.sm)
            .background(isPrimary ? Color.mettaGold : Color.clear)
            .cornerRadius(MettaCornerRadius.medium)
            .overlay(
                RoundedRectangle(cornerRadius: MettaCornerRadius.medium)
                    .stroke(Color.mettaGold, lineWidth: isPrimary ? 0 : 1)
            )
    }
}

struct MettaGoldAccent: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.mettaGold)
    }
}

// MARK: - View Extensions

extension View {
    func mettaCard() -> some View {
        modifier(MettaCard())
    }
    
    func mettaButton(primary: Bool = true) -> some View {
        modifier(MettaButton(isPrimary: primary))
    }
    
    func mettaGoldAccent() -> some View {
        modifier(MettaGoldAccent())
    }
}

// MARK: - Animation

enum MettaAnimation {
    static let standard = Animation.easeInOut(duration: 0.3)
    static let slow = Animation.easeInOut(duration: 0.5)
    static let quick = Animation.easeOut(duration: 0.15)
    
    static let fadeIn = Animation.easeIn(duration: 0.4)
    static let slideUp = Animation.spring(response: 0.5, dampingFraction: 0.8)
}

// MARK: - Logo

struct MettaLogo: View {
    enum Variant {
        case primary
        case icon
    }
    
    let variant: Variant
    let size: CGFloat?
    
    init(variant: Variant = .primary, size: CGFloat? = nil) {
        self.variant = variant
        self.size = size
    }
    
    var body: some View {
        // Placeholder - replace with actual logo assets
        // For now, using text-based logo
        Group {
            if variant == .icon {
                Image(systemName: "lotus.fill")
                    .font(.system(size: size ?? 40))
                    .foregroundColor(.mettaGold)
            } else {
                HStack(spacing: 8) {
                    Image(systemName: "lotus.fill")
                        .font(.system(size: (size ?? 24) * 0.8))
                        .foregroundColor(.mettaGold)
                    Text("Metta")
                        .font(MettaTypography.title2)
                        .foregroundColor(.dark)
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: 20) {
        MettaLogo(variant: .primary, size: 32)
        MettaLogo(variant: .icon, size: 64)
        
        Divider()
        
        Text("Metta Gold").foregroundColor(.mettaGold)
        Text("Cream").foregroundColor(.cream)
        Text("Dark").foregroundColor(.dark)
        
        Divider()
        
        Text("Large Title").font(MettaTypography.largeTitle)
        Text("Title 1").font(MettaTypography.title1)
        Text("Body").font(MettaTypography.body)
    }
    .padding()
}
