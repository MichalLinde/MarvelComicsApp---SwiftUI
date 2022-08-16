//
//  BottomSheet.swift
//  marvel-app-swiftui
//
//  Created by Michal on 16/08/2022.
//

import Foundation
import SwiftUI

struct BottomSheet<Content: View> : View {
    @Binding var isOpen: Bool
    
    let maxHeight: CGFloat
    let minHeight: CGFloat
    let content: Content
    
    @GestureState private var translation: CGFloat = 0
    
    private var offset: CGFloat { isOpen ? 0 : maxHeight - minHeight}
    
    private var indicator: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(Color.gray)
            .frame(width: 60, height: 6)
            .onTapGesture {
                self.isOpen.toggle()
            }
    }
    
    init(isOpen: Binding<Bool>, maxHeight: CGFloat, @ViewBuilder content: () -> Content) {
        self.minHeight = maxHeight * 0.3
        self.maxHeight = maxHeight
        self.content = content()
        self._isOpen = isOpen
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                self.indicator.padding()
                self.content
            }
            .frame(width: geometry.size.width, height: self.maxHeight, alignment: .top)
            .background(Color.white)
            .cornerRadius(15)
            .frame(height: geometry.size.height, alignment: .bottom)
            .animation(.interactiveSpring(response: 0.1), value: self.translation)
            .animation(.interactiveSpring(response: 0.1), value: self.isOpen)
            .offset(y: max(self.offset + self.translation, 0))
            .gesture(
                DragGesture().updating(self.$translation) { value, state, _ in
                    state = value.translation.height
                }.onEnded { value in
                    let snapDistance = self.maxHeight * 0.25
                    guard abs(value.translation.height) > snapDistance else {
                        return
                    }
                    self.isOpen = value.translation.height < 0
                }
            )
        }
    }
}
