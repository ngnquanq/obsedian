# Overview toàn bộ cấu trúc
![[Pasted image 20240509094708.png]]

# LangChain
 Là 1 **Framework** để phát triển ứng dụng có sử dụng ngôn ngữ lớn
Đặc điểm: 
 - Simple (Dưới 20 line code là xong cái RAG)
 Use case:
 - Tóm tắt văn bản
 - Agents
 - Chatbot
 - Code uderstanding
 - Evaluate LLMs 

## Introduction
![[Pasted image 20240509095233.png]]

## LangServe
- Dạng dạng 1 cái FASTAPI
- Tích hợp trong LangChain để hỗ trợ deploy thành các API
## LangSmith
- Dạng dạng như 1 cái Hub, để bản thân mình có thể lưu các model, chain. 
- Và sau đó mình có thể đánh giá nó 
- Một thành phần để monitor nữa 
# LangChain Components
![[Pasted image 20240510090759.png]]
- LangChain có 1 module riêng dành cho các cái Prompt
- Có riêng 1 cái module là Output parsers
- Chain
- Một phần hẳn hoi dành riêng cho RAG 
	- Document leaders
	- Documenet transformers
	- Embedding models
	- Vector stores
	- Retrievers
- Dành riêng cho các Agent
	- Agents
	- Tools
- Memory hỗ trợ cho việc nhớ lại đoạn hội thoại phía trước nó. 
## Prompts
Là 1 dạng template, cấu trúc nào đó được định nghĩa sẵn (tựa tựa như phần instruction tuning, type shi)
```md
### Instruction Math

### Question 1

### Answer

```

## Document Loaders and Utils 
Hỗ trợ đọc document, z thui

## Agents
Là những cái tool, phần mềm, hàm để mô hình của mình tương tác với cái tool đó, mục tiêu là để thực hiện một vài task nào đó. Ví dụ như LLMs đang cùi ở task calculation, task reasoning

=> Khắc phục bằng cách sử dụng các tools sẵn có. 

Đây là một hướng nghiên cứu riêng, gọi chung là hướng nghiên cứu Agent LLM

## Chains 
Có thể hiểu Chain là một chuỗi các component 

Principle khi thiết kế LangChain: kết nối các components với nhau thành 1. 

Lúc này mình chỉ cần sử dụng 1 biến duy nhất để đưa ra kết quả mong muốn. 

Pros: 1 bước chạy, xong chuyện. 

## How to use 
Có rất nhiều option để tạo ra 1 LLM trong langchain 

### Cách sử dụng:

LangChain LLM:
- GPT from OpenAI: 
	- Yêu cầu API của OpenAI
	- Sử dụng `.invoke()` để đưa input vào 
- LLM from huggingface:
	- ![[Pasted image 20240510093353.png]]
	- ![[Pasted image 20240510093522.png]]
	- Langchain muốn mình sử dụng `pipeline()` của HuggingFace. 
	- Trong HuggingFace, chỉ cần ở trên thôi là xong rồi, nhưng với LangChain thì khác, nó cần thêm 1 bước extra: ![[Pasted image 20240510093700.png]]
	- Sau khi khai báo xong, mình có thể dùng hàm `invoke` như ở trên rồi chạy lại như bình thường. 
	-  Nhìn chung thì với mô hình lớn chút sẽ chạy khá lâu, do đó nếu có API key của OpenAI thì nó nhanh hơn 

### Prompt Template
Khi sử dụng các LLMs, việc sử dụng Prompt là rất quan trọng. 

Cụ thể hơn, trong LangChain, chúng ta sẽ sử dụng PromptTemplate. 

Một cái template có thể bao gồm: 
- Instructions
- Few-shot examples
- Specific context and questions appropriate for a given task 

Và tất nhiên LangChain có hỗ trợ mấy cái này, ví dụ như: 
![[Pasted image 20240510103039.png]]

Mình có thể đưa toàn bộ template vào phương thức `invoke` của mô hình

### LLMChain
Ví dụ: Mình muốn lấy tài liệu từ một file pdf trong 1 trang web nào đó. Và các thông tin này mình sẽ bỏ vào 1 câu prompt. Nói chung là 1 task rất lớn, đi kèm với nó là các task nhỏ hơn. 

Dưới đây là ví dụ của 1 chain:
![[Pasted image 20240510104421.png]]

Dưới đây là ví dụ cụ thể. 
![[Pasted image 20240510104520.png]]
Cơ bản cái chain là như vậy thôi. 

### Output parser
Mình cần đi qua nhiều bước hậu xử lí để trả ra cái string hoàn chỉnh cho người dùng.

LangChain sử dụng pydantic model để cấu trúc lại file json mà nó mong muốn.

Có thể ứng dụng Chain của LangChai

![[Pasted image 20240510112856.png]]

### Document Loader
![[Pasted image 20240510112953.png]]
Hỗ trợ rất nhiều hàm khác nhau để đọc riêng cho nhiều dạng tài liệu khác nhau (HTML, pdf, code, v.v...)
![[Pasted image 20240510113056.png]]

Ví dụ như mình có thể load sử dụng PDF hoặc load sử dụng webpage 

### Document Splitter 
Đây là một dạng kĩ thuật.

Thay vì lấy hết toàn bộ đống text dài ra đó thì mình chia ra thành từng đoạn nhỏ nhỏ (chunk).

Trong các bài truy vấn, đó là cách để truy vấn thông tin tốt hơn thay vì lấy cả đoạn text dài làm ebedding vector. 

Có nhiều thủ thuật Document Splitter khác nhau 

Các giá trị cần chú ý:
- `chunk_size`
- `chunk_overlap`
- `vector embedding` (cho câu query)

### Vector database
Có nhiều loại vector database khác nhau

Cần lựa chọn cái nào cho phù hợp với nhu cầu sử dụng. 

Trong LangChain cũng hỗ trợ việc Reranking 

## Ứng dụng trong thực tế với các file PDF
![[Pasted image 20240510122912.png]]

Deploy API sử dụng FastAPI

Nah

Đơn giản vậy thôi hả >.<

Có thể tích hợp thêm nhiều trường hợp khác, multi-modal, agents, vân vân

Instruction Tuning cho Multi-modal (Multi-modal instruction tuning)

Tìm hiểu thêm LLM cho máy với tài nguyên thấp, hoặc dùng các LLM low resources như Gamma, Vicuna, rồi ấp dụng thêm các phương pháp lượng hóa. 