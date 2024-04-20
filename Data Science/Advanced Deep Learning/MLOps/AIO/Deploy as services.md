## Introduction

Lấy ví dụ về chatgpt (có UI để interact với hệ thống).

Ở role user, ngta chỉ biết gõ prompt xong enter.

**Làm sao để team OPENAI nhận câu hỏi của mình và trả về câu trả lời?**

Most cases, hầu hết web application có một cái gọi là [[API]]. 

## API

Simplest form: Một cái **trung gian** được represent bởi một cái đường dẫn (vd: https://. . .) để giao tiếp giữa 1 người dùng nào đó với cái máy chủ. 

Một vài khái niệm:
- **client(user):** người gửi yêu cầu
- **server:** máy chủ xử lí yêu cầu của người dùng
- **request:** yêu cầu mà client đưa vào API 
- **response:** sau khi server xử lí request của mình rồi, nó đưa lại cho API, APi đưa lại xuống mình (cái đó là response)

Nhiều loại API:
- Private API
- Public API
- Partner API
- Database API
- Remote API
- Web API (cái mình tìm hiểu buổi hôm nay)

Protocol types: cách để xây dựng, thiết kế API

## FastAPI

Là một framework để build các ứng dụng liên quan đến API

Django hay Flask cũng được dùng để build API

FastAPI có vẻ dễ dùng hơn (learning curve không có steep lắm)

Features làm cho ai cũng nên học FastAPI:
- High performance
- Fast to code
- Easy
- Robust

API endpoint (routes, paths)

RESTAPI Methods:
- GET: lấy thông tin từ một nguồn (ví dụ: thông qua API để thực hiện truy vấn thông tin nào đó trong database)
- POST: gửi thông tin lên trên nguồn (ví dụ: Muốn inference một mô hình deep learning, nên mình sẽ gửi data)
- PUT: cập nhật thông tin lên nguồn (ví dụ: mình muốn đổi lại ngày tháng năm sinh bị nhập sai)
- DELETE: xóa thông tin trong nguồn (ví dụ: mình muốn xóa ID của người không còn trong lớp)

Khái niệm về sync và async

async def và def

async def là một hàm có thể xử lí bất đồng bộ, ví dụ mình đang thực thi một hàm async thì mình được await một hàm khác nào đó. 

Thông thường, async def liên quan đến chức năng đọc và ghi file, và có thể việc đọc, ghi file quá lâu nên thằng fastapi phải chờ. async khắc phục điểm này ở chỗ trong lúc đang chờ thì nó cho mình đi xử lí một thằng khác. 

### Pydantic model

Request body: Những thông tin mình muốn gửi cho API
Response body: Những thông tin mà API muốn gửi lại cho mình

Ví dụ mình muốn tạo một function cho chủ shop cập nhật sản phẩm mới lên trên cửa hàng, với cả mình muốn người ta up thông tin lên theo như cấu trúc mình định nghĩa. Để làm được điều đó, fastapi cho phép sử dụng một cái gọi là pydantic model (model cho data). 

Pydantic model là một cách để define cấu trúc dữ liệu theo kiểu thuộc tính và theo một kiểu dữ liệu nào đó. 

Pydantic model có thể lồng được, 
có nghĩa là một cái pydantic model có thể chứa thông tin của một cái pydantic model khác 


### Parameters Annotation

FastAPI cho phép mình thêm thông tin như kiểu dữ liệu cho các biến đầu vào. 

### Status code

Các con số cho biết ý nghĩa - tình trạng hiện tại của trang web 

Mình có thể sửa status code theo kiểu mà mình muốn. 

### Upload file

FastAPI có hỗ trợ upload file, và nhiều thứ khác.

File: cho file nhỏ

UploadFile: cho file lớn

### Middleware

Hiểu cơ bản là một hàm để tiền và hậu xử lí một cái request (thường là xử lí chung cho nhiều endpoint khác nhau)

Có nhiều chức năng, mỗi cái mỗi khác 

CORS (Cross-Origin Resource Sharing): Một tính năng mà browser nào cũng có, ví dụ như web có cái domain `google.com` và mình muốn gọi api từ `https://ngnquanq.github.io` thì trong trường hợp này, nếu `google` không được `ngnquanq` cho phép thì nó kh được truy cập. Điều này là một cái gọi là `same-origin policy` tức là một không được chỏ tới chỏ lui, nó sẽ chỉ chỏ tới những cái domain của nó thôi, **tránh chỏ tới chỏ lui để hacker lộng hành**. 

# Model Deployment

`logs`: Chứa các thông tin logging
`middleware`: Chứa các hàm định nghĩa về middle ware

TLDR: Đọc cuốn clean code

Rất nhiều folder
-> Nhét vào file app.py để nó chạy 

Cái gì đó mà ...route.py là thiết kế 1 cái endpoint

Tìm hiểu
nginx - More complicated
ngrok - More simple