//
//  ToastViewModel.swift
//  FlyingKxq
//
//  Created by atom on 2025/1/24.
//
import SwiftUI

struct ToastModel {
    var text: String
    var type: FlyToastViewType
}

struct ToastLoadingModel {
    var text: String = "加载成功"
    var loadingText: String = "加载中"
    var success: Bool = false
    var type: FlyToastViewType {
        success ? .success : .error
    }
}

class ToastViewModel: ObservableObject {
    @Published var model = ToastModel(text: "", type: .normal)
    @Published var isShowing: Bool = false
    func showToast(_ text: String, type: FlyToastViewType = .normal) {
        model.text = text
        isShowing = true
        model.type = type
    }

    func showToast(_ model: ToastModel) {
        self.model.text = model.text
        self.model.type = model.type
        isShowing = true
    }
    
    /// loading
    @Published var loadingModel = ToastLoadingModel()
    @Published var isShowLoading: Bool = false
    
    func start(_ loadingText: String = "加载中") {
        loadingModel.loadingText = loadingText
        isShowLoading = true
    }
    
    func end(_ text: String, success: Bool) {
        isShowLoading = false
        model.text = text
    }
    
    func end(_ model: ToastLoadingModel) {
        isShowLoading = false
        self.loadingModel.success = model.success
        self.loadingModel.text = model.text
    }
    
}

