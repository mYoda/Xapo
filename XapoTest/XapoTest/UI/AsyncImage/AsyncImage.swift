// XapoTest
//    
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
// 


import SwiftUI


struct AsyncImage<DefaultImage: View>: View {
    
    enum LoadingType {
        case spinner
        case emptyView
        case custom(AnyView)
        
        var view: AnyView {
            switch self {
                case .spinner: return ActivityIndicator().asAnyView
                case .emptyView: return EmptyView().asAnyView
                case .custom(let view): return view
            }
        }
    }
    
    @StateObject private var loader: ImageLoader
    private let loadingPlaceholder: AnyView
    private let image: (UIImage) -> AnyView
    private let defaultImage: DefaultImage
    
    
    init(url: URL?,
         loadingType: LoadingType = .spinner,
         @ViewBuilder image: @escaping (UIImage) -> AnyView = { Image(uiImage: $0).resizable().scaledToFill().asAnyView },
         @ViewBuilder defaultImage: () -> DefaultImage) {
        
        self.loadingPlaceholder = loadingType.view
        self.image = image
        // hack - not for duplicating
        let url = url ?? .root
        
        _loader = StateObject(wrappedValue: ImageLoader(url: url, cache: Environment(\.imageCache).wrappedValue))
        self.defaultImage = defaultImage()
    }
    
    var body: some View {
        ZStack {
            Group {
                if loader.isLoading {
                    loadingPlaceholder
                } else {
                    if let img = loader.image {
                        image(img)
                    } else {
                        defaultImage
                    }
                }
            }
        }
        .onAppear {
            loader.load()
        }
    }
}
