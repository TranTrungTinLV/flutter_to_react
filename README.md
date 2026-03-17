# react_gen_flutter

Một Flutter project cho phép **React/Web developer** viết Flutter bằng cú pháp quen thuộc (HTML-style API + CSS-like styling), trong khi **Flutter developer** vẫn code Dart bình thường — cả hai cùng compile trong một app duy nhất.

---

## Bắt đầu nhanh

Thêm 1 dòng import vào bất kỳ file `.dart` nào:

```dart
import 'package:react_gen_flutter/react_flutter/react_flutter.dart';
```

---

## Dành cho React / Web Developer

Viết Flutter giống như bạn đang viết React JSX — dùng tên element HTML quen thuộc và `Style()` như CSS inline.

### Layout — `Div`

`Div` là widget linh hoạt nhất, tự động trở thành `Column`, `Row`, hoặc `Container` tùy theo `style`.

```dart
// Column (mặc định)
Div(
  style: Style(padding: 24, gap: 16, backgroundColor: '#fff'),
  children: [
    Text('Item 1'),
    Text('Item 2'),
  ],
)

// Row
Div(
  style: Style(display: 'flex', flexDirection: 'row', alignItems: 'center', gap: 12),
  children: [
    Icon(Icons.star),
    Text('Hello'),
  ],
)
```

> **Alias có sẵn:** `Section`, `Article`, `Main`, `Header`, `Footer`, `Nav`

---

### Typography

```dart
H1('Tiêu đề lớn')
H2('Tiêu đề vừa')
H3('Tiêu đề nhỏ')
H4('Sub heading')
H5('Label lớn')
H6('Label nhỏ')

P('Đây là đoạn văn bản bình thường.')
Span('Inline text')
Label('Email')
Strong('In đậm')
Em('In nghiêng')
Small('Chữ nhỏ / ghi chú')
Code('console.log("hello")')

Hr()           // Đường kẻ ngang
Br()           // Khoảng trống dọc (height: 16 mặc định)
Br(height: 32) // Tùy chỉnh
```

Tất cả text widget đều nhận thêm `style`:

```dart
H1('Chào mừng', style: Style(color: '#6c63ff', fontSize: 36))
P('Mô tả', style: Style(color: '#888', lineHeight: 24))
```

---

### Button

```dart
// Elevated (mặc định)
Button(label: 'Đăng nhập', onClick: () {})

// Với Style
Button(
  label: 'Submit',
  onClick: () {},
  style: Style(backgroundColor: '#6c63ff', color: '#fff', borderRadius: 10),
)

// Variants
Button(label: 'Text',     variant: ButtonVariant.text,     onClick: () {})
Button(label: 'Outlined', variant: ButtonVariant.outlined, onClick: () {})
Button(label: '+',        variant: ButtonVariant.icon,     onClick: () {})

// Trạng thái
Button(label: 'Đang tải...', loading: true,  onClick: () {})
Button(label: 'Bị tắt',     disabled: true, onClick: () {})

// Với icon
Button(
  label: 'Tải lên',
  onClick: () {},
  leadingIcon: Icon(Icons.upload),
)

// Widget con tùy chỉnh
Button(onClick: () {}, child: Row(children: [...]))
```

---

### Input / Form

```dart
// Text input
Input(placeholder: 'Nhập tên')

// Với giá trị và onChange
Input(
  type: InputType.email,
  placeholder: 'Email',
  value: email,
  onChange: (value) => setState(() => email = value),
)

// Các loại input
Input(type: InputType.text)       // Văn bản
Input(type: InputType.email)      // Email (keyboard phù hợp)
Input(type: InputType.password)   // Mật khẩu (ẩn ký tự + toggle)
Input(type: InputType.number)     // Số
Input(type: InputType.tel)        // Số điện thoại
Input(type: InputType.search)     // Tìm kiếm
Input(type: InputType.textarea)   // Nhiều dòng

// Với label và error
Input(
  label: 'Email',
  error: 'Email không hợp lệ',
  prefixIcon: Icon(Icons.email_outlined),
)

// Select / Dropdown
Select<String>(
  value: selectedCity,
  placeholder: 'Chọn thành phố',
  onChange: (v) => setState(() => selectedCity = v),
  options: [
    SelectOption(value: 'hn', label: 'Hà Nội'),
    SelectOption(value: 'hcm', label: 'TP.HCM'),
    SelectOption(value: 'dn', label: 'Đà Nẵng'),
  ],
)
```

---

### Image

```dart
// Asset
Img(src: 'assets/logo.png', width: 120, height: 80)

// Network (tự nhận biết)
Img(src: 'https://example.com/photo.jpg', width: 200, fit: BoxFit.cover)

// Bo góc
Img(src: 'assets/banner.jpg', style: Style(borderRadius: 12))

// Avatar tròn
Avatar(src: 'https://...', size: 48)
Avatar(src: 'assets/user.png', size: 40)
```

---

### Link

```dart
A(label: 'Xem thêm', onTap: () => Navigator.push(...))
A(
  label: 'Quên mật khẩu?',
  style: Style(color: '#6c63ff', fontSize: 13),
  onTap: () {},
)

// Widget con tùy chỉnh
A(onTap: () {}, child: Row(children: [Icon(Icons.link), Text('Link')]))
```

---

### List

