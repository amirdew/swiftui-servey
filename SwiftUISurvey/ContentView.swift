//
//  ContentView.swift
//  SwiftUISurvey
//
//  Created by Amir on 08/08/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingDetailView = false

    var body: some View {
        NavigationView {
            NavigationLink(destination: AddEditSurveyView(isPresenting: $isShowingDetailView, survey: nil), isActive: $isShowingDetailView) {
                Text("Show Detail")
            }
            .navigationBarTitle("Navigation")
        }
    }
}
