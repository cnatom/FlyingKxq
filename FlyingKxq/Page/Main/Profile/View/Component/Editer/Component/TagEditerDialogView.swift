//
//  TagEditerDialogView.swift
//  FlyingKxq
//
//  Created by atom on 2025/1/22.
//

import MCEmojiPicker
import SwiftUI

struct TagEditerDialogView: View {
    @EnvironmentObject var toast: ToastViewModel

    @Binding var show: Bool
    let onConfirm: (ProfileTag) -> Void
    let initialTag: ProfileTag
    let onDelete: ((ProfileTag) -> Void)?
    let title: String

    @State var emoji: String = ""
    @State var tagName: String = ""
    @State var showEmojiPicker: Bool = false
    @State var showDatePicker: Bool = false
    @State var endTime: Date
    @State var tempTime = Date()

    init(show: Binding<Bool>,title: String = "修改状态", initialTag: ProfileTag = ProfileTag(emoji: "", text: ""), onDelete: ((ProfileTag) -> Void)? = nil, onConfirm: @escaping (ProfileTag) -> Void) {
        _show = show
        self.onConfirm = onConfirm
        self.initialTag = initialTag
        self.onDelete = onDelete
        endTime = initialTag.endTime ?? Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
        self.title = title
    }

    func confirm() {
        if isValid() {
            onConfirm(ProfileTag(emoji: emoji, text: tagName, endTime: endTime))
            show = false
        }
    }

    func isValid() -> Bool {
        /// emoji
        if emoji.isEmpty {
            toast.showToast("emoji为空", type: .warning)

            return false
        }
        if emoji.count != 1 {
            toast.showToast("未选择Emoji", type: .warning)

            return false
        }
        if !emoji.first!.isEmoji {
            toast.showToast("请输入正确的emoji", type: .warning)
            return false
        }
        /// tagName
        if tagName.count > 10 {
            toast.showToast("状态名最多10个字符", type: .warning)
            return false
        }

        if tagName.isEmpty {
            toast.showToast("状态名为空", type: .warning)

            return false
        }
        /// endTime
        if endTime < Date() {
            toast.showToast("必须为未来的时间", type: .warning)
            return false
        }
        return true
    }

    var body: some View {
        VStack(spacing: 0) {
            FlyDialogHeaderView(
                show: $show,
                title: title,
                cancelText: onDelete == nil ? "取消" : "删除",
                cancel: {
                    onDelete?(initialTag)
                },
                cancelTextColor: onDelete == nil ? Color.flyText : Color.red,
                actionText: "确认",
                action: {
                    confirm()
                }
            )
            VStack(spacing: 12) {
                emojiView
                    .padding(.bottom, 24)
                FlyTextField(placeHolderText: "输入状态名", text: $tagName)
                dateTriggerView
                    .popover(isPresented: $showDatePicker) {
                        datePickerView
                    }
            }
            .padding(12)
            .onAppear {
                emoji = initialTag.emoji
                tagName = initialTag.text
            }
        }
    }

    /// 时间选择触发器
    var dateTriggerView: some View {
        Button {
            withAnimation(.none) {
                showDatePicker.toggle()
            }
        } label: {
            FlyTextField(placeHolderText: "结束时间（默认24小时之后）", text: .constant(endTime.formatCountdownString()))
                .multilineTextAlignment(.leading)
                .disabled(true)
        }
    }

    /// 未来五年内
    var dateRange: ClosedRange<Date> {
        let calendar = Calendar.current
        let now = Date()
        if let fiveYearsLater = calendar.date(byAdding: .year, value: 5, to: now) {
            return now ... fiveYearsLater
        } else {
            return now ... now
        }
    }

    /// 时间选择
    var datePickerView: some View {
        VStack {
            FlyDialogHeaderView(show: $showDatePicker, title: "选择结束时间", actionText: "确定") {
                showDatePicker = false
                endTime = tempTime
                toast.showToast("结束时间已修改", type: .success)
            }
            DatePicker(selection: $tempTime, in: dateRange, displayedComponents: [.date, .hourAndMinute]) {}
                .datePickerStyle(.graphical)
            Spacer()
        }
    }

    /// 选择Emoji
    var emojiView: some View {
        Button {
            showEmojiPicker.toggle()
        } label: {
            ZStack(alignment: .bottom) {
                ZStack(alignment: .center) {
                    Circle()
                        .fill(Color.flySecondaryBackground)
                        .frame(width: 60, height: 60)
                    Text(emoji)
                        .font(.system(size: 30))
                }
                editButton
                    .offset(y: 7)
            }
        }
        .emojiPicker(
            isPresented: $showEmojiPicker,
            selectedEmoji: $emoji
        )
    }

    /// 编辑按钮
    var editButton: some View {
        Text("编辑")
            .font(.system(size: 8, weight: .regular))
            .foregroundColor(Color.flyTextGray)
            .padding(.horizontal, 8)
            .padding(.vertical, 2)
            .background {
                RoundedRectangle(cornerRadius: 100)
                    .fill(Color.flyBackground)
                    .background {
                        RoundedRectangle(cornerRadius: 100)
                            .stroke(Color.flySecondaryBackground, lineWidth: 1)
                    }
            }
    }
}

#Preview {
    TagEditerDialogView(show: .constant(true)) { v1 in
        // 打印一下
        print(v1)
    }
}
