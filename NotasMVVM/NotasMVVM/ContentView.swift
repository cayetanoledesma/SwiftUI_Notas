//
//  ContentView.swift
//  NotasMVVM
//
//  Created by estech on 6/3/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var descriptionNote: String = ""
    
    @StateObject var notesViewModel = NotesViewModel()
    
    var body: some View {
     
        NavigationView{
            VStack{
                Text("Crear una nota")
                    .underline()
                    .foregroundColor(Color.blue)
                TextEditor(text: $descriptionNote)
                    .frame(height:100)
                    .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.blue, lineWidth: 2)
                )
                
                    .padding(.horizontal, 12)
                Button("Crear"){
                    
                    notesViewModel.saveNote(description: descriptionNote)  // Guarda la nota
                   
                    descriptionNote = ""
                }
                
                .buttonStyle(.bordered)
                .tint(.blue)
                Spacer()
                
                List{
                    ForEach($notesViewModel.notes, id: \.id){ $nota in
                        HStack{
                            if nota.isFavorite {
                                Label(nota.description, systemImage: "star.fill")
                            }else {
                                Text(nota.description)
                            }
                    
                        }
                        .swipeActions(edge: .leading){
                            Button {
                                notesViewModel.updateFavoriteNote(note: $nota)
                            }
                        label: {
                            Label("Favorito", systemImage: "star.fill")
                        }
                        .tint(.blue)
                        }
                        
                        .swipeActions(edge: .trailing){
                            Button {
                                notesViewModel.remoteNote(withId: nota.id)
                            }
                        label: {
                            Label("Borrar", systemImage: "trash.fill")
                        }
                        .tint(.red)
                        }
                        
                    }
                }
            }
            .navigationTitle("Notas")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                Text(notesViewModel.getNumberNotes())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
