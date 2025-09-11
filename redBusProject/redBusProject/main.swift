import Foundation

//readLine()은 옵셔널 문자열 타입이라 guard구문을 이용하여 Int형변환 안될시 숫자 입력해주세요? 출력 및 프로그램 종료
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

print("현재시각: \(userHour)시 \(userMinute)분")

// 대림동산 정거장 4401 버스 도착시간
let busArrivalTime: [String] = ["0511","0539","0600","0621","0636","0651","0709","0730","0751","0812","0842","0912","0939","1009","1031","1049","1110","1139","1212","1239","1309","1339","1410","1431","1449","1510","1531","1551","1609","1631","1650","1712","1745","1813","1841","1911","1931","1951","2009","2041","2109","2142","2209","2241"]

// 값비교를 위한 분으로 바꿈
let minuteChange = busArrivalTime.map {busTime -> Int in
    let busHour = Int(String(busTime.prefix(2))) ?? 0
    let busMinute = Int(String(busTime.suffix(2))) ?? 0
    return busHour * 60 + busMinute
}

var userTime = userHour * 60 + userMinute



    





