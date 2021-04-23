//
//  ContentView.swift
//  shuffleArrayAndOutput
//
//  Created by 钟宜江 on 2021/4/23.
//

import SwiftUI
import UIKit

//所有准备好的数组
var sortArr:[String] = ["a","b","c","d","e"]

//准备被打乱的数组
var readyArr = sortArr

//用来打乱数组的闭包
var shuffleArray = {(arr: [String]) -> [String] in
    var data: [String] = arr

    for i in 1..<arr.count {
        let index:Int = Int(arc4random()) % i
        if index != i {
            data.swapAt(i, index)
        }
    }
    return data
}

struct ContentView: View {
    //将被打乱的数组复赋值给变量test
    @State private var test:[String] = sortArr.refreshArray()
    
    //设置取的元素下标从第一个开始（第一个下标为0）
    @State private var eleNum = 0
    
    //设置输出完数组所有元素之后弹窗alert的相关变量
    @State private var showAlert = false
    @State private var alertTitle = ""
    
    //让当前元素下标加1————也就是取下一个输出
    func plus(){
        eleNum += 1
    }
    
    var body: some View {
        VStack{
            //显示当前取到的数组元素
            Text("\(test[eleNum])")
                    .padding()

            //设置刷新按钮，调用plus()函数，按顺序显示打乱之后的数组
            //如果元素下标小于元素总数-1，就继续调用plus()函数。不然就跳出弹窗，提示输出完毕，不然会崩溃
            Button(action: {
                if eleNum < test.count - 1{
                    plus()
                }else{
                    showAlert = true
                }
            }) {
                Text("刷新")
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("结束"))
        }
    }
}

//预览界面
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//对Collection功能进行扩展---使用闭包将数组readyArr打乱并且赋值给新的数组tempArr，返回该数组
extension Collection{
    func refreshArray() -> [String]{
        let tempArr = shuffleArray(readyArr)

        return tempArr
    }
}
