
## Objective
- Xem xét mục tiêu bài toán Inpainting là gì.
- Giới thiệu về Denoise Diffusion Probabilistic Model
- Image Inpainting sử dụng DDPM

## Image Inpainting là gì?

- Là bài toán điền vào những chỗ bị trống trong ảnh
- Có nhiều kĩ thuật để mask ảnh khác nhau, ví dụ như:
	- Random Box
	- Center Box
	- Hybrid 
	- Irregular
	- Free-form 

## Những hướng tiếp cận khác nhau:
1. Patch Pasting
2. Deep Learning Methods

### PatchMatch
Tìm những đặc tính giống nhau trong patch của ảnh đầu vào
Paste
### ScenceCompletion
Tìm kiếm hình ảnh giống với ảnh đầu vào dựa trên database
TÌm kiếm các patch ảnh khác nhau trong cái database đó rồi chèn nó vô cái phần trống của ảnh đầu vào. 

## Phương pháp deep learning
Dùng mấy kiến trúc như UNET để huấn luyện
Global and Locally Consistent Image Completion, ví dụ như cái này:

![[Pasted image 20240402134022.png]]

Hoặc là sử dụng Diffusion Model

![[Pasted image 20240402134047.png]]

### Diffusion Model
- Forward pass: Thêm nhiễu
- Backward pass: Khử nhiễu

## Denoising Diffusion Probabilistic Model

### Objective

Thêm nhiễu trong ảnh đầu vào và rồi khôi phục ảnh đầu vào từ đống nhiễu đó

### Forward Diffusion Process

Các tham số cần:
- Time step: số bước thêm nhiễu
- Schedule $\beta$ để thay đổi số lượng nhiễu thêm vào ở từng bước
Việc chỉnh $\beta$ không phải muốn thêm là thêm, mà có cách thức để thêm ở mỗi thời điểm khác nhau một lượng $\beta$ khác nhau (điều chỉnh tăng theo tuyến tính hoặc theo cosine). 

Nhiễu được thêm vào ở từng step sẽ tuân theo phân phối chuẩn, cụ thể như sau:

$$
\text{q}(x_t|x_{t-1}) = \mathcal{N}(x_t;\text{mean} := \sqrt{1 - \beta_t}x_{t-1}, \text{variance :=} \beta_t\mathbf{I} )
$$

### Reverse Diffusion Process


![[Pasted image 20240402135646.png]]


***Side question: Tại sao mọi người thích dùng UNET vậy?**

=> Xét về ý nghĩa sử dụng mô hình, mình cần những mô hình có khả năng khôi phục lại ảnh có cùng kích thước, thứ hai là về skip connection cho phép bảo toàn một phần thông tin

Và chúng ta cũng sử dụng thêm sinusoid embedding để biết chúng ta đang denoise tại timestep thứ mấy. 

Bên cạnh đó, trong công thức denoising, chúng ta cũng thấy được cái công thức đó có dạng như sau:

$$
q(x_{t-1}|x_t, x_0)
$$
Ở đây chúng ta sử dụng thêm $x_0$ như là một cái tham chiếu, để cho mô hình biết chúng ta nên denoise về cái gì. 

Bên cạnh đó mình cũng tích hợp thêm các khối self-attention. Hình dung mỗi điểm ảnh trong ảnh đầu vào thì nó sẽ liên quan đến các điểm ảnh khác, do đó self-attention có thể đánh giá sự liên quan đó. 

Cũng sử dụng cái Adaptive Group Norm (tìm hiểu thêm cái này). 

Công thức để masking trong quá trình reverse

![[Pasted image 20240402142935.png]]


