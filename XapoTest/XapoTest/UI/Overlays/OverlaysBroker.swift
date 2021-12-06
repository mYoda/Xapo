// XapoTest
//    
// Created by Anton Nechayuk © 
// with 🧡 for Xapo in 2021
// 


import Foundation
import SwiftUI


final class OverlaysBroker: ObservableObject {
    
    struct Overlay: Identifiable {
        let id: UUID
        let view: AnyView
        
        init(id: UUID = UUID(), view: AnyView) {
            self.id = id
            self.view = view
        }
    }
        
    @Published var overlays: [Overlay] = []
    
    func addOverlay<V: View>(view: V) -> UUID {
        let overlayInfo = Overlay(view: view.asAnyView)
        overlays.append(overlayInfo)
        return overlayInfo.id
    }
    
    func addOverlay<V: View>(view: V, id: UUID) {
        let overlayInfo = Overlay(id: id, view: view.asAnyView)
        overlays.append(overlayInfo)
    }
    
    func removeOverlay(id: UUID) {
        overlays = overlays.filter { $0.id != id }
    }
    
    func removeAll() {
        overlays.removeAll()
    }
}
