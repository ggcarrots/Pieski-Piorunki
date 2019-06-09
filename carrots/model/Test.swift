//
//  Test.swift
//  carrots
//
//  Created by Paweł Czerwiński on 08/06/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import Foundation
import RxSwift


class AppModel {
    static let instance: AppModel = AppModel()
    
    private init() {}
    
    let _logicLevel: BehaviorSubject<TamagochLevel> = BehaviorSubject<TamagochLevel>(
        value: .level0
    )
    
//    var logicLevel: Observable<Double> { return _logicLevel }
    private(set) var currentLogicLevel: Double = 1.0 {
        didSet {
            _logicLevel.onNext( TamagochLevel.level(for: currentLogicLevel) )
        }
    }
    
    
    
    func addResult(answers: TestResult) {
        switch answers.state {
        case .tragic:
            currentLogicLevel = max(currentLogicLevel - 0.5, 1.0)
        case .neutral:
            break
        case .ok:
            currentLogicLevel = min(currentLogicLevel + 0.5, 2.0)
        }
    }
    
    let _displiedLevel: BehaviorSubject<TamagochLevel> = BehaviorSubject<TamagochLevel>(
        value: .level0
    )
    
//    var displiedLevel: Observable<Double> { return _displiedLevel }
    private(set) var currentDispliedLevel: Double = 1.0 {
        didSet {
            _displiedLevel.onNext(TamagochLevel.level(for: currentDispliedLevel))
        }
    }
    
    func updateDisplied(level: Double) {
        currentDispliedLevel = level
    }
    
}


struct Test {
    let questions: [Question]
    
    static var t1: Test {
        return Test(
            questions: [
                Question.qk1,
                Question.qk2,
                Question.qk3,
                Question.qk4,
                Question.qk5,
                Question.qk6,
                Question.qk7,
                Question.qk8,
                Question.qk9,
            ]
        )
    }
}


struct Info {
    let title: String
    let text: String
    
    
    
    
    static let i1: Info = Info(
        title: "Mathew Rojansky about Geopolitical Implications of a New Era on the Korean Peninsula",
        text: """
        <p>This is definitely a matter of historical and political significance for Moscow in the vein of many other partner and client states around the world, including ones in which Russia has been very actively engaged in the last few post-soviet decades. But that doesn’t necessarily lead to any particular scenario for Russian involvement going forward. Russia is very flexible, very opportunistic in its current engagement, and I would say seeks a degree of balance that might be surprising given the history.”
        “The idea that the Russians have an end game for which they would like to take responsibility is actually higher risk than any of the diplomacy we’ve seen from Moscow towards North Korea thus far. It’s far lower risk for the Russians to wait, to let the Chinese be in a more burden-bearing position from the kind of sponsors and friends from Pyongyang’s side, and to absolutely let U.S. diplomacy play out.”
        “The Russian's interest in the Korean peninsula are not inherently incompatible with what the United States would like to see. Continuity, exchange, some type of normalization and obviously a formal end to the war are all consistent with Russia’s desire to be a player in East Asia, both in economic terms… as well as in security and political terms.”
        </p>
        
        
        """
    )
    
    static let i2: Info = Info(
        title: "Zależność zmiennych losowych.",
        text: """
        <p>Częstym błędem jest przyjmowanie, że zmienne silnie nawet skorelowane są związane jakimś związkiem przyczynowo-skutkowym, tym mocniejszym, im korelacja większa. Uświadamia to taki oto przykład: dźwięk dworcowego zegara wybijającego godzinę pierwszą jest niezwykle silnie skorelowany z odjazdem pociągu o 1:00 ze stacji, nie jest on jednak żadną przyczyną ruchu – i odwrotnie, odjazd pociągu nie jest przyczyną dźwięku. W tym wypadku mamy jedynie do czynienia ze współwystępowaniem zjawisk, a nie związkiem przyczynowo-skutkowym. W związku z tym jeśli czynnik A (np. wykształcenie) i czynnik B (np. zarobki) korelują ze sobą, to powinno się tworzyć przynajmniej kilka hipotez na temat ewentualnego związku przyczynowego między nimi: </p>
        <p>1. Czynnik A wpływa na czynnik B. Tu: wykryto związek między zarobkami a wykształceniem, bo wyższe wykształcenie powoduje że dana osoba więcej zarabia.</p>
        <p>2. Czynnik B wpływa na czynnik A. Tu: ludzie zamożniejsi mają lepszy dostęp do wykształcenia i dlatego istnieje związek między zarobkami a wykształceniem.</p>
        <p>3. Jednocześnie A wpływa na B i B na A Tu: z jednej strony ludzie zamożniejsi mają lepszy dostęp do wykształcenia, ale z drugiej ludzie lepiej wykształceni mają lepsze zarobki.</p>
        <p>4. Istnieje czynnik C niezidentyfikowany w badaniu, który koreluje z A i z B. Tu: miejsce zamieszkania (lub ambicje) mogą być czynnikiem, który z jednej strony powoduje, że ktoś więcej zarabia, a z drugiej, że ma wyższe wykształcenie.</p>
        """
    )
}


