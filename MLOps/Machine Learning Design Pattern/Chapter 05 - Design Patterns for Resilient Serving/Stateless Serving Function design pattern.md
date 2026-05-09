
Một hệ thống ML ngoài ứng dụng được **thiết kế xoay quanh một hàm stateless lưu trữ kiến trúc mô hình và trọng số của mô hình huấn luyện**. 

# Stateless 

Vậy **Stateless function** là gì?
**Trả lời:** Một hàm gọi là stateless nếu như **toàn bộ đầu ra của hàm phụ thuộc thuần túy vào đầu vào của hàm**. Hiểu đơn giản thì là một hàm stateless nếu như nó là một immuatble object, trong đó **trọng số là hằng số**. Và bởi vì các thành phần stateless không có trạng thái (vì nó stateless 😀), nên nó **có thể chia sẻ giữa các client**. 

Vòng đời của các thành phần stateless **cần được quản lý bởi server.** Lấy ví dụ như chúng nó **cần được khởi tạo khi user request lần đầu** cũng như **phải bị xóa đi sau khi client terminate nó hoặc time out**. Do đó mà các thành phần stateless rất dễ để scale lên.

Khi thiết kế các ứng dụng trong doanh nghiệp, những người làm rất cẩn thẩn trong việc tối thiểu hóa số lượng thành phần stateful. 

Bằng cách nói một mô hình nên được xuất ra dưới dạng một hàm stateless, chúng ta đang yêu cầu những người thiết kế ra mô hình theo dõi cácc biến stateful và không bao gồm nó trong các file xuất đi. 

Tuy nhiên khi sử dụng các hàm stateless, nó đơn giản code ở server nhưng lại làm phức tạp code ở phía client, nói chung có sự tradeoff. 

