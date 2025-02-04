//
//  Images.swift
//  MoFoods
//
//  Created by Syed Ahmad  on 03/02/2025.
//

import Foundation
import SwiftUI

enum ImageName: String {
    
    
    //MARK: OnBoarding
    
    
    
    case setting = "setting"
    
    
    static var onboarding1: Image {
        
        Image("Onboarding1")
    }
    
    static var onboarding2: Image {
        
        Image("Onboarding2")
    }
    
    static var onboarding3: Image {
        
        Image("Onboarding3")
    }
    
    static var roundedAppIcon: Image {
        
        Image("AppIconRounded")
    }
    
    //MARK: Social Logins
    
    static var googleIcon: Image {
        
        Image("google")
    }
    
    static var appleIcon: Image {
        
        Image("apple")
    }
    
}
