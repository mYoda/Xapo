// XapoTest
//    
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
// 


import Foundation
import SwiftUI


final class GitHubListViewModel: ObservableObject {
    
    @Published var expandedId: Int = GitHubListView.Const.defaultNestedItemId
    @Published var selectedLanguage: ProgrammingLanguage = .default {
        didSet {
            if !lastTwoSelected.contains(selectedLanguage) {
                updateData(with: selectedLanguage)
            }
        }
    }
    @Published var data: [RepositoryModel] = [] 
    @Published var lastTwoSelected: [ProgrammingLanguage] = [.default]
}


//MARK: - Actions
extension GitHubListViewModel {
    
    func load(with language: ProgrammingLanguage) {
        guard language != selectedLanguage || self.data.isEmpty else { return }
        Global.addLoadingOverlay()
        expandedId = -1
        //TODO: Remove delay after QA-UI tests
        delay(GitHubListView.Theme.animationDelay) {
            //TODO: Add pagination
            self.getData(for: language) {
                Global.removeLoadingOverlay()
            }
        }
    }
    
    func refresh(completion: @escaping () -> Void) {
        // temporary adding a delay just for loader animation
        //TODO: Remove delay after QA-UI tests
        delay(GitHubListView.Theme.animationDelay) {
            self.getData(for: self.selectedLanguage) {
                completion()
            }
        }
    }
    
    
    func chooseLanguagePopup() {
        
        let options = MockData.programmingLanguages.map({ ListedCellOption(title: $0.name, id: $0.id, color: .random, config: ListedCellConfig(isSelected: selectedLanguage.id == $0.id)) })
        
        Global.rootPopupsContext
            .addPopup(popup: PopupsFactory.ListedPopup
                        .make(style: .dotted,
                              data: options,
                              topBarContent: { style in style.makeTopBar(title: String.Popup.Languages.title,
                                                                         leftItem: {
                                  Buttons.text(title: String.General.cancel, font: .xapoSecretFont(size: 16, weight: .regular), textColor: .red, action: {}).asAnyView
                              })},
                              cellContent: { style, item in style.makeCell(item) },
                              onComplete: {[weak self] option in
                guard let self = self,
                      let option = option,
                      let language = MockData.programmingLanguages
                        .first(where: { $0.id == option.id })
                else { return }
                
                self.updateData(with: language)
                Haptic.impact(.light).generate()
            }))
    }
    
    private func updateData(with newLanguage: ProgrammingLanguage) {
        
        guard newLanguage != selectedLanguage else { return }
        withAnimation {
            lastTwoSelected = [newLanguage, selectedLanguage]
        }
        
        load(with: newLanguage)
    }
}


//MARK: - Networking
extension GitHubListViewModel {
    
    private func getData(for language: ProgrammingLanguage, completion: @escaping () -> Void ) {
        API.GitHub.searchRepos(language: language.name) { [weak self] result in
            async {
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    withAnimation {
                        self.data = response.items
                        self.selectedLanguage = language
                    }
                case .failure(let error):
                    Alert.showAlert(message: error.message)
                }
                completion()
            }
        }
    }
}
