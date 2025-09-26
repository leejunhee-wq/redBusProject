import Foundation


enum inputError: Error {
    case allWrong
    case hourOutOfRange
    case noBusTime
    case minuteOutOfRange
    case lastBusTime
}

//readLine()은 옵셔널 문자열 타입이라 guard구문을 이용하여 Int형변환 안될시 숫자 입력해주세요! 출력 및 프로그램 종료
//swift 입력은 c와 달리 구현이 어려워 https://josee2.tistory.com/32 참조
 print("몇시인가요? : ", terminator: "")
guard let hour = readLine(), let userHour = Int(hour) else {
    print("숫자를 입력해주세요!")
    exit(0)
}

print("몇분인가요? : ", terminator: "")
guard let minute = readLine(), let userMinute = Int(minute) else {
    
    print("숫자를 입력해주세요!")
    exit(0)
}

func checkHour(_ userHour: Int, _ userMinute: Int) throws -> Int {
    if (userHour > 23 || userHour < 00) && (userMinute > 59 || userMinute < 00) {
        throw inputError.allWrong
    }
    if userHour > 23 || userHour < 00 {
        throw inputError.hourOutOfRange
    }
    if userHour >= 0 && userHour < 4 {
        throw inputError.noBusTime
    }
    
    if userMinute > 59 || userMinute < 00 {
        throw inputError.minuteOutOfRange
    }
    
    if userHour == 22 && userMinute >= 41 {
        throw inputError.lastBusTime
    }
    
    print("현재시각: \(userHour)시 \(userMinute)분")
    
    return userHour * 60 + userMinute
}

do {
    _ = try checkHour(userHour, userMinute) // 반환값 무시 와일드 카드 -> 왜 무시? 새로운 변수나 상수에 checkHour을 시도한 값을 받는데 쓸 곳이 없음... 또 그 이유는 난 현재시각을 위에 코드처럼 출력하고 싶지만 변수하나에 저장해서 하는건 마땅히 생각나지 않음
    
} catch inputError.allWrong {
    print("올바른 시각을 입력해주십시오")
    exit(0)
} catch inputError.hourOutOfRange {
    print("시간의 범위는 00~23까지 입니다")
    exit(0)
} catch inputError.noBusTime {
    print("첫차까지 아직 시간이 많이 남았습니다")
    exit(0)
} catch inputError.minuteOutOfRange {
    print("분의 범위는 00~59까지 입니다")
    exit(0)
} catch inputError.lastBusTime {
    print("막차가 지나갔습니다! 첫차를 기다려주세요!")
    exit(0)
}

let userTime = userHour * 60 + userMinute



// 대림동산 정거장 4401 버스 도착시간
let busArrivalTimeDaerim: [String] = ["0511","0539","0600","0621","0636","0651", "0701","0709","0730","0751","0812","0842","0912","0939","1009","1031","1049","1110","1139","1212","1239","1309","1339","1410","1431","1449","1510","1531","1551","1609","1631","1650","1712","1745","1813","1841","1911","1931","1951","2009","2041","2109","2142","2209","2241"]
// 공도 정거장 4401 버스 도착시간
let busArrivalTimeGongdo: [String] = ["0519", "0546", "0610", "0628", "0647", "0659", "0719", "0740", "0802", "0822", "0855", "0922", "0949", "1019", "1040", "1101", "1119", "1149", "1222", "1246", "1320", "1349", "1421", "1440", "1455", "1503", "1522", "1540", "1601", "1619", "1640", "1701", "1720", "1755", "1822", "1855", "1922", "1940", "2001", "2019", "2049", "2116", "2149", "2216", "2252"]

func printBusTime(userTime: Int, busTime: [String], place: String ) {
    let ChangMinute = busTime.map {busTime -> Int in
        let busHour = Int(String(busTime.prefix(2))) ?? 0
        let busMinute = Int(String(busTime.suffix(2))) ?? 0
        return busHour * 60 + busMinute
    }
    
    let subUserTime = ChangMinute.map { busTime in
        return busTime - userTime
    }
    
    if let lowBusUpZero = subUserTime.filter({ $0 > 0 }).min() {
        if let index = subUserTime.firstIndex(of: lowBusUpZero){
            let printBusTime = busTime[index]
            if lowBusUpZero == 1 {
                print("\(place) 도착예정시간: 곧 도착")
            } else {
                print("\(place): \(printBusTime.prefix(2)):\(printBusTime.suffix(2))\n\(lowBusUpZero)분 후 도착합니다.)")
            }
        }
    }
}

printBusTime(userTime: userTime, busTime: busArrivalTimeDaerim, place: "대림동산 정류장")
printBusTime(userTime: userTime, busTime: busArrivalTimeGongdo, place: "공도 정류장")




