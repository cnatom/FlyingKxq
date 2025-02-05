//
//  NewsListView.swift
//  FlyingKxq
//
//  Created by atom on 2025/2/3.
//

import SwiftUI

struct NewsListView: View {
    @StateObject var viewModel = NewsListViewModel()
    @EnvironmentObject var toast: ToastViewModel
    @State var loading = false

    init(model: NewsListModel) {
        _viewModel = StateObject(wrappedValue: NewsListViewModel(model: model))
    }

    func getData() {
        Task {
            if loading {
                return
            }
            loading = true
            let result = await viewModel.getData()
            if let result = result,
               !result.success {
                toast.showToast(result.text, type: .error)
            }

            loading = false
        }
    }

    var body: some View {
        LazyVStack(spacing: 19) {
            ForEach(Array(viewModel.model.newsList.enumerated()), id: \.offset) { index, item in
                NewsCardView(time: item.publishTimeFormatted ?? "",
                             visitCount: item.viewCount ?? 0,
                             title: item.title ?? "",
                             imageUrl: item.imageUrl,
                             imageText: item.sourceName
                )
                    .onAppear {
                        if index == viewModel.model.newsList.count - 5 {
                            self.getData()
                        }
                    }
            }
        }
        .padding(.horizontal, 16)
        .onAppear {
            self.getData()
        }
    }
}

#Preview {
    NewsListView(model: NewsListModel())
        .environmentObject(ToastViewModel())
}
