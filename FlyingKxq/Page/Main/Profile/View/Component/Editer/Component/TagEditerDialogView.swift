//
//  TagEditerDialogView.swift
//  FlyingKxq
//
//  Created by atom on 2025/1/22.
//

import MCEmojiPicker
import SwiftUI

struct TagEditerDialogView: View {
    @Binding var show: Bool
    let onConfirm: (ProfileTag) -> Void
    let initialTag: ProfileTag
    let onDelete: ((ProfileTag) -> Void)?

    @State var emoji: String = ""
    @State var tagName: String = ""
    @State var showEmojiPicker: Bool = false
    @State var showDatePicker: Bool = false
    @State var endTime: Date?
    @State var selectedDate = Date()

    init(show: Binding<Bool>, initialTag: ProfileTag = ProfileTag(emoji: "", name: ""), onDelete: ((ProfileTag) -> Void)? = nil, onConfirm: @escaping (ProfileTag) -> Void) {
        _show = show
        self.onConfirm = onConfirm
        self.initialTag = initialTag
        self.onDelete = onDelete
    }

    func confirm() {
        if isValid() {
            onConfirm(ProfileTag(emoji: emoji, name: tagName, endTime: endTime))
            show = false
        }
    }

    func isValid() -> Bool {
        /// endTime
        if let endTime = endTime {
            if endTime < Date() {
                print("必须为未来的时间")
                return false
            }
        } else {
            endTime = Calendar.current.date(byAdding: .day, value: 2, to: Date())
        }
        /// emoji
        if emoji.isEmpty {
            print("emoji为空")
            return false
        }
        if emoji.count != 1 {
            print("未选择Emoji")
            return false
        }
        if !emoji.first!.isEmoji {
            print("请输入正确的emoji")
            return false
        }
        /// tagName
        if tagName.count > 10 {
            print("状态名超过10个字符")
            return false
        }

        if tagName.isEmpty {
            print("状态名为空")
            return false
        }

        return true
    }

    var body: some View {
        VStack(spacing: 0) {
            FlyDialogHeaderView(
                show: $show,
                title: "修改状态",
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
                tagName = initialTag.name
                selectedDate = initialTag.endTime ?? Date()
            }
        }
    }

    /// 时间选择触发器
    var dateTriggerView: some View {
        Button {
            withAnimation(.none) {
                showDatePicker.toggle()
                selectedDate = Date()
            }
        } label: {
            FlyTextField(placeHolderText: "结束时间（默认24小时之后）", text: .constant(endTime == nil ? "" : endTime!.formatCountdownString()))
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
                endTime = selectedDate
            }
            DatePicker(selection: $selectedDate, in: dateRange, displayedComponents: [.date, .hourAndMinute]) {}
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
