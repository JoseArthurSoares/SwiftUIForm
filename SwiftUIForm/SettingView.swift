//
//  SettingView.swift
//  SwiftUIForm
//
//  Created by Arthur Soares on 03/03/2023.
//

import SwiftUI

struct SettingView: View {
    private var displayOrder = ["Ordem alfabética", "Mostrar os favoritos primeiro", "Mostrar Check-in primeiro"]
    @State private var ordemSelecionada = 0
    @State private var showCheckInOnly = false
    @State private var maxPriceLevel = 5
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("SORT PREFERENCE")) {
                    Picker(selection: $ordemSelecionada, label: Text("Ordenar por:")) {
                        ForEach(0..<displayOrder.count, id: \.self) {
                            Text(self.displayOrder[$0])
                        }
                    }
                }
                Section(header: Text("FILTER PREFERENCE")) {
                    Toggle(isOn: $showCheckInOnly) {
                            Text("Mostrar somente Check-in")
                    }
                    Stepper(onIncrement: {
                        self.maxPriceLevel += 1
                        if self.maxPriceLevel >= 5 {
                            self.maxPriceLevel = 5
                        }
                    }, onDecrement: {
                        self.maxPriceLevel -= 1
                        if self .maxPriceLevel <= 1 {
                            self.maxPriceLevel = 1
                        }
                    }, label: {
                        Text("Mostrar \(String(repeating: "$", count: maxPriceLevel)) ou abaixo")
                    })
                }
            }
            .navigationBarTitle("Configurações")
        }
        .overlay(
            VStack {
                HStack{
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Cancelar")
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Salvar")
                    })
                }
                .padding()
                
                Spacer()
            }
        )
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
