Một người thông thái đã từng nói rằng:

> `model trên jupyter notebook là model chết`
> 								*Anonymous*

Hoàn toàn đồng tình, thằng nào không đồng tình để a tommy đá vô mồm một phát 😀

Các kiến thức cần có:
- [[API]]
- [[AI application principles]]

# Objective
- Giới thiệu sơ qua về các mô hình client-server. Cố gắng build một cái giải thuật ML gốc trên một cái server nào đó. Hiểu sâu hơn về các **giao thức (protocols)**. 
- Tìm hiểu về Flask RESTApi( [[API]] ). Và cách thức để deploy lên máy của mình. 
- Học cách deploy trên các service thông dụng như [[Azure]] hoặc là [[AWS]] hoặc là [[pythonanywhere]]. 

## Nhược điểm của các phương pháp ứng dụng giải thuật ML lên điện thoại.
- Tốn rất nhiều tài nguyên. 

# What is a REST API
- API dạng dạng một cái cổng mà mình dùng để giao tiếp với cái server với rất nhiều chức năng khác nhau. 
- Cách thức giao tiếp: 
![[Pasted image 20240324132115.png]]
- Mình cần 1 anh trung gian để giao tiếp giữa a client với a server để thực thi các tác vụ mình mong muốn (JSON trong trường hợp này).
- GET, POST,... là các hành động mà mình muốn server thực thi. 
## What is API:
- Một cách để 2 thiết bị client và server để nó tương tác lẫn nhau. 
- URL: một cái link giúp mình truy xuất vào tài nguyên, gọi cái hàm nào đó ở cái server
- HTTP: Nói cho server biết mình muốn làm gì với cái tài nguyên UR: endpoint. 
- Body message: Dữ liệu mình truyền từ client sang server. 
- Status code: Cho biết thông báo
## What is REST

> REST (REpresentational State Transfer)

Hình dung mình đang truy cập vào một trang web nào đó, mình yêu cầu cho anh server, thì mỗi cái request của mình nó có một cái state riêng. 

Mình thường tập trung vào 2 protocol chính là GET với POST

# Coding

```python
from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello_world():
	return 'hello world'

@app.route('/xinchao')
def hello_world()
	return 'hello AIO2023'

if __name__ == '__main__':
	app.run()
```
Sự khác nhau của 2 hàm này là cái địa chỉ khác nhau, một cái là `/` còn một cái là `/xinchao`. 

# Postman
Sử dụng Postman để test cái IP address.

# Deploy ML model as API
Khi deploy sử dụng API thì không dùng request để lấy parameter nữa mà sử dụng cách khác. 

uvicorn?

# Flask Rest API and Mobile

Cần một thư viện để hỗ trợ tương tác giữa android và cái API

## Internet Access Permission Configuration

Mình cần cho phép ứng dụng Android truy cập vào internet để handle request. 