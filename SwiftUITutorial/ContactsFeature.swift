//
//  ContactsFeature.swift
//  SwiftUITutorial
//
//  Created by YongJin on 9/6/24.
//

import Foundation
import ComposableArchitecture

struct Contact: Equatable, Identifiable {

    let id: UUID
    let name: String
}

@Reducer
struct ContactsFeature {

    @ObservableState
    struct State: Equatable {

        var contacts: IdentifiedArrayOf<Contact> = []
    }

    enum Action {
        case addButtonTapped
    }

    var body: some ReducerOf<Self> {

        Reduce { state, action in

            switch action {

            case .addButtonTapped:
                return .none
            }
        }
    }
}


import SwiftUI

struct ContactsView: View {
    
    let store: StoreOf<ContactsFeature>

    var body: some View {
        NavigationStack {
            List {
                ForEach(store.contacts) { contact in
                    Text(contact.name)
                }
            }
            .navigationTitle("Contacts")
            .toolbar {
                ToolbarItem {

                    Button {
                        store.send(.addButtonTapped)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}


#Preview {
    ContactsView(store: Store(initialState: ContactsFeature.State(contacts: [
        Contact(id: UUID(), name: "영업팀"),
        Contact(id: UUID(), name: "운영팀") ,
        Contact(id: UUID(), name: "개발팀")])) {
            ContactsFeature()
        })
}
