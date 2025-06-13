//
//  Constant.swift
//  iConnect
//
//  Created by Jonathan Mora on 13/06/25.
//
import SwiftUI

struct Constants {
    static let standardPadding: CGFloat = 14.0

    
    static let collectionGridSpacing: CGFloat = 14.0
    static let collectionGridItemMaxSize: CGFloat = 290.0
    
    @MainActor static var collectionGridItemMinSize: CGFloat {
        #if os(iOS)
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 220.0
        } else {
            return 160.0
        }
            
        #else
        return 220.0
        #endif
    }

}
