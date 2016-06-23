//
//  UITextView_SizingTests.swift
//  UITextView-SizingTests
//
//  Created by Diego Sanchez on 11/05/2016.
//  Copyright © 2016 Diego. All rights reserved.
//

import XCTest
@testable import UITextView_Sizing

class UITextView_SizingTests: XCTestCase {

    var textView: UITextView!
    override func setUp() {
        super.setUp()
        let textView = UITextView()
        textView.dataDetectorTypes = .None
        textView.textContainerInset = UIEdgeInsetsZero
        textView.layoutManager.allowsNonContiguousLayout = true
        textView.textContainer.lineFragmentPadding = 0
        self.textView = textView
    }
    
    override func tearDown() {
        self.textView = nil
        super.tearDown()
    }

    func testUITextViewSizing() {
        self.iterateTestCases { (font, text, maxSize) -> Bool in
            let textView = self.textView
            let textViewSize = sizeWithTextView(textView, text: text, font: font, maxSize: maxSize)
            let layoutManagerSize = sizeWithLayoutManager(text, font: font, maxSize: maxSize)
            return textViewSize.bma_equal(layoutManagerSize)
        }
    }

    private func iterateTestCases(withBlock block: (font: UIFont, text: String, maxSize: CGSize) -> Bool) {
        let totalTestCases = fonts().count * widths().count * evilStrings().reduce(0, combine: { $0 + $1.characters.count })
        var testCase = 1
        outer: for font in fonts() {
            for evilText in evilStrings() {
                for count in 0..<evilText.characters.count {
                    let indexEndOfText = evilText.endIndex.advancedBy(-count)
                    let text = evilText.substringToIndex(indexEndOfText)
                    for maxWidth in widths() {
                        var success = true
                        autoreleasepool({
                            print("Executing test case \(testCase)/\(totalTestCases)")
                            let maxSize = CGSize(width: maxWidth, height: .max)
                             success = block(font: font, text: text, maxSize: maxSize)
                            XCTAssert(success, "Failed!! text:\(text), font:\(font), maxSize:\(maxSize)")
                            testCase += 1
                        })

                        if (!success) {
                            break outer
                        }
                    }
                }
            }
        }
    }
}

private func fonts() -> [UIFont] {
    return [
        UIFont.systemFontOfSize(16),
    ]
}

private func widths() -> [CGFloat] {
    var widths = [CGFloat]()
    let scaleInv = 1 / UIScreen.mainScreen().scale
    let minWidth: CGFloat = 90
    let maxWidth: CGFloat = 200
    var currentWidth = minWidth
    var i = 0
    while currentWidth < maxWidth {
        widths += [currentWidth]
        i += 1
        currentWidth = minWidth + CGFloat(i) * scaleInv
    }
    return widths
}