```dart
// Danh sách bullet
Ul(children: [
  Li(text: 'Item 1'),
  Li(text: 'Item 2'),
  Li(child: Row(children: [Icon(Icons.star), Text('Custom')])),
])

// Danh sách số
Ol(children: [
  Li(text: 'Bước 1'),
  Li(text: 'Bước 2'),
])

// Render danh sách động (giống .map() trong React)
ReactList<String>(
  items: ['Flutter', 'React', 'Dart'],
  gap: 8,
  itemBuilder: (item, index) => Li(text: item),
)

// Scrollable list
ReactList<Product>(
  items: products,
  scrollable: true,
  gap: 12,
  itemBuilder: (product, i) => ProductCard(product: product),
)
```

---

## Style() — Tham khảo nhanh

```dart
Style(
  // Spacing
  padding: 16,
  paddingHorizontal: 20,  paddingVertical: 12,
  paddingTop: 8,  paddingBottom: 8,
  paddingLeft: 16,  paddingRight: 16,
  margin: 8,
  marginHorizontal: 16,  marginVertical: 8,

  // Kích thước
  width: 200,  height: 48,
  minWidth: 100,  maxWidth: 400,

  // Màu sắc (hỗ trợ: '#hex', 'rgba(r,g,b,a)', tên màu, Color)
  backgroundColor: '#6c63ff',
  backgroundColor: 'rgba(0,0,0,0.5)',
  backgroundColor: Colors.white,
  color: '#333',

  // Typography
  fontSize: 16,
  fontWeight: 'bold',      // 'normal', 'bold', '100'–'900'
  fontStyle: 'italic',
  lineHeight: 24,
  textAlign: 'center',     // 'left', 'right', 'justify'
  letterSpacing: 0.5,

  // Flexbox layout
  display: 'flex',
  flexDirection: 'row',    // 'column' (mặc định)
  justifyContent: 'center',  // 'flex-start', 'flex-end', 'space-between', 'space-around'
  alignItems: 'center',      // 'flex-start', 'flex-end', 'stretch'
  gap: 12,
  flex: 1,                   // tương đương Expanded

  // Border
  borderRadius: 8,
  borderTopLeftRadius: 8,  borderTopRightRadius: 8,
  borderWidth: 1.5,
  borderColor: '#e0e0e0',

  // Effects
  opacity: 0.8,
  boxShadow: [BoxShadow(color: Color(0x1A000000), blurRadius: 12, offset: Offset(0, 4))],
)
```

### Màu sắc được hỗ trợ

| Cú pháp | Ví dụ |
|---------|-------|
| Hex 6 chữ số | `'#6c63ff'` |
| Hex 3 chữ số | `'#fff'` |
| RGBA | `'rgba(108, 99, 255, 0.8)'` |
| Tên màu | `'white'`, `'black'`, `'red'`, `'blue'`, `'grey'`, `'green'`, ... |
| Flutter Color | `Colors.deepPurple` |

---

## Dành cho Flutter Developer

Bạn không cần thay đổi gì cả — code Flutter bình thường như trước. Và nếu muốn, có thể mix thêm các widget react_flutter vào bất cứ lúc nào:

```dart
// Flutter thuần
Container(
  padding: const EdgeInsets.all(20),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
  ),
  child: Column(
    children: [
      const Text('Hello', style: TextStyle(fontSize: 20)),

      // Mix với react_flutter ở đây — hoàn toàn ok!
      H3('Sub heading', style: Style(color: '#6c63ff')),
      Button(label: 'Click', onClick: () {}),
    ],
  ),
)
```

---

## Ví dụ đầy đủ: Login Screen

```dart
import 'package:flutter/material.dart';
import 'react_flutter/react_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '', password = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Div(
      style: Style(
        padding: 32,
        backgroundColor: '#f5f5f5',
        display: 'flex',
        flexDirection: 'column',
        gap: 16,
      ),
      children: [
        H1('Đăng nhập', style: Style(color: '#1a1a2e')),
        P('Chào mừng bạn quay trở lại!', style: Style(color: '#888')),
        Br(),

        Label('Email'),
        Input(
          type: InputType.email,
          placeholder: 'you@example.com',
          value: email,
          onChange: (v) => setState(() => email = v),
          prefixIcon: const Icon(Icons.email_outlined, size: 20),
        ),

        Label('Mật khẩu'),
        Input(
          type: InputType.password,
          placeholder: '••••••••',
          value: password,
          onChange: (v) => setState(() => password = v),
        ),

        Div(
          style: Style(display: 'flex', flexDirection: 'row', justifyContent: 'flex-end'),
          child: A(label: 'Quên mật khẩu?', style: Style(color: '#6c63ff'), onTap: () {}),
        ),

        SizedBox(
          width: double.infinity,
          child: Button(
            label: loading ? 'Đang đăng nhập...' : 'Đăng nhập',
            onClick: () async {
              setState(() => loading = true);
              await Future.delayed(const Duration(seconds: 2));
              setState(() => loading = false);
            },
            loading: loading,
            style: Style(
              backgroundColor: '#6c63ff',
              color: '#fff',
              borderRadius: 10,
              padding: 14,
            ),
          ),
        ),
      ],
    ),
  );
}
```

---

## Chạy project

```bash
# Chạy trên Windows
flutter run -d windows

# Chạy trên Chrome (web)
flutter run -d chrome

# Chạy trên Android/iOS
flutter run
```
