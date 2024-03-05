Model Pruning hay còn được gọi là cắt tỉa mô hình, đúng như tên gọi của nó, đây là một kĩ thuật để mình "tỉa bớt mô hình", sao cho nó nhẹ hơn, friendly cho bộ nhớ hơn, ít tốn pin hơn và nhiều thứ khác. Nhìn nó như hình này!

<img alt="center" src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2LPjKBIHoSVqVfC82gxq7LT-dGzM_l2Hu1mF4yjsauA&s" \img>
# Reference
- Paper: [To prune, or not to prune: exploring the efficacy of pruning for model compression](https://arxiv.org/pdf/1710.01878.pdf)
- Blog: [Optimizing deep learning models with pruning](https://medium.com/@jan_marcel_kezmann/optimizing-deep-learning-models-with-pruning-a-practical-guide-163e990c02af#cb63)

# Motivation:
Có một vài động lực cho việc chúng ta tỉa bớt mô hình, bao gồm:
- **Giảm kích thước cũng như độ phức tạp của mô hình**: Bằng cách giảm kích thước và độ phức tạp của mô hình, chúng ta có thể **loại bỏ các tham số không cần thiết**, đồng thời **giảm kích thước cũng như độ phức tạp của mô hình**. Cho phép dễ dàng hơn khi triển khai và chạy mô hình trên các thiết bị bị giới hạn về tài nguyên. 
- **Cải thiện hiệu năng**: Tỉa bớt mô hình cải thiện hiệu năng của một mô hình máy học bằng cách giảm đi overfitting và tăng khả năng khái quát của mô hình. Và như vậy có thể huấn luyện nhanh hơn, khi mà chỉ một vài tham số cần phải cập nhật chứ không phải như model gốc. 
- **Tăng khả năng can thiệp:** Loại bớt đi vài tham số không cần thiết cũng làm tăng khả năng can thiệp của mô hình, do đó làm cho việc ra quyết định dễ thực hiện hơn. 

# Các loại tỉa mô hình (phương thức):
## 1. Weight pruning:

Việc tỉa bớt đi trọng số mô hình bao gồm loại bỏ các trọng số bên trong một mô hình mà nó **không đóng góp gì nhiều** tới kết quả của mô hình, <mark style="background: #ABF7F7A6;">TLDR: bỏ các tham số mà có hay không cũng không quan trọng</mark>.

Một trong những kĩ thuật để phục vụ việc này là "magnitude-based pruning", các trọng số có giá trị nhỏ sẽ bị bỏ đi, hoặc là "gradient-based pruning", các trọng số mà có giá trị đạo hàm thấp sẽ bị bỏ đi. 

Nên cân nhắc vì việc này sẽ ảnh hưởng đến độ chính xác của mô hình. 

## 2. Neuron pruning:

Hay còn gọi là tỉa theo cấu trúc (structure pruning), bao gồm việc chúng ta sẽ loại bỏ hoàn toàn các neuron hoặc là các layer từ một mạng neural. 

Cách thức để chúng ta có thể tỉa model như thế này là dựa vào các kĩ thuật như "low-density pruning", nôm na là các  neurons kém hoạt động sẽ bị bỏ đi, hoặc là "filter pruning", nôm na là các filter với độ quan trọng thấp sẽ bị bỏ đi.

Nói chung tương tự weight pruning trong việc làm giảm đi kích thước của mô hình, tuy nhiên nó cũng có thể làm mất đi độ chính xác của mô hình nếu quá nhiều neurons hoặc là layers bị bỏ đi. 

## 3. Structered vs Unstructured Pruning:

Đây là hai hướng tiếp cận khác để tỉa mô hình, điểm chung là đều có thể tỉa bớt những tham số không cần thiết. 

Trong khi<mark style="background: #ADCCFFA6;"> structered pruning</mark> nhắm tới việc loại bỏ bớt tham số sao cho <mark style="background: #ADCCFFA6;">giữ nguyên cấu trúc của mô hình</mark>, thì <mark style="background: #D2B3FFA6;">unstructed pruning</mark> lại ngược lại, cách thức này sẽ loại bỏ các tham số theo các pattern bất thường hoặc dựa trên các đo đạc về tính quan trọng của tham số, nhìn chung thì <mark style="background: #D2B3FFA6;">khả năng cao sẽ không giữ lại được toàn bộ cấu trúc của mô hình. </mark>


## 4. Các thách thức và giới hạn:

<mark style="background: #ABF7F7A6;">TLDR: Trade-off giữa performance và kích thước.</mark>
- **Balancing complexity and performance**: Việc đảm bảo cân bằng giữa độ phức tạp của mô hình và hiệu năng của mô hình là rất quan trọng. Việc mà chúng ta loại bớt tham số quá nhiều lần, hoặc là sao đó, làm giảm độ phức tạp của mô hình, và ở mức nào đó có thể giảm hiệu năng mô hình.
- **Over-pruning**: Nếu một mô hình bị tỉa dữ quá thì nó kém chính xác và hoạt động kém đi, với lại xác định cái tham số nào quan trọng cũng không phỉa dễ. 
- **Thiếu khả năng can thiệp:** Trong nhiều trường hợp, việc tỉa bớt mô hình làm giảm khả năng can thiệp, tại vì các tham số còn lại sẽ có sự liên kết phức tạp hơn, hoặc là khó để hiểu hết. 
# Các kĩ thuật tỉa mô hình:

## 1. Weight pruning

Sơ bộ thì mô hình trước và sau khi weight pruning sẽ nhìn như sau:

![[weight_pruning.png|center]]

**Và có thể thấy rằng cấu trúc của mô hình đã được giữ nguyên.** 

Như nãy đã đề cập về weight pruning có 2 kĩ thuật chính là maginitude-based pruning và gradient-based pruning:

- **Magnitude-based pruning:** **Dễ tiếp cận và dễ cài,** nôm na là loại đi các trọng số dựa trên cái magnitude so với các trọng số khác trong mô hình. Thường thì ta sẽ chọn 1 threshold và cái trọng số nào dưới mức threshold này thì ta sẽ bỏ nó đi. Điểm yếu ở chỗ là **bị nhạy cảm bởi cái threshold** này. 
- **Gradient-based pruning**: Khá tương tự như là cái ở trên, nhưng thay vì xét trực tiếp giá trị của trọng số, cách thức này **dựa vào giá trị đạo hàm của trọng số đó trong quá trình huấn luyện**. Điểm giống là ở chỗ cũng đặt cái threshold, khác ở chỗ cái threshold này là cho cái giá trị đạo hàm chứ không phải là cái cường độ (giá trị thật sự) của cái trọng số đó. 

## 2. Neuron pruning

Sơ bộ mô hình trước và sau quá trình neuron pruning:

![[neuron_pruning.png|center]]

**Nhìn chung thì có sự khác biệt trong cấu trúc mô hình trước và sau khi tỉa.**

Như nãy đề cập thì có 2 cái kĩ thuật tỉa chính cho neuron đó là "low-density pruning" và "filter pruning":
- **Low-density pruning**: Dễ tiếp cận và dễ hiểu, loại bỏ bớt các neuron hoạt động kém năng nổ so với các neuron còn lại. 
- **Filter pruning**: Này thì thuộc về cụ thể cái CNN, thường người ta cài bằng cách xếp hạng cái filter dựa trên mấy cái thước đo về độ quan trọng của cái filter đó, như dựa trên cường độ của trọng số hoặc là đóng góp của cái filter đó lên performance của mô hình, mấy cái filter xếp chót bị bỏ đi. 
## 3. So sánh:

- Nhìn chung thì weight pruning cụ thể hơn neuron pruning, tại nó cho phép trực tiếp loại bỏ các liên kết, các trọng số cụ thể hơn là toàn bộ neuron. Tuy nhiên nó cũng bị nhạy cảm bởi cái threshold và có khả năng khiến performance của model đi xuống nếu quá nhiều trọng số bị tỉa đi. 
- Neuron pruning thì ngược lại, nó mạnh hơn, vì nó loại đi hoàn toàn các neurons thay vì các trọng số khác nhau của các neuron khác nhau. Tuy nhiên do nó quá mạnh, nên nếu quá đà thì mình cũng làm giảm độ chính xác của mô hình.

Tóm gọn lại, nếu muốn giảm độ phức tạp của mô hình thì weight pruning, giảm kích thước mô hình thì neuron pruning. Cần cân nhắc thêm giữa performance của mô hình trước và sau khi pruning nữa. 

Nói tổng quan hơn cho 2 cái kia, thì là **Structured pruning** và **Unstructered pruning**. <mark style="background: #ABF7F7A6;">Kết luận ở đây là nếu như sự thuận tiện và dễ cài là quan trọng, ta nên thực hiện structered pruning, còn nếu giảm hết mức độ phức tạp của mô hình thì ta nên thực hiện unstructered pruning .</mark>

## 4. Các kĩ thuật tỉa mô hình khác:

Một vài kĩ thuật tỉa mô hình khác cũng có thể được áp dụng bên cạnh 2 cái chính ở trên. 
- **Feature map pruning:**  Nôm na là loại bỏ bớt feature maps trong các mạng CNN thay vì một cái trọng số hay một cái neuron cụ thể nào đó, có thể thay thế cho weight và neuron pruning. 
- **Channel pruning**: Biến thể của cái trên, nhưng mà thay vì loại bỏ feature map cụ thể nào đó thì nó loại luôn cả 1 kênh, có thể thay thế cho weight và neuron pruning.
- **Iterative pruning**: Quá trình lặp đi lặp lại việc pruning một mô hình và tinh chỉnh cho tới khi nào mức độ phức tạp của mô hình nằm ở mức cho phép. Dễ kiểm soát nhất, song có thể tốn tài nguyên do phải thực hiện nhiều lần.  