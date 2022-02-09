//
//  ContentView.swift
//  SwiftUI Tutorial: Working with Form
//
//  Created by Alvin Sosangyo on 02/10/22.
//


import SwiftUI

struct ContentView: View {
    
    @State private var inputText: String = ""
    @State private var selectedFont: String = "Arial"
    @State private var darkMode: Bool = false
    @State private var fontSize: Int = 14
    @State private var showState: Bool = false
    
    var body: some View {
        
        ZStack {
            
            if darkMode == true {
                Color.black
                    .ignoresSafeArea(.all)
            } else {
                Color.white
            }
            
            VStack {
                
                TextEditor(text: $inputText)
                    .font(.custom(selectedFont, size: CGFloat(fontSize)))
                    .padding()
                
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
            SettingsView(selectedFont: $selectedFont, darkMode: $darkMode, fontSize: $fontSize)
        }
        
    } //body
    
} //ContentView

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct SettingsView: View {
    
    var fontList = ["Arial", "Charter", "Futura"]
    
    @Binding var selectedFont: String
    @Binding var darkMode: Bool
    @Binding var fontSize: Int
    
    
    var body: some View {
        
        NavigationView {
            
            Form {
                
                Section(header: Text("Font Style")) {
                    Picker("Font", selection: $selectedFont) {
                        ForEach(fontList, id: \.self) {
                            Text($0)
                        }
                    }
                    
                }
                
                Section(header: Text("Background")) {
                    
                    Toggle(isOn: $darkMode) {
                        Text("Dark Mode")
                    }
                    
                    Stepper("Font Size: \(fontSize)", onIncrement: {
                        fontSize += 1
                    }, onDecrement: {
                        fontSize -= 1
                    })
                    
                }
                
            } //Form
            
        } //NavigationView
        
    } //body

} //SettingsView
