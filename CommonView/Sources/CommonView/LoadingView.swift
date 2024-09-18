//
//  LoadingView.swift
//  GithubApp
//
//  Created by marei_irie on 2024/09/13.
//

import SwiftUI

public struct LoadingView: View {
    @Binding var isLoading: Bool

    public init(isLoading: Binding<Bool>) {
        self._isLoading = isLoading
    }

    @ViewBuilder
    public var body: some View {
        if isLoading {
            ProgressView()
        } else {
            EmptyView()
        }
    }
}