struct Question {
    let text: String
    let answers: [String]
    let corrextAnswer: Answer
    let category: NewsCategory
    
    
    init(
        text: String,
        answers: [String],
        correctAnswers: Set<Int>,
        category: NewsCategory
    ) {
        self.text = text
        self.answers = answers
        self.corrextAnswer = answers.indices.map {
            correctAnswers.contains($0)
        }
        self.category = category
    }
    
    
    typealias Answer = [Bool]
    
    
    func answered(selectedIndexes: [Int]) -> AnsweredQuestion {
        let seleced: Set<Int> = Set<Int>(selectedIndexes)
        let answer: Answer = answers.indices.map { seleced.contains($0) }
        return AnsweredQuestion(question: self, answer: answer)
    }
    
    
    func isCorrect(answer: Answer) -> Bool {
        guard answers.count == answer.count else {
            fatalError("answer not compatibile with this question")
        }
        return corrextAnswer == answer
    }
    
    
    static let q1: Question = Question(
        text: "G jest grafem spójnym o n > 2 wierzchołkach i takim, że każda jego krawędź należy do pewnego cyklu prostego. Wynika z tego, że",
        answers: [
            "G ma cykl Hamiltona.",
            "graf otrzymany przez usunięcie z G jednego wierzchoaka jest spójny."
        ],
        correctAnswers: [1],
        category: .mathematics
    )
    
    static let q2: Question = Question(
        text: "G jest grafem spójnym o n > 2 wierzchołkach i takim, że każda jego krawędź należy do pewnego cyklu prostego. Wynika z tego, że",
        answers: [
            "G ma cykl Hamiltona.",
            "graf otrzymany przez usunięcie z G jednego wierzchoaka jest spójny.",
            "ciekawe czy zombie jedzą pasztet.",
            "nie rozumiem o co mnie pytasz.",
            "ziemniaki podrożeją.",
            "G ma cykl Eulera.",
        ],
        correctAnswers: [1, 5],
        category: .mathematics
    )
    
    static let q_rp: Question = Question(
        text: "Wrzucamy losowo dwie kule do dwóch urn. Wartość oczekiwana liczby niepustych urn jest równa",
        answers: [
            "1",
            "1.5",
            "1.(3)",
        ],
        correctAnswers: [1],
        category: NewsCategory.mathematics
    )
    
    
    
    static let qk1: Question = Question(
        text: "According to the United Nations’ Register of Conventional Arms, which of these countries exported the most tanks between 1992 and 2013?",
        answers: [
            "China",
            "The United States",
            "Russia",
            "Germany",
        ],
        correctAnswers: [1],
        category: NewsCategory.politology
    )
    
    static let qk2: Question = Question(
        text: "On June 4, what controversial bill passed its first reading in the Kyrgyz parliament?",
        answers: [
            "Anti-gay propaganda law",
            "Amendments to the Water Code",
            "Foreign agents bill",
            "A declaration making Friday a weekend day",
        ],
        correctAnswers: [2],
        category: NewsCategory.politology
    )
    
    static let qk3: Question = Question(
        text: "Which prominent Asian politician and leader is expected to visit China next week?",
        answers: [
            "Aung San Suu Kyi",
            "Rahul Gandhi",
            "Tsai Ing-wen",
            "Mullah Omar",
        ],
        correctAnswers: [0],
        category: NewsCategory.politology
    )
    
    static let qk4: Question = Question(
        text: "What initiative did U.S. Defense Secretary Ashton Carter announce at the 2015 Shangri-La Dialogue in Singapore?",
        answers: [
            "A U.S.-ASEAN intelligence sharing arrangement",
            "A 'Democracies United Against China' initiative",
            "A Southeast Asia Maritime Security initiative",
            "A collective security arrangement with ASEAN",
        ],
        correctAnswers: [2],
        category: NewsCategory.politology
    )
    
    static let qk5: Question = Question(
        text: "In which country are the ruins of the ancient city of Merv now located?",
        answers: [
            "Uzbekistan",
            "Iran",
            "Turkmenistan",
            "Tajikistan",
        ],
        correctAnswers: [2],
        category: NewsCategory.politology
    )
    
    static let qk6: Question = Question(
        text: "According to the Asian Development Bank (ADB), what is the greatest obstacle to foreign investment in Cambodia’s economy?",
        answers: [
            "Prime Minister Hun Sen's tendency to make controversial remarks",
            "The country's deep energy shortfall",
            "High levels of corruption within the Cambodian government",
            "Better investment prospects in neighboring Vietnam and Thailand",
        ],
        correctAnswers: [1],
        category: NewsCategory.politology
    )
    
    static let qk7: Question = Question(
        text: "Which country did Indian Prime Minister Narendra Modi visit for the first time last week?",
        answers: [
            "Myanmar",
            "Mexico",
            "Bangladesh",
            "Indonesia",
        ],
        correctAnswers: [2],
        category: NewsCategory.politology
    )
    
    static let qk8: Question = Question(
        text: "The United States government recently suffered a data breach–suspected to have been perpetrated by China-backed hackers. What information was stolen in the breach?",
        answers: [
            "Top secret information relating to the U.S. Navy's plans in the South China Sea",
            "The personal information of 4 million current and former U.S. government employees",
            "Sensitive information on the U.S. nuclear arsenal",
            "The phone metadata information of over 100 million U.S. citizens",
        ],
        correctAnswers: [1],
        category: NewsCategory.politology
    )
    
    static let qk9: Question = Question(
        text: "Wrzucamy losowo dwie kule do dwóch urn. Wartość oczekiwana liczby niepustych urn jest równa",
        answers: [
            "1",
            "1.5",
            "1.(3)",
        ],
        correctAnswers: [1],
        category: NewsCategory.mathematics
    )}


struct AnsweredQuestion {
    let question: Question
    let answer: Question.Answer
    
    var isCorrect: Bool {
        return question.isCorrect(answer: answer)
    }
}
