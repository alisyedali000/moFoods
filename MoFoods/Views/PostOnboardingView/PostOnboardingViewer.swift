//
//  OnboardingViewer.swift
//  MoFoods
//
//  Created by Syed Ahmad  on 05/02/2025.
//


import SwiftUI

struct PostOnboardingViewer: View {
    @State var view : Int = 0
    @State var moveToNext = false
    var body: some View {
        
       screenView
            .navigationDestination(isPresented: $moveToNext) {
                
                SetPreferencesView()
                    .navigationBarBackButtonHidden()
                
            }

    }
}
extension PostOnboardingViewer{
    
    var screenView : some View{
        
        ZStack(alignment: .bottom){

            switch view{
                
            case 0:
                PostOnboardingView(image: ImageName.pOnboarding2, title: "Access to location 📍", description: "Enable location sharing to discover new places to eat.")
            case 1:
                PostOnboardingView(image: ImageName.pOnboarding3, title: "Set your preferences 📝", description: "Select your preferences and tell us your dietary needs.")
                
            case 2:
                PostOnboardingView(image: ImageName.pOnboarding4, title: "Discover new restaurants and pin your favourite", description: "Solve the biggest question, “What should I eat today?” by letting the AI recommend you places to eat")

            default:
                EmptyView()
            }

            
            tabSelectionView
                .padding(.horizontal)
            
        }
        
    }
    
}

extension PostOnboardingViewer{
    
    var tabSelectionView: some View{
        
        VStack(spacing: 20){
            
            HStack{
                
                ForEach(0..<3, id: \.self){ view in
                    
                    tabCell(selection: view)
                    
                }
                
            }
            
            AppButton(title: "NEXT", radius: 53) {
                
                
                switch view{
                    
                    case 0:
                    LocationManager.shared.requestLocation { result in
                         switch result {
                         case .success(let location):
                             
                             DatabaseManager.shared.updateUserLocation(lat: location.coordinate.latitude, long: location.coordinate.longitude)
                             debugPrint("User's location: \(location.coordinate.latitude), \(location.coordinate.longitude)")
                            
                         case .failure(let error):
                             if error.localizedDescription == LocationError.accessDenied.errorDescription {
                                 
                                 debugPrint("Access was denied! Please enable location services in Settings.")
                                
                             }
                             print("Error fetching location: \(error.localizedDescription)")
                         }
                         
                     }
                    
                    view += 1
                    
                    case 1:
                    self.moveToNext = true
                        view += 1
                    
                    case 2:
//                    changeRootView(to: TabBar())
                    UserDefaultManager.Authenticated.send(true)
                        
                default:
                    return
                }
//                if view < 2 {
//                    withAnimation {
//                        view += 1
//                    }
//               
//                } else {
//                    Task{
////                        await vm.socialEditProfile()
//                        self.moveToNext.toggle()
//                    }
//
//                    
//                }
                
            }
            
        }
        
    }
    
    func tabCell(selection : Int) -> some View{
        
        ZStack{
            Circle()
                .foregroundStyle(Color.black)
                .frame(width: 8)
                .onTapGesture {
                    
                    withAnimation {
                        self.view = selection
                    }
                    
                }
            
            Circle()
                .frame(width: 6)
                .foregroundStyle(selection == view ?  Color.black : .white)
        }
        
    }
    
}
#Preview {
    PostOnboardingViewer()
}
