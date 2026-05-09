# Điện toán đám mây
**Khi nhắc đến điện toán đám mây, nhớ tới:**
- On-demand(pay as you go): Dùng tới đâu, trả tiền tới đó 
- Access via internet: Truy cập thông qua các hệ thống điện toán đám mây sử dụng internet (lưu và nhược điểm khi quá phụ thuộc vào một phương thức liên lạc)
- Phần cứng được ảo hóa 
- "Service": Tư tưởng khi cần thì thuê => Các thiết bị của mình không bị hỏng => Không lo đến việc maintain 
- Tốn ít chi phí hơn hẳn việc phải làm lại từ đầu 

**Các mô hình điện toán đám mây:**
1. IaaS: Infrastructure as a service: Thuê server và phần cứng trên cloud => flexible 
2. PaaS: Platform as a service: Khá tương tự cái IaaS 
3. SaaS: Software as a service: Được tập trung vào 

**Các mô hình phát triển điện toán đám mây**:
1. Cloud
2. Hybrid: Dung hòa các ứng dụng trên cloud và ứng dụng private 
3. On-premises (private cloud): Hệ thống tại chỗ => Lên hybrid dễ hơn 

Những gì làm được đối với IT truyền thống đều có thể được cài đặt lên cloud service. 


# Lợi ích khi sử dụng cloud 
- Khi chuyển qua cloud, gần như cắt bỏ hoàn toàn "chi phí đầu tư ban đầu" => Có sự chuyển dịch từ "**Investment cost**" sang "**Operation cost**". Hạn chế được rủi ro khi đầu tư fail. Also, trốn thuế tốt (chuyển sang khấu trừ thuế). 
- **Economies of scale:** Khi một hệ thống càng phổ biến, càng có nhiều người sử dụng, nhà cung cấp sẽ tự động giảm giá của dịch vụ xuống. Giá dịch vụ của các quốc gia, châu lục khác nhau sẽ có thể khác nhau 
- **Scaling on demand**: Tự scale theo dung lượng cho phù hợp 
- **Increase speed and agility**: Nhanh chóng tạo ra một phòng máy, rất nhanh, qua vài cái click chuột 
- Không tốn phí duy trì, hạn chế hidden cost (chạy phòng server tốn nhiều cái) 
- **Global in minutes**: Tạo ra một hệ thống ở bất cứ đâu => Cho phép triển khai ở bất cứ thị trường nào khi cần thiết 

# Web Services 
- AWS: Hệ thống cloud lớn nhất trên thế giới hiện nay 
- Microsoft cũng có tiềm năng phát triển (tiên phong trong AI)
- AWS cung cấp rất nhiều service khác nhau 
- Tất cả các công nghệ mới đều đang được nền móng bởi điện toán đám mây 
- Điện toán đám mây rất phù hợp cho các hệ thống ML bình thường 
- Hạn chế là không thể dùng cùng 1 lúc nhiều service của các nhà cung cấp khác nhau (vd storage ở aws database thì không link nó được với ml của azure, kiểu kiểu v) 
- Nên chọn service phụ thuộc vào business goals và technology requirements 
- Có vấn đề khi sử dụng cloud:
	- Security: Tính riêng tư (không riêng tư trên cloud được)
	- Internet: Đứt mạng, đứt luôn service

# AWS CAF 
**Các yếu tố khi triển khai ứng dụng trên điện toán đám mây:**
- Business: Phải chắc chắn rằng IT được align với business needs
- People: Nhân viên phải được huấn luyện, tổ chức phù hợp để điều hành hệ thống cloud. Khi không được training kĩ thì sẽ mất tiền. 
- Gorvernance: Phải xác định IT strategy phù hợp với business strategy 
- Platform
- Security 
- Operation: Quá trình điều hành của 1 hệ thống cloud, phải xác định xem cái nào là điều hành hàng ngày, cái nào là điều hành hàng tháng 
