**Đọc thêm**:
- [What is REST](https://restfulapi.net/) 


**API** là viết tắt của **Giao diện lập trình ứng dụng** (Application Programming Interface), đóng vai trò như **cổng kết nối** giữa các phần mềm, ứng dụng và dịch vụ khác nhau. Nó cho phép các nhà phát triển **trao đổi dữ liệu và chức năng** một cách dễ dàng, giúp **tăng cường khả năng tương tác** và **mở rộng khả năng** của các hệ thống.
![[diagram-what-is-an-api-postman-illustration.svg]]API rất đa dạng, kiểu nó xuất hiện ở nhiều hình thù khác nhau. Ví dụ như với một API hệ thống (system APIs), nó được sử dụng để làm các hành động như bật camera hay là audio trong google meet, hoặc là API web (web APIs) để sử dụng cho các hành động mà người dùng làm trên web như là like ảnh, comment, share, hoặc là kéo thả để được cái bảng feed mới. 

Mặc dù rất đa dạng, nhưng cách chúng hoạt động tương tự như nhau. Thường mình sẽ tạo ra một yêu cầu (**request**) để lấy thông tin hoặc dữ liệu, và cái API sẽ **trả về một phản hồi (response) dựa trên request của người dùng**. 

# SOAP vs REST vs GraphQL

2 cái SOAP và REST là 2 chuẩn thiết kế API được sử dụng. 
1. SOAP (Simple Object Access Protocol): Hay dùng cho các tập đoàn, đặc biệt hơn là cho các hệ thống phức tạp và yêu cầu độ tin cậy rất cao. 
2.  REST (Representational State Transfer): Thường được dùng cho các API public, **lý tươgnr cho việc lấy data từ Web**. Đồng thời nhẹ hơn và gần gũi hơn nhiều với HTTP so với SOAP. 

Và người mới: GraphQL. Được Facebook tạo ra, là một ngôn ngữ truy vấn rất linh hoạt cho APIs, lợi thế là nó cho phép người sử dụng xác định chính xác những gì mà họ muốn lấy từ server thay vì để cho server xác định nên gửi những gì. 

# Python và API

Sử dụng thử cái API mà tạo ngẫu nhiên dữ liệu người dùng:
```python
>>> import requests
>>> response = requests.get("https://randomuser.me/api/")
<Response [200]>
>>> response.text
```
Cái việc mà nó `<Response[200]>` là ngôn ngữ của API, nó nói rằng mọi thứ đã ổn (mặc dù chưa có thấy gì), để có thể thấy được dữ liệu, ta có thể sử dụng thêm `.response` để trả về cái `Response` object. 

Đơn giản là vậy, giờ mình đã biết cách **sử dụng API cơ bản** bằng thư viện requests. 