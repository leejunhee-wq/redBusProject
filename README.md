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
이 코드를 통해 현재 시각과 분을 입력할 수 있도록 하였다. 단, C와 달리 swift에서 입력 구현이 어려워 https://josee2.tistory.com/32를 참조하였다.
readLine()메서드는 입력받은 값을 옵셔널 문자열로 반환하기에 Int(hour), Int(minute)을 통해 입력받은 값을 Int형으로 변환하였다
또한 guard 구문을 이용하여 숫자가 아닌 다른 값이 들어오면 프로그램을 종료하도록 exit(0)을 추가하였다.

if userHour > 23 || userHour < 00 {
    exit(0)
}
if userHour >= 0 && userHour < 4 {
    print("첫차까지 시간이 너무 많이 남았습니다...")
    exit(0)
}
을 통해 입력받는 hour의 값을 제한하였고, 막차가 끊긴 후 첫차까지 시간이 너무 많이 남은 0~3시는 "첫차까지 시간이 너무 많이 남았습니다..."라는 문장을 출력하고 프로그램이 종료되도록 하였다


if userMinute > 59 || userMinute < 00 {
    exit(0)
}
마찬가지로 입력받는 minute의 값을 제한하였다


if userHour == 23 && userMinute > 42 {
    print("막차가 지나갔습니다! 첫차를 기다려주세요!")
    exit(0)
}
막차가 끊기는 23시 42분 이후로 입력을 입력을 받는다면 00시 전까지 "막차가 지나갔습니다! 첫차를 기다려주세요!"라는 문장을 출력하고 프로그램이 종료되도록 하였다.

let busArrivalTime: [String] = ["0511","0539","0600","0621","0636","0651","0709","0730","0751",
"0812","0842","0912","0939","1009","1031","1049","1110","1139","1212","1239","1309","1339","1410",
"1431","1449","1510","1531","1551","1609","1631","1650","1712","1745","1813","1841","1911","1931","1951",
"2009","2041","2109","2142","2209","2241"]

let minuteChange = busArrivalTime.map {busTime -> Int in
    let busHour = Int(String(busTime.prefix(2))) ?? 0
    let busMinute = Int(String(busTime.suffix(2))) ?? 0
    return busHour * 60 + busMinute
.map 메서드를 이용하여 각 배열을 변환하여 새 배열을 제작하였다
우선 .map 활용하여 busArrivalTime 변수의 배열 값들을 busTime이 받도록 하였고 
prefix와 suffix 메서드를 이용하였지만 분으로 변경 후 비교하기 위해 문자열의 앞 두자리와 뒤 두자리를 최종적으로 Int로 형변환을 하였다
prefix와 suffix 메서드 타입은 Substring이라 바로 Int형 변환을 못하기에 string으로 형변환 후 Int형으로 변환하였다
그리고 값의 차로 비교를 위해 busHour * 60 + busMinute을 분으로 반환하여 minuteChange에 저장하였다

let userTime = userHour * 60 + userMinute
또한 이미 Int형인 userTime 상수는 minuteCange값과의 차를 위해 분으로 변경하였다

var subUserTime = [Int]()
for i in 0...43 {
    subUserTime.append(minuteChange[i] - userTime)
}

if let lowButUpZero = subUserTime.filter({ $0 > 0 }).min() {
    if let index = subUserTime.firstIndex(of: lowButUpZero){
        let printBusTime = busArrivalTime[index]
        print("도착예정시간: \(printBusTime.prefix(2)):\(printBusTime.suffix(2))")
        print("\(lowButUpZero)분 후 도착합니다.")
    }
}
이 프로그램에서 가장 중요한 부분이다 
 minuteChange[]와 userTime의 차를 저장할 subUserTime이라는 배열 변수 추가하였고,
 for 반복문과 append() 메서드를 이용하여, minuteChange[]와 userTime의 차를 저장 후 subUserTime 배열에 값을 할당하였다

 그리고 lowButZero라는 상수에 subUserTime 배열에 값들 중 0보다 크고 그 중 가장 작은 수를 할당하였다.
 minuteChange[]와 userTime의 차에서 0보다 크고 가장 가까운 값이 가장 빨리 도착할 버스의 시간이기 때문이다.

 그 후 index라는 상수에 subUserTime 첫번째 배열의 번호를 할당한 후 그 index와 같은 번호값인 busArrivalTime[index]를 출력하도록 하였다.
 그 출력값을 printBusTime에 할당한 후 prefix, suffix 메서드를 이용하여 중간에 :(콜론)을 출력 할 수 있도록 하였다.

 그리고 lowButUpZero에 저장된 값을 출력하여 버스 도착시간까지 남은 시간을 출력하도록 하였다.