private func evilStrings() -> [String] {
    return [
        "Ｔｈｅ ｑｕｉｃｋ ｂｒｏｗｎ ｆｏｘ ｊｕｍｐｓ ｏｖｅｒ ｔｈｅ ｌａｚｙ ｄｏｇ\n𝐓𝐡𝐞 𝐪𝐮𝐢𝐜𝐤 𝐛𝐫𝐨𝐰𝐧 𝐟𝐨𝐱 𝐣𝐮𝐦𝐩𝐬 𝐨𝐯𝐞𝐫 𝐭𝐡𝐞 𝐥𝐚𝐳𝐲 𝐝𝐨𝐠𝕿𝖍𝖊 𝖖𝖚𝖎𝖈𝖐 𝖇𝖗𝖔𝖜𝖓 𝖋𝖔𝖝 𝖏𝖚𝖒𝖕𝖘 𝖔𝖛𝖊𝖗 𝖙𝖍𝖊 𝖑𝖆𝖟𝖞 𝖉𝖔𝖌\n𝑻𝒉𝒆 𝒒𝒖𝒊𝒄𝒌 𝒃𝒓𝒐𝒘𝒏 𝒇𝒐𝒙 𝒋𝒖𝒎𝒑𝒔 𝒐𝒗𝒆𝒓 𝒕𝒉𝒆 𝒍𝒂𝒛𝒚 𝒅𝒐𝒈𝓣𝓱𝓮 𝓺𝓾𝓲𝓬𝓴 𝓫𝓻𝓸𝔀𝓷 𝓯𝓸𝔁 𝓳𝓾𝓶𝓹𝓼 𝓸𝓿𝓮𝓻 𝓽𝓱𝓮 𝓵𝓪𝔃𝔂 𝓭𝓸𝓰\n𝕋𝕙𝕖 𝕢𝕦𝕚𝕔𝕜 𝕓𝕣𝕠𝕨𝕟 𝕗𝕠𝕩 𝕛𝕦𝕞𝕡𝕤 𝕠𝕧𝕖𝕣 𝕥𝕙𝕖 𝕝𝕒𝕫𝕪 𝕕𝕠𝕘\n𝚃𝚑𝚎 𝚚𝚞𝚒𝚌𝚔 𝚋𝚛𝚘𝚠𝚗 𝚏𝚘𝚡 𝚓𝚞𝚖𝚙𝚜 𝚘𝚟𝚎𝚛 𝚝𝚑𝚎 𝚕𝚊𝚣𝚢 𝚍𝚘𝚐\n⒯⒣⒠ ⒬⒰⒤⒞⒦ ⒝⒭⒪⒲⒩ ⒡⒪⒳ ⒥⒰⒨⒫⒮ ⒪⒱⒠⒭ ⒯⒣⒠ ⒧⒜⒵⒴ ⒟⒪⒢",
        "駓駗鴀 珿祪 煻, 硻禂稢 脀蚅蚡 蔝蓶 賗 虥諰 壾嵷幓 蠿饡驦 摓, 暲 羳蟪蠁 秎穾籺 藽轚酁 昢炾 蔍 萷葋蒎 熿熼燛 緷緦, 滈溔滆 螒螝螜 姴怤昢 鑆驈 瑽, 讘麡 絼 轒醭鏹 嗛嗕塨 豲貕貔 檓檌 硻禂稢 鼥儴壛 踙 摨敹暯 蠬襱覾 雥齆犪 楋 毚丮, 孻憵懥 耜僇鄗 憢憉 慛, 钀钁 慛 鏊",
        "Lorem ipsum dolor sit amet 😇, https://github.com/badoo/Chatto consectetur adipiscing elit , sed do eiusmod tempor incididunt 07400000000 📞 ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute ir incoming:incoming, #:7",
        "Говори мне что я уже и не надо так говорить о своих о том же что как только мы я он не был хочет может и нет не правда это не или нет и нет ни одного не человека из них были не в курсе что в этом результате которого я в шоке с от была в школе шоке том числе в и на этом месте фоне моменте я уже не будет в ни одного человека из головы не вылетело и я тебя люблю я и щне не в знаю почему но так лень идти вставать и идти ехать домой и в с шах планете в том числе и на этот раз счёт в серии банке в можно взять шаг в этом сторону от и утр в и не только в надо будет было не в состоянии здоровья тебе в не в состоянии здоровья в тебе не кажется нравится этот день раз по эксплуатации на автомобиля и не только на один день из в контакте",
        "Lorem ipsum dolor sit amet 😇, https://github.com/badoo/Chatto consectetur adipiscing elit , sed do eiusmod tempor ੨ 07400000000 📞 ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute ir incoming:incoming, #:7",
        "orem ipsum ехать dolor sit amet 😇\nasdf werwerwqer ехать 😈orem ipsum ехать dolor sit amet 😇\nasdf werwerwqer ехать 😈orem ipsum ехать dolor sit amet 😇\nasdf werwerwqer ехать 😈",
    ]
}

private func sizeWithLayoutManager(text: String, font: UIFont, maxSize: CGSize) -> CGSize {
    let textContainer = NSTextContainer(size: maxSize)
    let layoutManager = NSLayoutManager()
    let attributedStering = replicateAttributedStringSetByUITextView(text, font: font, color: UIColor.redColor())
    let textStorage = NSTextStorage(attributedString: attributedStering)
    textContainer.lineFragmentPadding = 0
    layoutManager.addTextContainer(textContainer)
    textStorage.addLayoutManager(layoutManager)
    return layoutManager.usedRectForTextContainer(textContainer).size.bma_round()
}

private func replicateAttributedStringSetByUITextView(text: String, font: UIFont, color: UIColor) -> NSTextStorage {
    let attributes = [
        NSFontAttributeName: font,
        NSForegroundColorAttributeName: color,
        "NSOriginalFont": font,
    ]
    let textStorage = NSTextStorage(string: text, attributes: attributes)
    return textStorage
}

private func sizeWithTextView(textView: UITextView, text: String, font: UIFont, maxSize: CGSize) -> CGSize {
    textView.font = font
    textView.textColor = UIColor.redColor()
    textView.text = text
    return textView.sizeThatFits(maxSize).bma_round()
}

extension CGSize {
    func bma_round() -> CGSize {
        return CGSize(width: self.width.bma_round(), height: self.height.bma_round())
    }
}

extension CGFloat {
    func bma_round() -> CGFloat {
        let scale = UIScreen.mainScreen().scale
        return ceil(self * scale) * (1.0 / scale)
    }
}

extension CGSize {
    func bma_equal(other: CGSize) -> Bool {
        return abs(self.width - other.width) < 0.001 && abs(self.height - other.height) < 0.001

    }
}
