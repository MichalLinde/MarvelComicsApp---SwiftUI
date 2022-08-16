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
    
    @GestureState private var translation: CGFloat = .zero
    
    private var offset: CGFloat { isOpen ? .zero : maxHeight - minHeight}
    
    private var indicator: some View {
        RoundedRectangle(cornerRadius: BottomSheetConstants.sheetRadius)
            .fill(Color.gray)
            .frame(width: BottomSheetConstants.grabberWidth, height: BottomSheetConstants.grabberHeight)
            .onTapGesture {
                self.isOpen.toggle()
            }
    }
    
    init(isOpen: Binding<Bool>, maxHeight: CGFloat, @ViewBuilder content: () -> Content) {
        self.minHeight = maxHeight * BottomSheetConstants.sheetHeightRation
        self.maxHeight = maxHeight
        self.content = content()
        self._isOpen = isOpen
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: .zero) {
                self.indicator.padding()
                self.content
            }
            .frame(width: geometry.size.width, height: self.maxHeight, alignment: .top)
            .background(Color.white)
            .cornerRadius(BottomSheetConstants.sheetRadius)
            .frame(height: geometry.size.height, alignment: .bottom)
            .animation(.interactiveSpring(response: BottomSheetConstants.animationResponse), value: self.translation)
            .animation(.interactiveSpring(response: BottomSheetConstants.openAnimationResponse), value: self.isOpen)
            .offset(y: max(self.offset + self.translation, .zero))
            .gesture(
                DragGesture().updating(self.$translation) { value, state, _ in
                    state = value.translation.height
                }.onEnded { value in
                    let snapDistance = self.maxHeight * BottomSheetConstants.snapRation
                    guard abs(value.translation.height) > snapDistance else {
                        return
                    }
                    self.isOpen = value.translation.height < 0
                }
            )
        }
    }
}
