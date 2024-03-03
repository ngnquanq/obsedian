
***Head first:*** Hiểu được cái này cần nhiều kiến thức khác nhau như: [[floating-point numbers]] hoặc là [[how computer stores number]]

First: https://medium.com/@florian_algo/model-quantization-1-basic-concepts-860547ec6aa9

Second: https://medium.com/@florian_algo/model-quantization-2-uniform-and-non-uniform-quantization-47ca5b5d3ec0

Third: https://blog.gopenai.com/model-quantization-3-timing-and-granularity-a0978c6e58d4


Model Quantization (hay còn gọi là lượng hóa model (mình dịch nên hơi đuồi, thông cảm nha 😢)). 

Trong Deep Learning thì việc lượng hóa là một kĩ thuật cho phép mình tối ưu bộ nhớ bằng cách hy sinh ***1 ít khả năng của mô hình***. 

Lấy ví dụ như là cái QLoRA, phương pháp này đã cẩn thận **lượng hóa các tham số về dạng 4-bit** (là từ một model có 65 tỷ tham số chạy trên 1 con GPU với tổng bộ nhớ của model từ 780GB **sang** dưới 48GB lưu trữ mà không ảnh hưởng quá nhiều tới performance của mô hình.)

Ok, nói nhiều rồi,

# Lượng Hóa là gì?

