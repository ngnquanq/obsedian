Đây là bước quan trọng khi tiến hành tấn công. 

**Có nhiều thông tin mà chúng ta có thể thu thập được**:
- Công khai từ các nguồn có sẵn
- Liên kết trực tiếp đến đối tượng
- Sử dụng các công cụ tìm kiếm
- Sử dụng social engineering
Và do đây là bước quan trọng, do đó mà chúng ta cần lặp đi lặp lại nhiều lần nếu cần thiết

# Classification of Information Gathering Methods
## Các cách thu thập thông tin:
- Thu thập thông tin một cách tự động:
	- Thu thập thông tin được cung cấp bởi đối tượng
	- Thường là hợp pháp
	- Ví dụ:
		- Domain
		- URL
		- Thông tin Network
		- Home Page
		- Vị trí
		- Số điện thoại, v.v...
- Thu thập thông tin một cách chủ động:
	- Chủ động gõ lệnh, sử dụng tools, v.v...
	- Thường là bất hợp pháp
# Enumeration
Đây là bước tổng hợp, liệt kê các thông tin
Từ các thông tin này, chúng ta sẽ tổng hợp lại và tìm ra hướng tấn công phù hợp nhất. 

**Ví dụ:**
1. Thông qua bước "reconnaissance", chúng ta có được vùng vị trí IP của đối tượng
	1. Dẫn đến việc chúng ta có thể "scanning" để duyệt qua các địa chỉ IP đang hoạt động
2. Sau đó, thông qua "scanning", chúng ta tìm được các "authentication services is in operation" như là các mục tiêu
	1. Chúng ta enumerate qua các tài khoản user để tiến tới bước "obtaining access rights"
# Reconnaissance
## Public Information
- Là thông tin mà chúng ta công khai với đại chúng.
	- Home Page
		- URL
		- IP Address
		- Vị trí
		- Mail liên lạc
		- Follower 
		- Review
		- Map
- Thông tin mà chúng ta **phải công khai**.
	- Thông tin mạng
	- Thông tin miền, DNS
	- Thông tin khách hàng
	- v.v... 
- Thông tin được lấy từ bên thứ 3 mà không có sự cho phép của chúng ta:
	- Thông tin duyệt web, v.v...
# Gathering information from the web server
- Thu thập thông tin từ robots.txt
	- Sử dụng các phần mềm crawling, v.v...
	- Thường được đặt dưới directory nhất định
# Read vulnerability information
1. CVE
2. CCVE
3. 