//
//  KeyView.swift
//  Calculator
//
//  Created by Deep Awasthi on 20/5/24.
//

import SwiftUI

struct KeyView: View {
    
    @State var value = "0"
    @State var runningNumber = 0
    @State var currentOperation: Operation = .none
    @State private var changeColor = false
    
    var buttons : [[Keys]] = [
        [.clear, .negative, .percentage, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal]
    ]
    
    var body: some View {
        VStack{
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(changeColor ? Color("NumKey").opacity(0.2) : Color.pink.opacity(0.2))
                    .scaleEffect(changeColor ? 2.0 : 1.0)
                    .frame(width: 350, height: 280)
                    .animation(Animation.easeOut.speed(0.17).repeatForever(), value: changeColor)
                    .onAppear(perform: {
                        self.changeColor.toggle()
                    })
                    .overlay(Text(value)
                        .bold()
                        .font(.system(size: 100))
                        .foregroundColor(.black)
                )
            }
            .padding()
            ForEach(buttons, id:\.self){ row in
                HStack(spacing: 10){
                    ForEach(row, id: \.self){ element in
                        Button {
                            self.didTap(button: element)
                        } label: {
                            Text(element.rawValue)
                                .font(.system(size: 30))
                                .frame(width: self.getWidth(element: element), height: self.getHeight(element: element))
                                .background(element.ButtonColor)
                                .foregroundColor(.black)
                                .cornerRadius(30)
                                .shadow(color: .pink.opacity(0.5), radius: 30)
                        }
                    }
                }
                .padding(.bottom, 4)
            }
        }
    }
    
    func getWidth(element: Keys)->CGFloat {
        if(element == .zero){
            return (UIScreen.main.bounds.width - (5*10))/2
        }
        return (UIScreen.main.bounds.width - (5*10))/4
    }
    
    func getHeight(element: Keys)->CGFloat {
        return (UIScreen.main.bounds.width - (5*10))/5
    }
    
    func didTap(button: Keys){
        switch button {
        case .add, .subtract, .multiply, .divide, .equal:
            if(button == .add){
                self.currentOperation = .add
                self.runningNumber = Int(self.value) ?? 0
            }
            else if(button == .subtract){
                self.currentOperation = .subtract
                self.runningNumber = Int(self.value) ?? 0
            }
            else if(button == .divide){
                self.currentOperation = .divide
                self.runningNumber = Int(self.value) ?? 1
            }
            else if(button == .multiply){
                self.currentOperation = .multiply
                self.runningNumber = Int(self.value) ?? 1
            }
            else if(button == .equal){
                let runningValue = self.runningNumber
                let currentValue = Int(self.value) ?? 0
                
                switch self.currentOperation {
                case .add:
                    self.value = "\(runningValue + currentValue)"
                case .subtract:
                    self.value = "\(runningValue - currentValue)"
                case .multiply:
                    self.value = "\(runningValue * currentValue)"
                case .divide:
                    self.value = "\(runningValue / currentValue)"
                case .none:
                    break
                }
            }
            if(button != .equal){
                self.value = "0"
            }
        case .clear:
            self.value = "0"
        case .decimal, .negative, .percentage:
            if(button == .percentage){
                let percentNumber = Float(self.value) ?? 0
                let result = Int(percentNumber/100)
                self.runningNumber = result
            }
            else if(button == .negative){
                let negativeResult = Int(self.value) ?? 0
                let result = -1 * negativeResult
                self.runningNumber = result
            }
            else if(button == .decimal){
                let number = Int(self.value) ?? 0
                self.value = "\(number).0"
                self.runningNumber = number
            }
            
        default:
            let number = button.rawValue
            if(value=="0"){
                value = number
            }
            else{
                self.value = "\(self.value)\(number)"
            }
        }
    }
}


#Preview {
    KeyView()
}
