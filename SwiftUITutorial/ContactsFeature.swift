//
//  ContactsFeature.swift
//  SwiftUITutorial
//
//  Created by YongJin on 9/6/24.
//

import SwiftUI
import Foundation
import ComposableArchitecture

struct Contact: Equatable, Identifiable {

    let id: UUID
    var name: String
}

@Reducer
struct ContactsFeature {

    @ObservableState
    struct State: Equatable {
        @Presents var addContact: AddContactFeature.State?
        var contacts: IdentifiedArrayOf<Contact> = []
    }

    enum Action {
        case addButtonTapped
        case addContact(PresentationAction<AddContactFeature.Action>)
    }

    var body: some ReducerOf<Self> {

        Reduce { state, action in

            switch action {

            case .addButtonTapped:
                state.addContact = AddContactFeature.State( contact: Contact(id: UUID(), name: "") )
                return .none

            case let .addContact(.presented(.delegate(.saveContact(contact)))):
                state.contacts.append(contact)
                return .none

            case .addContact:
                return .none
            }
        }
        .ifLet(\.$addContact, action: \.addContact) {
            AddContactFeature()
        }
    }
}

struct ContactsView: View {
    

    @Bindable var store: StoreOf<ContactsFeature>

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
        .sheet(item: $store.scope(state: \.addContact, action: \.addContact)) { addContactStore in
            NavigationStack {
                AddContactView(store: addContactStore)
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


struct AddContactView: View {

    @Bindable var store: StoreOf<AddContactFeature>

    var body: some View {

        Form {
            TextField("이름", text: $store.contact.name.sending(\.setName))
            Button("Save") {
                store.send(.saveButtonTapped)
            }
        }
        .toolbar {
            ToolbarItem {
                Button("Cancel") {
                    store.send(.cancelButtonTapped)
                }
            }
        }
    }
}

