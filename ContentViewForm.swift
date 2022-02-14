//
//  ContentView.swift
//  SwiftUI Tutorial: Working with Form
//
//  Created by Alvin Sosangyo on 02/14/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var inputText: String = ""
    @State private var showState: Bool = false
    @State private var selectedFont: String = "Arial"
    @State private var darkMode: Bool = false
    @State private var fontSize: Int = 14
    
    var body: some View {
        
        ZStack {
            
            if darkMode == true {
                Color.black.ignoresSafeArea(.all)
            }
            
            VStack {
                
                TextEditor(text: $inputText)
                    .padding()
                    .font(.custom(selectedFont, size: CGFloat(fontSize)))
                
                Button(action: {
                    showState.toggle()
                }) {
                    Image(systemName: "gear")
                        .font(.system(size: 50))
                        .foregroundColor(darkMode ? .white : .black)
                        .background(darkMode ? .black : .white)
                }
                
                Spacer()
                
            } //VStack
            
        } //ZStack
        .sheet(isPresented: $showState) {
            SettingsView(selectedFont: $selectedFont, fontSize: $fontSize, darkMode: $darkMode)
        }
        
    } //body
    
} //ContentView

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SettingsView: View {
    
    let fontList = ["Arial", "Charter", "Futura"]
    @Binding var selectedFont: String
    @Binding var fontSize: Int
    @Binding var darkMode: Bool
    
    var body: some View {
        
        NavigationView {
            
            Form {
                
                Section(header: Text("Font")) {
                    
                    Picker("Font Style", selection: $selectedFont) {
                        ForEach(fontList, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    Stepper("Font Size: \(fontSize)", value: $fontSize, in: 7...30)
                    
                }
                
                Section(header: Text("Background")) {
                    
                    Toggle("Dark Mode", isOn: $darkMode)
                    
                }
                
            } //Form
            
        } //NavigationView
        
    } //body
    
} //SettingsView

