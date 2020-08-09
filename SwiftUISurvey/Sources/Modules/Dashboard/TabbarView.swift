//
//  TabbarView.swift
//  SwiftUISurvey
//
//  Created by Amir on 07/06/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import SwiftUI

struct TabbarView: View {
    
    @EnvironmentObject private var model: SurveyAppModel
    
    var body: some View {
        TabView(selection: $model.selectedTab) {
            
            ManageSurveyView()
                .tag(TabbarName.manage)
                .tabItem {
                    Image(systemName: "pencil.circle.fill")
                    Text("Manage")
                }
            
            SurveyForAnswerListView()
                .tag(TabbarName.surveyList)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Answer")
                }
        }
    }
}


struct SurveyForAnswerListView: View {
    
    @State private var selectedSurvey: Survey? = nil
    @State private var isShowingQuestions: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(destination: questionListView,  isActive: $isShowingQuestions) {}
                SurveyListView(onSurveySelected: {
                    selectedSurvey = $0
                    isShowingQuestions = true
                })
                .navigationBarTitle("Answer a survey", displayMode: .inline)
            }
        }
    }
    
    private var questionListView: some View {
        QuestionListView(onQuestionSelected: { _ in },
                         ids: selectedSurvey?.questionIds)
            .navigationBarTitle("pick a question", displayMode: .inline)
    }
}


struct TabbarView_Previews: PreviewProvider {
    static var previews: some View {
        TabbarView()
            .environmentObject(SurveyAppModel())
    }
}
