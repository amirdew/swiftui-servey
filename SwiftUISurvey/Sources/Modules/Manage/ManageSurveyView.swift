//
//  ManageSurveyView.swift
//  SwiftUISurvey
//
//  Created by Amir on 07/06/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import SwiftUI

struct ManageSurveyView: View {
    
    @StateObject private var viewModel = ManageSurveyViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(destination: addEditView,
                               isActive: $viewModel.isAddingOrEditing) {}
                listView
                    .navigationBarItems(
                        leading: modePickerView,
                        trailing: Button(action: new) {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 28, weight: .regular))
                        }
                    )
            }
        }
    }
    
    private var modePickerView: some View {
        Picker(selection: $viewModel.mode, label: Text("")) {
            ForEach(ManageListMode.allCases, id: \.self) {
                Text($0.name)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
    
    @ViewBuilder private var addEditView: some View {
        switch viewModel.mode {
        case .surveys: AddEditSurveyView(isPresenting: $viewModel.isAddingOrEditing,
                                         survey: viewModel.editingSurvey)
        case .questions: AddEditQuestionView(isPresenting: $viewModel.isAddingOrEditing,
                                             question: viewModel.editingQuestion)
        }
    }
    
    @ViewBuilder private var listView: some View {
        switch viewModel.mode {
        case .surveys: SurveyListView(onSurveySelected: {
            viewModel.editingSurvey = $0
            viewModel.isAddingOrEditing = true
        })
        case .questions: QuestionListView(onQuestionSelected: {
            viewModel.editingQuestion = $0
            viewModel.isAddingOrEditing = true
        })
        }
    }
    
    private func new() {
        viewModel.editingQuestion = nil
        viewModel.editingSurvey = nil
        viewModel.isAddingOrEditing = true
    }
}


struct ManageSurveyView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ManageSurveyView()
            ManageSurveyView()
                .environment(\.colorScheme, .dark)
        }
    }
}
