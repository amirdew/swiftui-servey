//
//  ManageSurveyViewModel.swift
//  SwiftUISurvey
//
//  Created by Amir on 07/08/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import Foundation

class ManageSurveyViewModel: ObservableObject {
    
    // MARK: Properties
    
    @Published var mode: ManageListMode = .surveys
    @Published var editingSurvey: Survey? = nil
    @Published var editingQuestion: Question? = nil
    @Published var isAddingOrEditing: Bool = false
}
