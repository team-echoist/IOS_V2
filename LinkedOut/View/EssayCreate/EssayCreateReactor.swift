//
//  TemplateReactor.swift
//  Foodinko
//
//  Created by 정윤호 on 2020/01/07.
//  Copyright © 2020 정윤호. All rights reserved.
//


import Foundation
import ReactorKit
import RxCocoa
import RxSwift
import Moya


public final class EssayCreateReactor: Reactor {
    
    
    private let startLoading = Observable<Mutation>.just(.setLoading(true))
    private let endLoading = Observable<Mutation>.just(.setLoading(false))
    
    public enum Action {
        case inputCancel
        case inputSave
        case inputTitleField(String)
        case inputSelectedText(String)
        case inputContent(String) // 단순 string만 입력
        case inputContentField(NSAttributedString, NSRange)
        case inputEditText(EssayCreateModel.EssayTextEditType, NSRange)
        case inputTempSave
        case inputHideEdit
        
        case keyboardStateChanged(height: CGFloat, isVisible: Bool)
    }
    
    public enum Mutaion {
        case setLoading(Bool)
        case setError(Tracked<LinkedOutError>?)
        case setAlert(Tracked<LocalizeString>?)
        case setMessage(Tracked<String>?)
        
        case setTitleField(String)
        case setContent(String)
        case setContentField(NSAttributedString, NSRange)
        case editContentField(EssayCreateModel.EssayTextEditType, NSRange)
        case setSelectedContentText(String)
        
        case setKeyboardState(height: CGFloat, isVisible: Bool)
    }
    
    public struct State {
        public var isLoading: Bool = false
        public var error: Tracked<LinkedOutError>?
        public var alert: Tracked<LocalizeString>?
        public var message: Tracked<String>?
        
        public var title: String = ""
        public var content: String = ""
        public var contentAttribute: NSMutableAttributedString = NSMutableAttributedString(string: "")
        public var selectedContent: String = ""
        public var status: EssayStatus?
        public var latitude: Double?
        public var logintude: Double?
        public var thumbnail: String?
        public var location: String?
        public var tags: [String]?
        
        var keyboardHeight: CGFloat = 0
        var isKeyboardVisible: Bool = false
    }
    
    // MARK: State
    
    public let initialState = State()
    
    // MARK: View Model
    
    fileprivate let essayViewModel: EssayViewModelType
    
    // MARK: Initialize
    
    public init(essayViewModel: EssayViewModelType) {
        self.essayViewModel = essayViewModel
    }
    
    // MARK: Mutate
    
    public func mutate(action: Action) -> Observable<Mutaion> {
        
        switch action {
        case .inputCancel:
            SceneDelegate.shared.router.routeDismiss(animated: true, completionHandler: nil)
            return .empty()
        case .inputSave:
            return self.getPostEssay(start: self.startLoading, end: self.endLoading)
        case .inputTitleField(let title):
            return .just(.setTitleField(title))
        case .inputSelectedText(let selectedText):
            return .just(.setSelectedContentText(selectedText))
        case .inputContent(let content):
            return .just(.setContent(content))
        case .inputContentField(let content, let range):
            return .just(.setContentField(content, range))
        case .keyboardStateChanged(height: let height, isVisible: let isVisible):
            return .just(.setKeyboardState(height: height, isVisible: isVisible))
        case .inputEditText(let editType, let range):
            return .just(.editContentField(editType, range))
        case .inputTempSave:
            // TODO: 임시저장 로그 추가
            return .empty()
        case .inputHideEdit:
            return .empty()
        }
        
    }
    
    // MARK: Reduce
    
