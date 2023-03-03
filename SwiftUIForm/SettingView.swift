//
//  SettingView.swift
//  SwiftUIForm
//
//  Created by Arthur Soares on 03/03/2023.
//

import SwiftUI

struct SettingView: View {
    var settingStore: SettingStore
    @State private var selectedOrder = DisplayOrderType.alphabetical
    @State private var showCheckInOnly = false
    @State private var maxPriceLevel = 5
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("SORT PREFERENCE")) {
                    Picker(selection: $selectedOrder, label: Text("Ordenar por:")) {
                        ForEach(DisplayOrderType.allCases, id: \.self) { orderType in
                            Text(orderType.text)
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
                        self.settingStore.showCheckInOnly = self.showCheckInOnly
                        self.settingStore.displayOrder = self.selectedOrder
                        self.settingStore.maxPriceLevel = self.maxPriceLevel
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Salvar")
                    })
                }
                .padding()
                
                Spacer()
            }
        )
        .onAppear {
            self.selectedOrder = self.settingStore.displayOrder
            self.showCheckInOnly = self.settingStore.showCheckInOnly
            self.maxPriceLevel = self.settingStore.maxPriceLevel
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(settingStore: SettingStore())
    }
}
