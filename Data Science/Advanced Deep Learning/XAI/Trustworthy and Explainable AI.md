**Key:**
- AI is everywhere.
- Appear flaws, not so perfect.
- Using for high-stake decisions (i.e: COMPAS: Machine bias in the court)
- Reverse engineer? 
- Long-term research goals: Trustworthy AI and Explainable AI 
	- Trustworthy AI: Mô hình AI chính xác trong các trường hợp khó xảy ra (và thường xảy ra)
	- Explainable AI: Xây dựng AI giúp tối đa độ chính xác được tạo bởi người và AI
	- Gộp chung lại: Xây dựng AI mà con người có thể debug và edit lại quá trình ra quyết định của AI. 

# Trustworthy AI
Đầu tiên là phải check AI xem nó có vấn đề không?
-> AI rất mạnh, nhưng với các edge cases thì nó rất dễ đổ vỡ.
-> Có các pattern đánh bại được rất nhiều model AI (Cho cả CV và NLP)
-> Rất dễ lừa các mô hình AI (CV: rotation; NLP: shuffle N-gram)

%% CLIP:
- Symmetric cross entropy
- Weakness:  %%
# Explainable AI 
**Key:**
- AI là blackbox -> Người không hiểu hết được. 
- Research: Create an interface (bottleneck XAI) để con người có thể so sánh + đối chiếu giúp con người điều chỉnh hành vi của AI. 
# Build AIs that human can debug 

# Future XAI 
Đằng sau AI của tương lai, một là AI có thể truy cập vào internet và các vùng sẵn có để có thể đưa ra quyết định

# Industry
Càng về sau càng cần explainable AI
paper: đọc nhanh rồi qua paper khác, đừng có stop quá lâu **đọc nhanh, đọc nhiều, đọc lướt**. 
**perplexity** giúp mình đọc paper rất nhanh, cân nhắc dùng thử
feedly
i.e anthropic

Bắt đầu nguyên cứu xai bằng twitter của giáo sư anh totti nguyen 

# Case Study: Enefit
1. Business understanding
2. Data understanding
3. Feature selection 
4. Chọn mô hình 
5. Giải thích mô hình (GOAL)
Các mô hình cũ cũng được, nhưng vấn đề là có giá trị thực tiễn khi giải quyết được ván đề của doanh nghiệp. Nên ưu tiên. 

Sử dụng SHAP như là một xAI

Hoặc là sử dụng các mô hình có tính can thiệp cao để chọn ra các feature hữu dụng. 

Hoặc sử dụng các mô hình có tính can thiệp cao. 
Như là mô hình cây hoặc là mô hình hồi quy truyền thống. 

 Không quăng giá trị NaN vô được, do đó mới cắt giảm đầu (tức là lấy từ 2022 => giải quyết được time lag => giải quyết được giá trị Null và NaN ).

Business objective: dự đoán lượng điện mà người dân sẽ dùng hoặc tạo ra theo thời điểm. 

Quyết định thuật toán encode trước + sử dụng deep learning. 

Sử dụng các mô hình machine learning để mã hóa luôn. Kiểu kiểu trích đặc trưng dùng LSTM hoặc GRU. Dùng cấu trúc autoencoder truyền thống để train, xong rồi lấy vector từ cái embedding space là đủ.

Hoặc là sử dụng các phương pháp encode có sử dụng sequential encoding