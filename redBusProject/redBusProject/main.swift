import Foundation

//readLine()은 옵셔널 문자열 타입이라 guard구문을 이용하여 Int형변환 안될시 숫자 입력해주세요! 출력 및 프로그램 종료
//swift 입력은 c와 달리 구현이 어려워 https://josee2.tistory.com/32 참조
print("몇시인가요? : ", terminator: "")
guard let hour = readLine(), let userHour = Int(hour) else {
    print("숫자를 입력해주세요!")
    exit(0)
}
// 0 <= hour <= 23 조건 추가
if userHour > 23 || userHour < 00 {
    exit(0)
}
// 새벽시간 hour가 0~3이라면 첫차까지 시간이 너무 많이 남았습니다... 추가
if userHour >= 0 && userHour < 4 {
    print("첫차까지 시간이 너무 많이 남았습니다...")
    exit(0)
}

print("몇분인가요? : ", terminator: "")
guard let minute = readLine(), let userMinute = Int(minute) else {
    
    print("숫자를 입력해주세요!")
    exit(0)
}
// 0 <= minute <= 59 조건 추가
if userMinute > 59 || userMinute < 00 {
    exit(0)
}
// 막차시간 이후 입력시 제한
if userHour == 22 && userMinute > 41 {
    print("막차가 지나갔습니다! 첫차를 기다려주세요!")
    exit(0)
}
print("현재시각: \(userHour)시 \(userMinute)분")

// 대림동산 정거장 4401 버스 도착시간
let busArrivalTimeDaerim: [String] = ["0511","0539","0600","0621","0636","0651", "0701","0709","0730","0751","0812","0842","0912","0939","1009","1031","1049","1110","1139","1212","1239","1309","1339","1410","1431","1449","1510","1531","1551","1609","1631","1650","1712","1745","1813","1841","1911","1931","1951","2009","2041","2109","2142","2209","2241"]
// 공도 정거장 4401 버스 도착시간
let busArrivalTimeGongdo: [String] = ["0519", "0546", "0610", "0628", "0647", "0659", "0719", "0740", "0802", "0822", "0855", "0922", "0949", "1019", "1040", "1101", "1119", "1149", "1222", "1246", "1320", "1349", "1421", "1440", "1455", "1503", "1522", "1540", "1601", "1619", "1640", "1701", "1720", "1755", "1822", "1855", "1922", "1940", "2001", "2019", "2049", "2116", "2149", "2216", "2252"]

print(busArrivalTimeDaerim.count)
print(busArrivalTimeGongdo.count)


// 값비교를 위한 분으로 바꿈
let minuteChange = busArrivalTimeDaerim.map {busTime -> Int in
    let busHour = Int(String(busTime.prefix(2))) ?? 0
    let busMinute = Int(String(busTime.suffix(2))) ?? 0
    return busHour * 60 + busMinute
}

let minuteChangeTwo = busArrivalTimeGongdo.map {busTime -> Int in
    let busHour = Int(String(busTime.prefix(2))) ?? 0
    let busMinute = Int(String(busTime.suffix(2))) ?? 0
    return busHour * 60 + busMinute
}

let userTime = userHour * 60 + userMinute
// minuteChange[]와 userTime의 차를 저장할 subUserTime이라는 배열 변수 추가
var subUserTimeDaerim = [Int]()
var subUserTimeGongdo = [Int]()

for i in busArrivalTimeDaerim.indices {
    subUserTimeDaerim.append(minuteChange[i] - userTime)
}


// subUserTimeDaerim에서 0보다 크면서 최솟값을 lowButUpZero라는 변수에 저장하여
// 같은 index에 해당하는 busArrivalTime의 배열을 이용해 도착예정시간 출력
if let lowButUpZero = subUserTimeDaerim.filter({ $0 > 0 }).min() {
    if let index = subUserTimeDaerim.firstIndex(of: lowButUpZero){
        let printBusTime = busArrivalTimeDaerim[index]
        if lowButUpZero == 1 {
            print("대림동산 도착예정시간: 곧 도착")
        } else {
            print("대림동산 도착예정시간: \(printBusTime.prefix(2)):\(printBusTime.suffix(2))\n\(lowButUpZero)분 후 도착합니다. ")
        }
    }
}



for i in busArrivalTimeGongdo.indices {
    subUserTimeGongdo.append(minuteChangeTwo[i] - userTime)
}
// subUserTimeGongdo에서 0보다 크면서 최솟값을 lowButUpZero라는 변수에 저장하여
// 같은 index에 해당하는 busArrivalTime의 배열을 이용해 도착예정시간 출력
if let lowButUpZero = subUserTimeGongdo.filter({ $0 > 0 }).min() {
    if let index = subUserTimeGongdo.firstIndex(of: lowButUpZero){
        let printBusTime = busArrivalTimeGongdo[index]
        if lowButUpZero == 1 {
            print("공도정류장 도착예정시간: 곧 도착")
        } else {
            print("공도정류장 도착예정시간: \(printBusTime.prefix(2)):\(printBusTime.suffix(2))\n\(lowButUpZero)분 후 도착합니다. ")
        }
    }
}








