**Đọc thêm**:
- [What is REST](https://restfulapi.net/) 

TODO: 
- Sử dụng POSTMAN để test API.
- Tìm hiểu về tiêu chuẩn HTTP ([[HTTP Standards]])

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

MORE...

# Các nguyên tắc cơ bản khi thiết kế API 

Một vài nguyên tắc thiết kế API cơ bản được liệt kê dưới đây mang tính chủ quan và được lấy từ bài [này](https://sagaratechnology.medium.com/the-basic-principles-of-api-application-programming-interface-d28dbd50798) Dù sao đi nữa thì mong muốn là **cung cấp cơ sở cần thiết và hỗ trợ mình với những gì mà một doanh nghiệp thật thụ đang làm.**

## 1. Vocabulary

Có nghĩa là **ta phải tuân theo chuẩn đặt tên khi đặt tên cho các endpoint của API**. Các tên này phải **đọc được, dễ hiểu, theo chuẩn HTTP**.

## 2. Versioning

Khi đề cập đến các version khác nhau, có nghĩa là chúng ta sẽ cho phép người dùng truy cập và sử dụng API của chúng ta theo 2 biến thể khác nhau. **Quản lý cái này tốn thêm công sức** nhưng nó giúp chúng ta quản lý các endpoint được tốt hơn. 

Có 2 cách để thực hiện:
- URL
- Accept Header

## 3. Hỗ trợ đa dạng phương tiện

Chưa biết ghi gì

## 4. Bộ nhớ đệm và kiểm soát đồng thời 

Ngắn gọn về bộ nhớ đệm. Trong tin học, cache là bộ nhớ đệm chứa dữ liệu, các dữ liệu được nằm chờ yêu cầu từ ứng dụng hoặc phần cứng. Dữ liệu được chứa trong cache có thể là các thuật toán đã được thực hiện khi được yêu cầu, hoặc các dữ liệu trùng được lưu trữ ở một nơi khác. 

Bộ nhớ đệm cải thiện performance, bằng cách đó mà nó cung cấp sự truy cập nhanh hơn vào các tài nguyên hay được truy cập và loại bỏ phần tải lên backend services. Có thể kiểm soát bộ nhớ đệm một cách tốt hơn nhờ vào sử dụng các chuẩn HTTP như là:
- ETag 
- Last-Modified

## 5. Tiêu chuẩn phản hồi codes

Trách nhiệm thuộc về chủ doanh nghiệp bởi vì nó ảnh hưởng lên nhu cầu của doanh nghiệp lên khách hàng về API

## 6. Các lưu ý khác về bảo mật

Chưa biết ghi gì. 