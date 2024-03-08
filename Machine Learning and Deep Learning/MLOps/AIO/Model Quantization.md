
***Head first:*** Hiểu được cái này cần nhiều kiến thức khác nhau như: [[Floating-point numbers]] hoặc là [[how computer stores number]]

Reading List:
- Series 3 blog
	-  https://medium.com/@florian_algo/model-quantization-1-basic-concepts-860547ec6aa9
	-  https://medium.com/@florian_algo/model-quantization-2-uniform-and-non-uniform-quantization-47ca5b5d3ec0
	-  https://blog.gopenai.com/model-quantization-3-timing-and-granularity-a0978c6e58d4
- Hugging Face: https://huggingface.co/docs/optimum/concept_guides/quantization

**<u>TLDR</u>** : <mark style="background: #FFB86CA6;">TỐI ƯU BỘ NHỚ BẰNG CÁCH GIẢM BIT LƯU TRỮ SANG DẠNG TỐN ÍT BỘ NHỚ HƠN.</mark> 


Model Quantization (hay còn gọi là lượng hóa model (mình dịch nên hơi đuồi, thông cảm nha 😢)). 

Trong Deep Learning thì việc lượng hóa là một kĩ thuật cho phép mình tối ưu bộ nhớ bằng cách hy sinh ***1 ít khả năng của mô hình***. 

Lấy ví dụ như là cái QLoRA, phương pháp này đã cẩn thận **lượng hóa các tham số về dạng 4-bit** (là từ một model có 65 tỷ tham số chạy trên 1 con GPU với tổng bộ nhớ của model từ 780GB **sang** dưới 48GB lưu trữ mà không ảnh hưởng quá nhiều tới performance của mô hình.)

Ok, nói nhiều rồi,

# Lượng Hóa là gì?

Trong toán học hay là xử lí tín hiệu số, lượng hóa đề cập đến việc ánh xạ từ giá trị đầu vào trong một tập lớn (thường là tập liên tục, ví dụ như là tập số thực) sang một tập nhỏ hơn (thường là một tập hữu hạn các số hoặc là phần tử, hoặc là vô hạn nhưng đếm được), kiểu kiểu phương pháp rời rạc hóa trong lĩnh vực thuật toán. 

Trong deep learning thì model quantization thực chất là việc chuyển đổi từ high-precision floating-point numbers trong một mạng neural sang low-precision numbers

**Như vậy, model quantization bản chất là một hàm ánh xạ.**



# Những hướng tiếp cận Model Quantization (Objects for Model Quantization)

Cách thức này có thể được sử dụng cho nhiều khía cạnh khác nhau trong deep learning như là: 

- **Trọng số (weights)**: Lượng tử hóa trọng số là phổ biến nhất, bởi vì nó **làm giảm kích thước mô hình, bộ nhớ sử dụng**
- **Hàm kích hoạt (activation)**: Thường thì mấy cái hàm kích hoạt cần nhiều bộ nhớ #why , nên là với việc mình lượng hóa được mấy cái hàm này không chỉ làm giảm bộ nhớ lưu trữ mà khi kết hợp nó với weight quantization, mình có thể tận dụng tối đa tính toán số nguyên để đạt được một cái performance cải thiện hơn. 
- **KV cache:** Cải thiện throughput của việc tạo ra một chuỗi dài
- **Đạo hàm (Gradients)**: Ít được sử dụng hơn, vì nếu sử dụng thì chỉ sử dụng cho quá trình training, còn trong lúc inference thì có cần gì đụng tới đạo hàm đâu. Và do trong mặc định thì mấy cái  đạo hàm này được lưu dưới dạng FP32 (trong pytorch). Do đó mà việc mình quantize nó sẽ làm giảm tính toán. 
