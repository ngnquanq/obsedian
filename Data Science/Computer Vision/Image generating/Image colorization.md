## Introduction
Mạng MDN (Mixture Density Network)
Gaussian Mixture Models (GMM)
Guided Image Filtering - Kaiming He
Bishop book
Modern computer vision approach book

Note: VAE và vanilla AE không có cái gọi là điểm mạnh điểm yếu, VAE thì dựa trên xác suất, vanilla AE khác
## Image colorization problem
- Problem: Colorizing gray-scale images
- Practical applications: coloring old black and white images
- Main approaches: **Scribble-based**, **Example-based**, **Fully Automatic**

### Related methods:
- Parametric methods : 
	- Hand-engineer: **Deep colorization**, **Automatic image colorization via multimodal predictions**. 
	- Deep-learning:  **Learning representations for automatic colorization**, **Let there be color: Joint End-to-end learnign ...** 
- Non-parametric methods
## Context auto-encoder approach
Idea:
1. Học cái nội tại qua cái VAE thường trước.
2. Học một cái mạng khác và sử dụng cái kĩ thuật sampling, sau đó tô màu.
## VAE approach
Bài toán này có các điểm:
- Không dùng kênh RGB, dùng kênh Lab. 
	- Kênh L: mang tính chất cường độ
	- Kênh a,b: mang tính chất màu
- Paper gốc: **Learning Diverse Image Colorization**. 
- Trong lúc train:
	- VAE Training: 
	- MDN Training:
- Những thành phần cơ bản: 
	- Data: 
		- Tách ảnh ra 2 trường thông tin, 1 cái Gray, một cái Color. 
		- Dùng data lfw 
	- Hậu xử lí: 
		- Do mình predict 2 kênh màu, nên về sau mình sẽ nối nó lại1 kênh màu. 