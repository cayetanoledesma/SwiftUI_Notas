//
//  NotesViewModel.swift
//  NotasMVVM
//
//  Created by estech on 6/3/23.
//

import Foundation
import SwiftUI

final class NotesViewModel: ObservableObject {
    @Published var notes: [NoteModel] = []
    
    private let userDeafaults: UserDefaults = .standard
    
    
    //Al pulsar el botón de crear se llama a este método
    func saveNote(description: String){
        let newNote = NoteModel(description: description)
        
        //Insertamos la nota en el array
        notes.insert(newNote, at: 0)
        
        encodeAndSaveAllNotes()
    }
    
    //Codifica las notas y las almacena en UserDefault
    
    private func encodeAndSaveAllNotes(){
        if let encoded = try? JSONEncoder().encode(notes){
            userDeafaults.set(encoded, forKey: "notes")
        }
    }
    
    //Recuperar las notas de UserDefaults
    
    func getAllNotes() -> [NoteModel] {
        if let notesData = userDeafaults.object(forKey: "notes") as? Data {
            if let notes = try? JSONDecoder().decode([NoteModel].self, from: notesData) {
                
            }
        }
        return []
    }
    
    //Eliminar la nota
    
    func remoteNote(withId id: String){
        notes.removeAll(where: { $0.id == id})
        
        encodeAndSaveAllNotes()
    }
    
    //Marcar/Desmarcar como favorito
    
    func updateFavoriteNote(note: Binding<NoteModel>){
        note.wrappedValue.isFavorite = !note.wrappedValue.isFavorite
        encodeAndSaveAllNotes()
    }
    func getNumberNotes()->String{
        "\(notes.count)"
    }
  
}

