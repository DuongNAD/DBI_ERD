# Hướng dẫn Sử dụng các Script Python Sinh Sơ đồ ERD Bệnh viện

Tài liệu này hướng dẫn cách sử dụng các script Python (`generate_*.py`) trong dự án để phân tích cú pháp SQL DDL và tự động sinh sơ đồ Thực thể - Liên kết (ERD) chuẩn Chen dưới dạng hình ảnh.

---

## 📄 Danh sách các Script Sinh ERD

Dự án cung cấp các script tương ứng với từng phân hệ của Hệ thống Thông tin Bệnh viện và một script tổng hợp:

| Tên File Script | Phân hệ / Nội dung chức năng | Sơ đồ đầu ra tương ứng |
| :--- | :--- | :--- |
| **[generate_complete_erd.py](file:///e:/test/drawERD/generate_complete_erd.py)** | **Toàn cảnh hệ thống** (Tích hợp cả 6 phân hệ) | `complete_erd.dot`, `complete_erd.svg`, `complete_erd.png` |
| **[generate_BenhNhan_TiepDon.py](file:///e:/test/drawERD/generate_BenhNhan_TiepDon.py)** | **Phân hệ 1**: Bệnh nhân & Tiếp đón | `BenhNhan_TiepDon_Academic.dot`, `.svg`, `.png` |
| **[generate_ChanDoan_PhacDo.py](file:///e:/test/drawERD/generate_ChanDoan_PhacDo.py)** | **Phân hệ 2**: Chẩn đoán & Điều trị | `ChanDoan_PhacDo_Academic.dot`, `.svg`, `.png` |
| **[generate_XetNghiem_CDHA.py](file:///e:/test/drawERD/generate_XetNghiem_CDHA.py)** | **Phân hệ 3**: Xét nghiệm & Chẩn đoán hình ảnh | `XetNghiem_CDHA_Academic.dot`, `.svg`, `.png` |
| **[generate_NhanSu_KhoaPhong.py](file:///e:/test/drawERD/generate_NhanSu_KhoaPhong.py)** | **Phân hệ 4**: Nhân sự & Khoa phòng | `NhanSu_KhoaPhong_Academic.dot`, `.svg`, `.png` |
| **[generate_Duoc_VatTu.py](file:///e:/test/drawERD/generate_Duoc_VatTu.py)** | **Phân hệ 5**: Dược & Vật tư y tế | `Duoc_VatTu_Academic.dot`, `.svg`, `.png` |
| **[generate_VienPhi_TaiChinh.py](file:///e:/test/drawERD/generate_VienPhi_TaiChinh.py)** | **Phân hệ 6**: Tài chính & Viện phí | `VienPhi_TaiChinh_Academic.dot`, `.svg`, `.png` |
| **[generate_erd_from_sql.py](file:///e:/test/drawERD/generate_erd_from_sql.py)** | Script mẫu chung sinh ERD từ SQL DDL | `NhanSu_KhoaPhong_Academic.dot`, `.svg`, `.png` |

---

## 🛠️ Yêu cầu Hệ thống & Cài đặt Thư viện

Để chạy các script Python này và biên dịch thành công sơ đồ ra định dạng ảnh, hệ thống của bạn cần đáp ứng các điều kiện sau:

### 1. Python 3
Đảm bảo máy tính đã cài đặt Python phiên bản 3.x. Bạn có thể kiểm tra bằng lệnh:
```bash
python --version
```

### 2. Công cụ Graphviz (Bắt buộc)
Các script Python sử dụng thư viện hệ thống `subprocess` để gọi trực tiếp lệnh của **Graphviz** nhằm chuyển đổi file mô tả cấu trúc đồ thị `.dot` sang định dạng ảnh vector `.svg` hoặc ảnh raster `.png`.

* **Cách cài đặt Graphviz:**
  * **Windows:** 
    * Tải bản cài đặt `.exe` từ trang chủ [Graphviz Download](https://graphviz.org/download/).
    * Hoặc sử dụng Windows Package Manager:
      ```powershell
      winget install Infraware.Graphviz
      ```
    * *Lưu ý:* Trong quá trình cài đặt, hãy tích chọn tùy chọn **"Add Graphviz to the system PATH"** để hệ thống có thể nhận diện lệnh `dot`.
  * **macOS:** Sử dụng Homebrew:
    ```bash
    brew install graphviz
    ```
  * **Linux (Ubuntu/Debian):** Sử dụng apt:
    ```bash
    sudo apt update
    sudo apt install graphviz
    ```

* **Kiểm tra cài đặt:** Chạy lệnh sau trong Terminal/Command Prompt để xác nhận Graphviz đã được cấu hình đúng trong `PATH`:
  ```bash
  dot -V
  ```

---

## 🚀 Hướng dẫn Chạy Script

1. Mở Command Prompt hoặc PowerShell và di chuyển tới thư mục chứa dự án `drawERD`:
   ```powershell
   cd e:\test\drawERD
   ```

2. Thực thi script sinh ERD cho phân hệ mong muốn. Ví dụ, để sinh sơ đồ ERD hoàn chỉnh tích hợp 6 phân hệ, chạy lệnh:
   ```bash
   python generate_complete_erd.py
   ```

3. Sau khi chạy hoàn tất, script sẽ tự động tạo ra 3 file kết quả tương ứng trong thư mục hiện hành:
   * File đặc tả Graphviz: `complete_erd.dot`
   * Sơ đồ dạng ảnh vector: `complete_erd.svg`
   * Sơ đồ dạng ảnh thông thường: `complete_erd.png`
