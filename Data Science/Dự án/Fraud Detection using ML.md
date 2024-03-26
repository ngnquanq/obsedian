Trong dự án này, mình sẽ cố gắng **phát hiện giao dịch giả mạo**. 

Lấy ví dụ như mình hay dùng thẻ để giao dịch mua cái gì gì đấy, mà **bị mất thẻ**, xong rồi mấy thằng trộm mới cố gắng tìm mọi cách để nó **tiêu nhiều tiền từ thẻ trộm nhất.**

Có thể chia ra làm 2 loại cho bài toán này:
- **Normal**: Bạn chi tiêu
- **Fraud:** Người khác chi tiêu.

Có các hướng tiếp cận cho bài toán này:
- Rule based: rút liên tiếp 3 lần mà số tiền rút trong mỗi lần là tối đa (vd 3-5tr), hoặc giao dịch sau 12h đêm, v.v... thì chặn thẻ đấy.
	- **Yếu điểm:** 
		- Chỉ detect được Fraud đã xảy ra trong quá khứ.
		- Dễ sai, không phản ánh được toàn bộ tập khách hàng
- Machine Learning based: Dùng AI để nhận diện được pattern của mẫu giao dịch. 
	- **Lợi điểm:** Nhận diện được cái Fraud

**Tư tưởng:** Học các đặc trưng từ giao dịch **normal** và có cái gì lạ lạ thì detect giao dịch **fraud**. Project này rất cơ bản để hiểu vấn đề. 

# Dùng AI để chống Fraud

# AutoEncoder
