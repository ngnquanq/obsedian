Chúng ta cần duy trì kết nối:
=> Sau khi tấn công vào hệ thống, ta tạo ra backdoor để chui vô mà tốn ít thời gian hơn

Bên cạnh đó, sau khi bị đột nhập 1 lần, việc xác định các config thay đổi sẽ khó hơn, dẫn đến việc tạo ra backdoor sẽ thuận lợi hơn. 

**Trong trường hợp chứng nhận bị phá:**
- Thay đổi password bởi người dùng có ủy quyền
	- Giả sử trong lúc người tấn công lấy được mật khẩu và user phát hiện, rồi thay đổi mật khẩu, lúc này attacker cũng chim cút theo. 
**Tấn công vào các lỗ hổng**:
- Sửa đổi các lỗ hổng thông qua các bản vá và nâng cấp 
**Các lí do khác:**
- Liên quan đến vấn đề upgrade role của user (điều này khó, do đó mà chúng ta cần backdoor)

=> Tổng hợp lại có 3 nguyên nhân tạo backdoor:
- Lo lắng về user đổi pass
- Thay đổi về config
- Thời gian để upgrade role của họ
# Backdoor
## Classification
Có thể phân ra 4 loại backdoor chính: 
- Backdoor được tạo trong quá trình thiết kế, cài đặt sản phẩm
- Backdoor được tạo ra bởi developer (theo ý họ)
- Được tạo ra bởi chính phủ
- Được tạo ra bởi người tấn công (attacker)
### Built-in during the design and development phase
- Được tạo ra để quá trình debug đơn giản hơn
- Quên xóa feature vào thời điểm công khai ứng dụng hoặc chuyển giao ứng dụng
### Created by developers on their own
- Để debug nhanh hơn
- Có ác ý khác 
### Government intelligence backdoors 
- Do chính phủ yêu cầu, để chính phủ có thể giám sát
- Ví dụ như CALEA
### Planted by attacker
- Được tạo ra bởi người tấn công để duy trì quyền truy cập 
- Cài một backdoor:
	- Chiếm quyền truy cập và chạy trên console
	- Mã độc
## Requirement
1. Kết nối có thể sử dụng từ bên ngoài 
2. Số lệnh nhất định có thể sử dụng khi được kết nối
3. Luôn kết nối
4. Thực thi lệnh với quyền admin
5. Người quản lý hệ thống khó tìm thấy

Các thành phần liên kết thành 1 chuỗi: Các ứng dụng chạy với chức năng (1) và (2) như là một service (3) trong nền (4) với quyền admin (5). => **Điều kiện vô cùng lý tưởng**.
## Backdoor type
Có một số cách mà các attacker cài đặt backdoor cho việc duy trì kết nối:
1. Tạo account mới: Nếu đang ở quyền admin, họ có thể tạo account khác 
	1. Thêm account: 
		1. Điều kiện: hệ thống authenication đã được thỏa mãn
		2. Tạo ra user mới
		3. Trao quyền admin
	2. Disadvantage: 
		1. Khó giấu đi
		2. Bị ghi lại vào nhật ký mỗi lần login 
2. Network service: Sử dụng remote desktop, netcat hoặc xinetd
3. Thêm service mới: bắt đầu hoặc cài đặt các phần mềm khác
	1. Nếu service chưa được cài, nó sẽ được cài
	2. Ngày nay, Linux dễ cài đặt thêm service, miễn là nó connect tới mạng, thông qua các lệnh như: 
		1. `yum`
		2. `get-apt`
		3. etc...
# Concealing backdoors
Backdoor cũng chỉ là 1 phần mềm, do đó mà nó cũng có khả năng bị phát hiện bởi os
Có thể sử dụng tools như là root kit:
**Root kit**: 
- Một tool phổ biến cho các attacker
- etc ...
