//
//  PullToRefresh.swift
//  SwiftUISurvey
//
//  Created by Amir on 09/08/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import SwiftUI

private struct PullToRefresh: UIViewRepresentable {
    
    // MARK: Properties
    
    var isRefreshing: Bool
    let onRefresh: () -> Void
    
    
    // MARK: Lifecycle
    
    init(isRefreshing: Bool, onRefresh: @escaping () -> Void) {
        self.isRefreshing = isRefreshing
        self.onRefresh = onRefresh
    }
    
    
    // MARK: Public functions
    
    func makeUIView(context: UIViewRepresentableContext<PullToRefresh>) -> UIView {
        let view = UIView(frame: .zero)
        view.isHidden = true
        view.isUserInteractionEnabled = false
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PullToRefresh>) {
        self.findTableView(entryView: uiView).map {
            setupRefreshControl(tableView: $0, context: context)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(onRefresh: onRefresh)
    }
    
    
    // MARK: Private functions
    
    private func setupRefreshControl(tableView: UITableView, context: UIViewRepresentableContext<PullToRefresh>) {
        if let refreshControl = tableView.refreshControl {
            isRefreshing ? refreshControl.beginRefreshing() : refreshControl.endRefreshing()
            return
        }
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(context.coordinator,
                                 action: #selector(Coordinator.onValueChanged),
                                 for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func findTableView(entryView: UIView) -> UITableView? {
        var view: UIView? = entryView
        while view != nil {
            if let view = view as? UITableView { return view }
            for view in view?.superview?.subviews ?? [] {
                if let view = view as? UITableView { return view }
                if let view = view.subviews.first {
                    if let view = findTableView(entryView: view) { return view }
                }
            }
            view = view?.superview
        }
        return nil
    }
}


extension PullToRefresh {
    
    class Coordinator {
        let onRefresh: () -> Void
        
        init(onRefresh: @escaping () -> Void) {
            self.onRefresh = onRefresh
        }
        
        @objc func onValueChanged() {
            onRefresh()
        }
    }
    
}


extension View {
    func pullToRefresh(isRefreshing: Bool, onRefresh: @escaping () -> Void) -> some View {
        overlay(
            PullToRefresh(isRefreshing: isRefreshing, onRefresh: onRefresh).frame(width: .zero)
        )
    }
}
