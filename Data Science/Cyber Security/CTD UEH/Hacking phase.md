Hacking có thể chia làm 7 giai đoạn chính. 
1. Truy vết các thông tin có sẵn
	1. Tập trung vào các thông tin có sẵn
		1. Collection of public information
		2. Collection of network information
2. Scan: Quét những lỗ hổng, hệ thống network
	1. Truy cập vào network và server để thu thập thông tin được lấy từ quá trình 1
3. Tổng hợp: Liệt kê lại các thông tin cần thiết để chuẩn bị cho cuộc tấn công
4. Tìm cách để chiếm quyền truy cập: Một trong những cách tấn công có thể là tấn công vào network và chiếm các thông tin như là mật khẩu của chúng ta. Mục đích là để người tấn công di chuyển tự do trong hệ thống (bước này **quan trọng**)
5. Empowerment (tìm cách trở thành admin user?): Lúc mà chúng ta nâng cấp quyền của account trong phạm vi có thể. Lúc này, các hacker/cracker có thể chiếm được các thông tin quan trọng khác không kém + thay đổi các thông tin quan trọng như config/server. 
6. Duy trì sự kết nối: Tạo một cái backdoor để lần sau đi vào dễ hơn. Lúc này chúng ta có thể truy cập vào hệ thống ở bất cứ đâu (tough af)
7. Xóa dấu vết mà chúng ta đã làm: xóa tất cả các hành tung của chúng ta (bao gồm che giấu backdoor, xóa nhật ký log và thao túng tâm lý?)
Có thể chia làm 3 phần chính:
1. Từ 1 tới 3: Advance preparation
2. Từ 4 tới 6: Tấn công
3. 7: Hậu xử lí 
**Actual flow**: Đây là một quá trình mang tính tuần tự, 
# Attack Specificity and Flow
Nói về tính đặc hiệu của sự tấn công. 
Giữa cuộc tấn công high specific và low specific có tính đặc trưng riêng. 

Các cuộc tấn công high specific có mức độ thành công cao hơn. Và để đạt được điều này, họ sẽ dành nhiều thời gian để tìm hiểu về thông tin (advanced preparation).

Giả sử có 1 account truy cập vào hệ thống, do đó khi 1 hacker có khả năng truy cập vào hệ thống thì họ cũng sẽ làm được những gì mà user đó làm. 

Bên cạnh đó, bằng việc lặp đi lặp lại cái flow ở trên, khả năng chúng ta hack được vào hệ thống càng cao. 

Trong trường hợp tấn công low specific, các hacker với skillset nhất định cũng như biết được họ sẽ tấn công vào đâu cho phù hợp với skillset của họ? (nuh uh, reconfirm)

## Các ví dụ cho các cuộc tấn công mức độ thấp
Các ví dụ này không tuân thủ theo flow hack đã đề cập như hồi nãy:
- Denial-of-service (DOS) attack: tấn công bằng lượng request
- Web application attacks: do thiết kế bậy, người dùng có thể vô tình tạo ra lỗi chí tử
- Social Engineering
- Use of malware: Có sẵn, lấy rồi sử dụng thôi 

# Security dilemma
> "Vunerability is "vulnerable" because you don't notice it"

Việc tấn công sẽ sinh ra trước, việc phòng thủ thường sẽ đi sau. 
Phải biết có lỗ hổng thì mới vá được 

Người tấn công luôn ở thế chủ động trong khi người phòng thủ thì luôn ở thế bị động => unfair

# Hacker's Modus Operandi
Không chỉ là xâm phạm diện network-based
Social Engineering (tấn công phi kĩ thuật):
- Thu thập thông tin:
	- Xử dụng các thông tin open-source, ví dụ như danh bạ, email, và từ những thông tin đó, sẽ có cách hoạt động khác nhau. 
- Đánh vào tâm lý con người để làm những hành động xấu
- Xâm nhập trực tiếp: Đánh trực diện
Các kĩ năng cần thiết: 
- Communication skills: kĩ năng giao tiếp (để lừa đảo)
- Deception
- Strength/Stamina 
# Purpose and type of attack
- Mục đích dựa trên động cơ
- Khi objective thay đổi, mục tiêu và cách thức tấn công thay đổi
1. Host: Liên quan đến việc mục tiêu tấn công sẽ là server, bên cạnh đó là việc hậu xử lí để che đít.
2. Network: DoS attack, network eavesdropping
3. Application: Web application attacks  