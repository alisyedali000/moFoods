//
//  OnboardingViewer.swift
//  MoFoods
//
//  Created by Syed Ahmad  on 04/02/2025.
//

import SwiftUI

struct OnboardingViewer: View {
    @State var view : Int = 0
    @State var moveToNext = false
    var body: some View {
        
       screenView
            .navigationDestination(isPresented: $moveToNext) {
                
                LoginView()
                    .navigationBarBackButtonHidden()
                
            }

    }
}
extension OnboardingViewer{
    
    var screenView : some View{
        
        ZStack(alignment: .bottom){

            switch view{
                
            case 0:
                ZStack{
                    OnboardingView(image: ImageName.onboarding1, title: "Welcome to MoFoods", description: "Your ultimate food companion. Save all your favorite food spots and explore new ones.")
                    
                    ImageName.roundedAppIcon
                }
            case 1:
                OnboardingView(image: ImageName.onboarding2, title: "Pin your favorite spots", description: "Search and save your all favorite places to eat all in one place.")
            
            case 2:
                OnboardingView(image: ImageName.onboarding3, title: "Discover new spots with AI", description: "Discover new places to eat with AI recommendations based on your preferences and dietary needs.")
                
            default:
                EmptyView()
            }

            
            
            tabSelectionView
                .padding(.horizontal)
            
        }
        
    }
    
}

extension OnboardingViewer{
    
    var tabSelectionView: some View{
        
        VStack(spacing: 20){
            
            HStack{
                
                ForEach(0..<3, id: \.self){ view in
                    
                    tabCell(selection: view)
                    
                }
                
            }
            
            AppButton(title: "CONTINUE") {
                
                if view < 2 {
                    withAnimation {
                        view += 1
                    }
               
                } else {
                    Task{
//                        await vm.socialEditProfile()
                        self.moveToNext.toggle()
                    }

                    
                }
                
            }
            
        }
        
    }
    
    func tabCell(selection : Int) -> some View{
        
        
        RoundedRectangle(cornerRadius: 12)
            .foregroundStyle(Color.primaryOrange)
            .frame(width: selection == view ? 24 : 8, height: 8)
            .onTapGesture {
                
                withAnimation {
                    self.view = selection
                }
                
            }
        
    }
    
}
#Preview {
    OnboardingViewer()
}
