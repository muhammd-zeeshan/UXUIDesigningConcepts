//
//  Home.swift
//  ContinueLearningUI
//
//  Created by Muhammad Zeeshan on 28/10/2024.
//

import SwiftUI

struct Home: View {
    /// Sample Array of Colors
    @State private var colors: [Color] = [.black, .blue, .yellow, .purple]
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 0) {
                ForEach(colors, id: \.self) { color in
                    SwipeAction(cornerRadius: 15, direction: .trailing) {
                        CardView(color)
                    } actions: {
                        Action(tint: .blue, icon: "star.fill") {
                            print("BookMark")
                        }
                        
                        Action(tint: .red, icon: "trash.fill") {
                            withAnimation(.easeInOut) {
                                colors.removeAll(where: {$0 == color})
                            }
                        }
                    }

                }
            }
            .padding(.vertical, 15)
        }
        .scrollIndicators(.hidden)
    }
    
    //MARK: Sample Card View
    @ViewBuilder
    func CardView(_ color: Color) -> some View {
        HStack(spacing: 12) {
            Circle()
                .frame(width: 50, height: 50)
            
            VStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 100, height: 5)
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 75, height: 5)
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 50, height: 5)
            }
            Spacer(minLength: 0)
        }
        .foregroundStyle(.white.opacity(0.5))
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(color.gradient)
    }
}


#Preview {
    CustomSwipe()
}



//MARK: Custom Swipe Action View
struct SwipeAction<Content: View>: View {
    var cornerRadius: CGFloat = 0
    var direction: SwipeDirection = .trailing
    @ViewBuilder var content: Content
    @ActionBuilder var actions: [Action]
    // View Unique ID
    let viewID = UUID()
    @State private var isEnabled: Bool = true // use for Disabling the intersections while the animation is active.
    @State private var scrollOffset: CGFloat = .zero
    
    var body: some View {
        ScrollViewReader { scrollProxy in // This is used to reset the scroll view to its original position when a swipe action is pressed!
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    content
                    // To Take Full Available Space
                        .containerRelativeFrame(.horizontal)
                        .background {
                            if let fistAction = actions.first {
                                Rectangle()
                                    .fill(fistAction.tint)
                                    .opacity(scrollOffset == .zero ? 0 : 1)
                            }
                        }
                        .id(viewID)
                        .transition(.identity)
                        .overlay {
                            GeometryReader {
                                let minX = $0.frame(in: .scrollView(axis: .horizontal)).minX
                                
                                Color.clear
                                    .preference(key: offsetkey.self, value: minX)
                                    .onPreferenceChange(offsetkey.self) {
                                        scrollOffset = $0
                                    }
                            }
                        }
                    
                    ActionButton {
                        withAnimation(.snappy) {
                            scrollProxy.scrollTo(viewID, anchor: direction == .trailing ? .topLeading : .topTrailing)
                        }
                    }
                    .opacity(scrollOffset == .zero ? 0 : 1)
                }
                .scrollTargetLayout()
                //Now let's limit the scroll based on the direction using the new " visuaEffect " API
                .visualEffect { content, geometryProxy in
                    content
                        .offset(x: scrollOffset(geometryProxy))
                }
                
            }
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.viewAligned) // ViewAligned scroll target behavior requires scrollTargetLayout() to be added inside the scrollView
            
            // Add background for complete swipe view
            .background {
                if let lastAction = actions.last {
                    Rectangle()
                        .fill(lastAction.tint)
                        .opacity(scrollOffset == .zero ? 0 : 1)
                }
            }
            .clipShape(.rect(cornerRadius: cornerRadius))
        }
        .allowsTightening(isEnabled)
        .transition(CustomTransition())
    }
    
    // MARK: Action Buttons
    @ViewBuilder
    func ActionButton(resetPosition: @escaping () -> Void) -> some View {
        Rectangle()
            .fill(.clear)
            .frame(width: CGFloat(actions.count) * 100)
            .overlay {
                HStack(spacing: 0) {
                    ForEach(actions) { button in
                        Button {
                            Task {
                                isEnabled = false
                                resetPosition()
                                try? await Task.sleep(for: .seconds(0.25))
                                button.action()
                                try? await Task.sleep(for: .seconds(0.1))
                                isEnabled = true
                            }
                        } label: {
                            Image(systemName: button.icon)
                                .font(button.iconFont)
                                .foregroundStyle(button.iconTint)
                                .frame(width: 100)
                                .frame(maxHeight: .infinity)
                                .contentShape(.rect)
                        }
                        .buttonStyle(.plain)
                        .background(button.tint)

                    }
                }
            }
    }
    
    func scrollOffset(_ proxy: GeometryProxy) -> CGFloat {
        let minX = proxy.frame(in: .scrollView(axis: .horizontal)).minX
        
        return direction == .trailing ? (minX > 0 ? -minX : 0) : (minX < 0 ? -minX : 0)
    }
}

// MARK: offset Key
struct offsetkey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

// MARK: Custom Transition
struct CustomTransition: Transition {
    func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .mask {
                GeometryReader {
                    let size = $0.size
                    
                    Rectangle()
                        .offset(y: phase == .identity ? 0 : -size.height)
                }
                .containerRelativeFrame(.horizontal)
            }
    }
}

// MARK: Swipe Direction
enum SwipeDirection {
    case leading, trailing
    
    var alignment: Alignment {
        switch self {
        case .leading:
            return .leading
        case .trailing:
            return .trailing
        }
    }
}


// MARK: Action Label
struct Action: Identifiable {
    private(set) var id: UUID = .init()
    var tint: Color
    var icon: String
    var iconFont: Font = .title
    var iconTint: Color = .white
    var isEnabled: Bool = true
    var action: () -> Void
}

@resultBuilder
struct ActionBuilder {
    static func buildBlock(_ components: Action...) -> [Action] {
        return components
    }
}


