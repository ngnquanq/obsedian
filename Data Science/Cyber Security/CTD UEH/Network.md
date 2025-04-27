# OSI Reference model
- OSI: Open System Interconnection
- Hệ thống:
	- 7 Layers, mỗi layer làm nhiệm vụ khác nhau. 
	- 4 phần đầu (upper layers)
	- 3 phần sau (later layers)
Cụ thể hơn, việc người dùng truy cập website thì những cái đó thuộc vào tầng application 

# TCP/IP Model
Có chút khác biệt giữa OSI và TCP/IP model 

# Basic Network 
- **LAN (Local Area Network):** Phạm vi nhỏ nhất, thường là các trường đại học sử dụng dùng để kết nối các máy trong campus (khuôn viên trường)
- **WAN (World Area Network)**: Là mạng mà chúng ta sử dụng (mạng internet) - kết nối lớn 
- **Route:** Thiết bị ở giữa để giúp truyền dẫn thông tin trong network 
- **NIC**

# Communication header

# Transmission image in Ethernet
Khi dẫn truyền thông tin, thông tin sẽ đi qua từng lớp, lần lượt là:
User
1. Application layer
2. Transport layer
3. Internet layer
4. Network access layer 
Physics (máy vật lý)
# Receive image in Ethernet
Ngược lại ở trên. 
# Actual communacation details 

# Network Access Layer Headers 

# Protocols active in TCP/IP
1. Transport layer: TCP UDP
2. Internet layer: IP, ICMP, ARP
## ICMP: Internet Control Mesage Protocol

## ARP: Address Resolution Protocol
Cần 2 thông tin:
1. MAC address: địa chỉ vật lý của máy
2. IP address: địa chỉ IP
Cần phân biệt giữa địa chỉ IP và địa chỉ MAC.

Địa chỉ IP có thể đổi theo vị trí quốc gia, tuy nhiên địa chỉ MAC thì có thể cố định trên máy 
## TCP: Transmission Control Protocol
- Connection-oriented
	- Split message into segments and send
	- Receiver reconstructs
	- Resend unreceived segments
- 3-way handshake and session maintenance
## UDP: User Datagram Protocol
- Connectionless type
	- Kém tin cậy hơn TCP
	- Bù lại, nó xử lý nhanh hơn TCP 
	- => Thường được sử dụng trong lĩnh vực game 
# Application layer protocol
- Transport layer "port number"
- Well known port (những port đã định nghĩa rồi): 0-1023
- Port đã đăng kí: 1024-491251
- Port bảo mật: 49152-65535 (freeBSD)
- Port bảo mật: 32768-61000 (Linux)
Nhưng port này không phải được định nghĩa 1 cách vô tội vạ mà thông qua một bên thứ 3: IANA

# Network topology 
Network configuration
- Physical topology
- Logical topology 
# IP Address
Hiện tại đang có 2 loại IP Address là IPv4 và IPv6.

Trong quá trình phát triển, người ta phát triển từ IPv4 sang IPv6. Lưu ý là ngta không bỏ cái IPv4 đi hoàn toàn, nhiều chỗ còn sử dụng cả IPv4 lẫn IPv6. 

Khoảng 10 năm trở về trước (trước 2014), IPv4 chiếm chủ đạo.

Đặc điểm đặc biệt của IPv6:
- IPv6 bảo mật hơn so với IPv4.

Cấu trúc của IP address gồm 2 thành phần chính:
- Nửa đầu chứa thông tin về network
- Nửa sau xác định rõ host của network (host number)
Khác biệt lớn nhất giữa các IP address class nằm ở phần prefix của địa chỉ IP

Có vài địa chỉ IP không được sử dụng dưới dạng một global IP address

**net-mask:** Có thể được hiểu là mạng con (subnet)

**CIDR (Classless Inter Domain Routing)**: Chúng ta sẽ chú trọng phần bit hơn là phần class