    public func reduce(
        state: EssayCreateReactor.State,
        mutation: EssayCreateReactor.Mutaion
    ) -> EssayCreateReactor.State {
        
        var newState = state
        
        switch mutation {
        case let .setLoading(isLoading): newState.isLoading = isLoading; return newState
        case let .setError(error): newState.error = error; return newState
        case let .setAlert(alert): newState.alert = alert; return newState
        case let .setMessage(message): newState.message = message; return newState
            
        case let .setTitleField(title): newState.title = title; return newState
        case let .setContent(content): newState.content = content; return newState
        case let .setContentField(content, range):
            let htmlData = try? content.data(from: range, documentAttributes: [.documentType: NSAttributedString.DocumentType.html])
            let htmlString = String(data: htmlData!, encoding: .utf8)
            newState.content = self.generateHTML(text: content)//htmlString ?? ""
            return newState
        case let .editContentField(type, range):
            let attributedText = NSMutableAttributedString(attributedString: self.currentState.contentAttribute)

            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.red // 예: 텍스트 색상 변경
            ]
//            
            attributedText.addAttributes(attributes, range: range)
            
            let htmlData = try? attributedText.data(from: NSRange(location: 0, length: attributedText.length), documentAttributes: [.documentType: NSAttributedString.DocumentType.html])
            let htmlString = String(data: htmlData!, encoding: .utf8)
            newState.content = self.generateHTML(text: attributedText)//htmlString ?? ""
            return newState
        case let .setSelectedContentText(content):
            newState.selectedContent = content
            return newState
        case let .setKeyboardState(height, isVisible):
            newState.keyboardHeight = height
            newState.isKeyboardVisible = isVisible
            return newState
        }
    }
    
    // MARK: - Fetch
    
    private func getPostEssay(
        start: Observable<Mutaion>,
        end: Observable<Mutaion>
    ) -> Observable<Mutaion> {
        guard !self.currentState.isLoading else { return .empty() }
        
        guard self.currentState.title.isEmpty else {
            return .just(.setError(makeError(LinkedOutError(title: "제목을 입력하지 않았습니다.", code: 400))))
        }
        
//        guard self.currentState.content.isEmpty else {
//            return .just(.setError(makeError(LinkedOutError(title: "내용을 입력하지 않았습니다.", code: 400))))
//        }
//        
//        let htmlData = try? self.currentState.contentAttribute.data(from: NSRange(location: 0, length: content.length), documentAttributes: [.documentType: NSAttributedString.DocumentType.html])
//        let htmlString = String(data: htmlData!, encoding: .utf8)
//        let content = self.generateHTML(text: content)//htmlString ?? ""
                
        let title = self.currentState.title
        let content = self.currentState.content
        
        let data = EssayCreateData(title: title, content: content, status: .published)
        
        let action = self.essayViewModel.postEssays(essayCraeteData: data)
            .asObservable()
            .map { (response) -> Mutaion in
                return .setLoading(false)
            }
            .catch { (error) in
                log.error(error)
                return .just(.setError(makeError(LinkedOutError(error))))
            }
        
        return .concat([start, action, end])
    }
    
    // MARK: - Function
    
    func generateHTML(text: NSAttributedString) -> String {
        let mutableAttrString = NSMutableAttributedString(attributedString: text)
        var html = ""
        mutableAttrString.enumerateAttributes(in: NSRange(location: 0, length: mutableAttrString.length), options: []) { (attributes, range, _) in
            var substring = mutableAttrString.attributedSubstring(from: range).string
            var style = "style=\""
            
            if let font = attributes[.font] as? UIFont {
                style += "font-size: \(font.pointSize)px;"
                if font.fontDescriptor.symbolicTraits.contains(.traitBold) {
                    style += "font-weight: bold;"
                }
                if font.fontDescriptor.symbolicTraits.contains(.traitItalic) {
                    style += "font-style: italic;"
                }
            }
            
            if let strikethrough = attributes[.strikethroughStyle] as? Int, strikethrough != 0 {
                style += "text-decoration: line-through;"
            }
            
            substring = substring.replacingOccurrences(of: "\n", with: "<br>")
            
            style += "\""
            html += "<span \(style)>\(substring)</span>"
        }
        
        return "<p>\(html)</p>"
    }
    
    public func changeTextStyle(type: EssayCreateModel.EssayTextEditType, text: String) {
        
    }
}
