
Những phần mềm khi được deploy lên môi trường ứng dụng thì cần đảm bảo được **tính đàn hồi (dịch từ resilient trong sách)**, tức là khả năng một hệ thống có thể recover sau các thất bại và tiếp tục vận hành, và cần ít yếu tố con người để giữ cho phần mềm hay ứng dụng đó chạy.

[[Stateless Serving Function design pattern]]: Cho phép cơ sở hạ tầng phục vụ được scale lên và có thể xử lí hàng ngàn thậm chí hàng triệu yêu cầu inference mỗi giây.

[[Batch Serving design pattern]]: Cho phép cơ sở hạ tầng phục vụ xử lý bất đồng bộ các yêu cầu không thường xuyên hoặc định kỳ đối với hàng triệu tới hàng tỷ inference. 

[[Continued Model Evaluation design pattern]]: Là một cách chung để xác định các mô hình không còn phù hợp cho tác vụ mình cần xử lí.

[[Two-phase predictions design pattern]]: Cung cấp một cách để giải quyết vấn đề giữ cho các mô hình tinh vi và hoạt động tốt ngay cả khi phải deploy lên các thiết bị phân tán.

[[Keyed Predictions design pattern]]: Cần thiết để implement các design pattern ở trên. 