//
//  TagEditerView.swift
//  FlyingKxq
//
//  Created by atom on 2025/1/9.
//

import SwiftUI

struct TagEditerView: View {
    @EnvironmentObject var viewModel: ProfileHeaderViewModel
    @EnvironmentObject var toast: ToastViewModel
    @State var showAddDialog = false
    @State var showEditDialog = false
    @State var selectedTagIndex = 0

    func showEditDialogFunc(selectedIndex: Int) {
        selectedTagIndex = selectedIndex
        showEditDialog = true
    }

    func showAddDialogFunc() {
        showAddDialog = true
    }

    var body: some View {
        ProfileEditScaffold(title: "修改状态", showSaveButton: false) {
        } content: {
            ScrollView {
                VStack(spacing: 12) {
                    VStack(spacing: 0) {
                        ForEach(Array(viewModel.model.tags.enumerated()), id: \.offset) { index, tag in
                            Button {
                                showEditDialogFunc(selectedIndex: index)
                            } label: {
                                rowContent(tag: tag)
                            }
                        }
                    }
                    .container()
                    addButton
                    HStack {
                        Spacer()
                        Text("\(viewModel.model.tags.count)/3个")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(Color.flyTextGray)
                    }
                }
                .padding(12)
            }
        }
        .flyBaseDialog(isPresented: $showAddDialog) {
            // 添加状态
            TagEditerDialogView(show: $showAddDialog, title: "添加状态") { newTag in
                viewModel.model.tags.append(newTag)
                toast.showToast("添加成功", type: .success)
            }
            .frame(height: self.screenSize.height * 0.8, alignment: .top)
        }
        .flyBaseDialog(isPresented: $showEditDialog) {
            if !viewModel.model.tags.isEmpty {
                TagEditerDialogView(
                    show: $showEditDialog,
                    initialTag: viewModel.model.tags[selectedTagIndex],
                    onDelete: { delTag in
                        toast.showToast("删除成功", type: .success)
                        viewModel.model.tags.removeAll { tag in
                            tag.id == delTag.id
                        }
                        selectedTagIndex = 0
                    },
                    onConfirm: { newTag in
                        viewModel.model.tags[selectedTagIndex] = newTag
                        toast.showToast("修改成功", type: .success)
                    }
                )
                .frame(height: self.screenSize.height * 0.8, alignment: .top)
            }
        }
    }

    var addButton: some View {
        Button {
            showAddDialogFunc()
        } label: {
            HStack(spacing: 0) {
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 13)
                    .foregroundStyle(Color.flyText)
                    .padding(.trailing, 22)
                Text("添加状态")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundStyle(Color.flyText)
                Spacer()
                rightIcon
            }
            .padding(.vertical, 12)
            .padding(.leading, 3)
        }
        .container()
    }

    @ViewBuilder
    func rowContent(tag: ProfileTag) -> some View {
        HStack(spacing: 0) {
            Group {
                Text("\(tag.emoji)")
                Text("\(tag.text)")
            }
            .font(.system(size: 16, weight: .medium))
            .foregroundStyle(Color.flyText)
            .padding(.trailing, 12)
            Text("\(tag.endTimeString)")
                .font(.system(size: 14, weight: .regular))
                .foregroundStyle(Color.flyTextGray)
            Spacer()
            rightIcon
        }
        .padding(.vertical, 14)
        .contentShape(Rectangle())
    }

    var rightIcon: some View {
        Image(systemName: "chevron.right")
            .resizable()
            .scaledToFit()
            .frame(height: 11)
            .foregroundStyle(Color.flyGray)
    }
}

extension View {
    fileprivate func container() -> some View {
        padding(.leading, 13)
            .padding(.trailing, 19)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(Color.flySecondaryBackground)
            }
    }
}

struct TagEditerViewPreview: View {
    var body: some View {
        TagEditerView()
            .environmentObject(ProfileHeaderViewModel())
    }
}

#Preview {
    TagEditerViewPreview()
}
