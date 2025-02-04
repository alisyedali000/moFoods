//
//  Fonts.swift
//  GoodCreator
//
//  Created by Syed Ahmad  on 11/11/2024.
//

import Foundation
import SwiftUI

extension Font {
    
    
    //MARK: Poppins
    static func bold(size: CGFloat) -> Font {
        self.custom("Figtree-Bold", size: size)
    }
    
    static func semiBold(size: CGFloat) -> Font {
        self.custom("Figtree-SemiBold", size: size)
    }
    
    static func medium(size: CGFloat) -> Font {
        self.custom("Figtree-Medium", size: size)
    }
    
    static func regular(size: CGFloat) -> Font {
        self.custom("Figtree-Regular", size: size)
    }
    
    
}
