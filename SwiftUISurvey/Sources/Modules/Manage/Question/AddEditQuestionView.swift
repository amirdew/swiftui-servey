//
//  AddEditQuestionView.swift
//  SwiftUISurvey
//
//  Created by Amir on 03/08/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import SwiftUI

struct AddEditQuestionView: View {
    
    @StateObject private var viewModel: AddEditQuestionViewModel
    
    init(isPresenting: Binding<Bool>, question: Question? = nil) {
        _viewModel = StateObject(
            wrappedValue: AddEditQuestionViewModel(isPresenting: isPresenting, question: question)
        )
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Title", text: $viewModel.question.title)
                TextField("Question", text: $viewModel.question.question)
            }
            
            Section {
                Toggle(isOn: $viewModel.question.isOptional) {
                    Text("Optional")
                }
            }
            
            Section {
                saveButtonView
                    .frame(maxWidth: .infinity, alignment: .center)
                    .disabled(!viewModel.canBeSaved)
            }
        }
        .listStyle(GroupedListStyle())
        .environment(\.horizontalSizeClass, .regular)
        .navigationBarTitle(viewModel.isEditing ? "Edit Question" : "Add Question", displayMode: .inline)
        .showErrors(state: $viewModel.sendQuestionState)
    }
    
    @ViewBuilder private var saveButtonView: some View {
        if viewModel.sendQuestionState.isInProgress {
            ProgressView()
        } else {
            Button("Save", action: viewModel.save)
        }
    }
    
}


struct AddEditQuestionView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            view
            
            view
                .environment(\.colorScheme, .dark)
        }
    }
    
    private static var view: some View {
        AddEditQuestionView(isPresenting: .init(get: { true }, set: { _ in }))
    }
}
