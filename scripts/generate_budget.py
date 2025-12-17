from pathlib import Path

from PIL import Image, ImageDraw

WIDTH, HEIGHT = 1360, 768

img = Image.new("RGB", (WIDTH, HEIGHT), (12, 12, 16))
draw = ImageDraw.Draw(img)

# Sidebar
draw.rectangle([0, 0, 220, HEIGHT], fill=(18, 19, 24))
draw.rounded_rectangle([40, 80, 200, 130], radius=18, fill=(44, 45, 52))

labels = ["대시보드", "분석", "거래내역", "설정"]
top = 160
for idx, label in enumerate(labels):
    box = [32, top - 12, 198, top + 28]
    if idx == 0:
        draw.rounded_rectangle(box, radius=14, fill=(45, 46, 54))
    draw.text((48, top), label, fill=(200, 200, 200))
    top += 60

# Header
draw.text((260, 60), "대시보드", fill=(230, 230, 230))
draw.text((260, 105), "2025년 11월 10일", fill=(180, 180, 180))

card_boxes = [
    (250, 150, 630, 360),
    (650, 150, 1030, 360),
    (1050, 150, 1330, 360),
]

for box in card_boxes:
    draw.rounded_rectangle(box, radius=28, fill=(27, 28, 34), outline=(55, 55, 60))
    draw.text((box[0] + 30, box[1] + 26), "￦2,000,000", fill=(240, 240, 240))

# Weekly chart
chart = (250, 380, 1030, 640)
draw.rounded_rectangle(chart, radius=28, fill=(20, 21, 26), outline=(55, 55, 60))
draw.text((chart[0] + 30, chart[1] + 30), "주간 지출 추이", fill=(220, 220, 220))

# Quick input panel
quick = (1050, 380, 1330, 640)
draw.rounded_rectangle(quick, radius=28, fill=(24, 24, 30), outline=(55, 55, 60))
draw.text((quick[0] + 30, quick[1] + 30), "빠른 지출 입력", fill=(230, 230, 230))

categories = ["식비", "교통", "쇼핑", "여가", "공과금", "의료", "기타"]
cx, cy = quick[0] + 30, quick[1] + 110
button_w, button_h = 110, 46
gap = 16
for idx, cat in enumerate(categories):
    row = idx // 2
    col = idx % 2
    x1 = cx + col * (button_w + gap)
    y1 = cy + row * (button_h + gap)
    rect = [x1, y1, x1 + button_w, y1 + button_h]
    fill = (58, 58, 66) if idx == 0 else (38, 39, 46)
    draw.rounded_rectangle(rect, radius=14, fill=fill)
    draw.text((x1 + 28, y1 + 12), cat, fill=(220, 220, 220))

output_path = Path(__file__).resolve().parents[1] / "img" / "budget-dashboard.png"
output_path.parent.mkdir(parents=True, exist_ok=True)
img.save(output_path)



