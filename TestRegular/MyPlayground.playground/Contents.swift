import UIKit

let content = #"""
寧城！
　　劉峰一撅一拐的走在了馬路之上，身上的衣物早已經是濘淪不堪，甚是一副慘敗的盡顯，街道小販的喧囂聲卻與劉峰那偉岸的身影顯得格格不入。

　　但那如刀削般的臉龐之上，那雙眸子之中更是閃着不同尋常的精光，深邃而顯精明，雖然身上滿是瘀傷，那樣骨子威武勁兒卻始終的告訴着自己的敵人，自己是打不敗的。
“喲，這不是我們劉家大天才嗎？怎麼這幅氣敗像啊？”
　　只見此刻從劉峰的身後走過來了一群人，為首的身穿綾羅綢緞 ，眼神之中不時的閃過一絲狡詐之色，宛如是每時每刻肚子之中都在打着壞水一般。
　　此刻的劉峰緊緊的握住了拳頭，自己身上的瘀傷無不是這些人造成的。
　　“喲，你怎麼？難道大哥你這是想要打我不成？你父親是廢物，你更是廢物。”
"""#

let regex = #"\n(\s*)"#
let expression = try NSRegularExpression(pattern: regex, options: [])
let results = expression.matches(in: content, options: [], range: NSRange(location: 0, length: content.count))

for text in results {
    print(text.range)
}

let newContent = content.replacingOccurrences(of: #"\n(\s*)"#, with: "\n　　", options: .regularExpression)
//
print(content)
print(newContent)
