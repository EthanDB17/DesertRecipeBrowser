//
//  MealInstructionsViewModel.swift
//  DesertRecipeBrowser
//
//  Created by Ethan Borrowman on 8/29/24.
//

import Foundation

/// Manages the meal instruction data for the MealInstructionsView
final class MealInstructionsViewModel {
    
    // MARK: - Properties -
    
    let instructions: String
    
    init(instructions: String) {
        self.instructions = instructions
    }
}
