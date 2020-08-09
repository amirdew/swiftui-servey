//
//  QuestionListView.swift
//  SwiftUISurvey
//
//  Created by Amir on 03/08/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import SwiftUI

struct QuestionListView: View {
    
    let onQuestionSelected: ((Question) -> Void)?
    @StateObject var viewModel: QuestionListViewModel

    init(onQuestionSelected: ((Question) -> Void)?, ids: [UUID]? = nil) {
        self.onQuestionSelected = onQuestionSelected
        _viewModel = StateObject(wrappedValue: QuestionListViewModel(ids: ids))
    }
    
    var body: some View {
        List(viewModel.questions) { question in
            QuestionRowView(question: question) {
                DispatchQueue.main.async {
                    onQuestionSelected?(question)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .pullToRefresh(isRefreshing: viewModel.isRefreshing,
                       onRefresh: viewModel.refresh)
    }
}

struct QuestionRowView: View {
    
    let question: Question
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(question.title)
        }
    }
}
