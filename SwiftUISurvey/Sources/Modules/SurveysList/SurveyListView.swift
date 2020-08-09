//
//  SurveyListView.swift
//  SwiftUISurvey
//
//  Created by Amir on 07/06/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import SwiftUI

struct SurveyListView: View {
    
    let onSurveySelected: ((Survey) -> Void)?
    @StateObject var viewModel = SurveyListViewModel()
    
    var body: some View {
        List(viewModel.surveys) { survey in
            SurveyRowView(survey: survey) {
                DispatchQueue.main.async {
                    onSurveySelected?(survey)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .pullToRefresh(isRefreshing: viewModel.isRefreshing,
                       onRefresh: viewModel.refresh)
    }
}

struct SurveyRowView: View {
    
    let survey: Survey
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(survey.title)
        }
    }
}
