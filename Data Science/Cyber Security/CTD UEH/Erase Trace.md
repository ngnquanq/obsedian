# Lý do
- Để việc phạm tội trở nên hoàn hảo hơn
- Để họ biết được mình đi đến đâu.
## Dấu vết xâm nhập
- Nhật ký truy cập
- Tạo ra các file mới và các file tạm thời
- Traces như là lịch sử hoặc cookies
- Các thay đổi tạm thời trong settings
## Các loại log cơ bản:
1. Khác biệt trong phương thức lưu trữ:
	1. Dạng chữ
	2. Dạng mã nhị phân 
2. Khác biệt trong entities lưu trữ:
	1. Hệ điều hành
	2. Ứng dụng
### Syslog (Log của hệ thống):
- Liên quan đến tiêu chuẩn cho truyền tải tin nhắn log qua mạng IP
- Kiểm tra setting trước nhất:
	- loại file log và đường dẫn
- Rotation:
	- Chu kỳ backup log files
	- Các logs được backup được lưu trữ trong lịch sử
# Xóa log
- Cách xóa dấu vết truy cập trong log:
	- Xóa file => Dễ bị phát hiện
	- Xóa record (chỉ xóa hành vi của chúng ta thôi) => Có trường hợp data stream gián đoạn => Dân chuyên phát hiện được
	- Thao túng record
- Đối với các file nhị phân:
	- Việc xóa record khó thực hiện
	- Do đó mà chúng ta cần sử dụng các binary editor, có thể sử dụng các tools như `clearev`
# Camouflage
Việc có một "perfect crime" gần như là bất khả thi
Những gì mà chúng ta phải làm: 
=> Cho thấy không có dấu hiệu của việc vi phạm
Các phương pháp khả thi cho việc này:
=> Log tampering và xóa dấu vết
=> Điền vào file log