//
//  ViewModifiers.swift
//  MoFoods
//
//  Created by Syed Ahmad  on 03/02/2025.
//

import Foundation
import SwiftUI
import StoreKit

extension View {
    
    var addRoundedCorner: some View{
        
        modifier(AddRoundedCorner())
    }
    
    var addOnboardingHeader: some View {
        modifier(AddOnBoardingHeader())
    }
    
    var addBackground: some View {
        modifier(Background())
    }
    
    var addRoundedBackground: some View {
        modifier(AddRoundedBackground())
    }
    
    func addStroke(radius: CGFloat, color : Color, lineWidth: CGFloat) -> some View {
        modifier(AddStroke(radius: radius, color: color, lineWidth: lineWidth))
    }
}

struct Background: ViewModifier {
    
    func body(content: Content) -> some View {
        
        ZStack {
            Rectangle()
                .foregroundStyle(Color.tabBarBlue)
                .ignoresSafeArea(.all)
            
            content
        }
    }
}


struct AddOnBoardingHeader: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    func body(content: Content) -> some View {
        
        ZStack{
            
            ZStack(alignment: .top){
                
                Rectangle()
                    .foregroundStyle(Color.tabBarBlue)
                
                ZStack{
                    ImageName.onboarding1
                        .resizable()
                        .scaledToFill()
                        .frame(height: 230)
                        .clipped()
                        .clipShape(.rect)
                        .overlay {
                            Rectangle()
                                .foregroundStyle(Color.black.opacity(0.5))
                        }
                        
                    ImageName.roundedAppIcon
                        .padding(.bottom)
                }
            }
            .ignoresSafeArea()
            
            ZStack{
                RoundedRectangle(cornerRadius: 24)
                    .foregroundStyle(colorScheme == .dark ? Color.black : Color.white)
                    .ignoresSafeArea()
                
                VStack{
                    
                    content
                    
                }
            }
            .padding(.top,95)
            
        }
    }
}


struct AddRoundedCorner: ViewModifier {
    
    func body(content: Content) -> some View {
        
        ZStack{
            
            ZStack(alignment: .top){
                
                Rectangle()
                    .foregroundStyle(Color.tabBarBlue)
                
            }
            .ignoresSafeArea()
            
            
            
            ZStack{
                
                Color.white
                    .cornerRadius(24, corners: .allCorners)
                
                content
                    .cornerRadius(24, corners: .allCorners)
                
            }
            
            
            
        }
    }
}

struct AddRoundedBackground : ViewModifier {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: horizontalSizeClass == .compact ? 21 : 56.8)
                    .foregroundStyle(Color.tabBarBlue)
            )
            
    }
}

struct AddStroke : ViewModifier {
    
    var radius: CGFloat
    var color: Color
    var lineWidth: CGFloat
    
    func body(content: Content) -> some View {
        content
            .overlay {
                RoundedRectangle(cornerRadius: radius)
                    .stroke(color, lineWidth: lineWidth)
            }
    }
}


extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}



