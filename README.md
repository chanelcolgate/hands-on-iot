## Download Node 10.x from the official website
## Enabling the project feature

Now let's try the project function. We will use a standalone version of Node-RED on a local environment such as macOs or Windows. In order to use the project feature, we first need to enable it. Let's enable it by following these steps:

1. It is necessary to rewrite tthe `setttings.js` file to enable/disable the project function. Look for this file first. The `settings.js` file can be found in the Node-RED user directory where all of the user configurations are stored.

By default, on a Mac, this file is available under the following path:
```
/Users/<User Name>/.node-red/settings.js

```

By default, on Windows, this file is available under the following path:
```
C:\Users\<User Name>/.node-red/settings.js
```

2. Edit the `settings.js` file. It is OK to open `settings.js` with any text editors. I have used `vi` here. Open `settings.js` with the following command:
```
$ vi /Users/<User Name>/.node-red/settings.js
```

3. Edit your `settings.js` file and set the `projects.enabled` element to `true` in the `editorTheme` block within the `module.exports` block in order for the project feature to be enabled:
```
module.exports = {
    uiPort: process.env.PORT || 1880,
    ...
    editorTheme: {
        projects: {
            enabled: true
        }
    },
    ...
}
```

4. Save and close the `settings.js` file

5. Restart Node-RED to enable the settings we modified by running the following command:
```
$ node-red
```

### Saving system state in NodeRED variables

There are three possible scopes for the system state in NodeRED:

1. **Node scope**: The variable saved at this level is only visible to the Node from which it was saved. The following two commands allow for saving the state, and retrieving the current value, respectively:
```
context.set('count', 5)
context.get('count')
```

2. **Flow scope**: The variable saved at this level is only visible to the flow from which it was saved. The corresponding commands are:

```
flow.set('count', 5)
flow.get('count')
```

3. **Global scope**: The variable saved at this level is visible everywhere in the app, i.e., every flow and every Node. The corresponding commands are:
```
global.set('count', 5)
global.set('count')
```

## Backup Grafana Dashboard

Use Provisioning + GitHub for Grafana:
1. Dashboard on Grafana
2. Save as copy at Dashboard
3. Commit to GitHub
4. Grafana auto pull dashboard in provisioning

## Restart Container
```bash
npm install -g pm2
chmod + x restart_container.sh
pm2 start restart_container.sh \
  --interpreter bash \
  --name restart-container \
  --cron "0 6 * * *" \
  --no-autorestart
pm2 save
pm2 startup
pm2 save
pm2 logs
```

- Permission docker
```bash
whoami\ngroups
sudo usermod -aG docker mind
newgrp docker
```

- kill

```bash
pm2 kill
```

Lỗi này xảy ra do file `pm2-mind.service` hiện tại vẫn đang dùng cấu hình cũ của PM2 (chế độ `Type=forking`) hoặc lệnh `ExecStart` gặp xung đột khi khởi động daemon.

Khi `Type=forking` được khai báo, `systemd` bắt buộc phải thấy PM2 trả về đúng PID của daemon ngầm. Nếu PM2 khởi động không đúng quy trình đó, `systemd` sẽ đánh giá là vi phạm protocol và báo lỗi ngay.

Hãy làm theo các bước dưới đây để **xóa sạch service bị lỗi và tạo lại một service chuẩn hoạt động 100%**:

---

## Bước 1: Khai báo lại app PM2 chuẩn (không có `--no-autorestart`)

Đảm bảo app của bạn đã được thêm đúng cách và lưu lại dump file:

```bash
# 1. Xóa app cũ
pm2 delete restart-container

# 2. Thêm lại app chạy cron (BỎ cờ --no-autorestart)
pm2 start restart_container.sh --interpreter bash --name restart-container --cron "0 6 * * *"

# 3. Lưu trạng thái
pm2 save

```

---

## Bước 2: Dừng service lỗi và dọn dẹp startup cũ

```bash
# Dừng service đang bị fail
sudo systemctl stop pm2-mind.service

# Bỏ đăng ký startup cũ
pm2 unstartup

```

---

## Bước 3: Tạo lại file Service chuẩn cho `systemd`

Mở file service bằng `nano`:

```bash
sudo nano /etc/systemd/system/pm2-mind.service

```

Xóa toàn bộ nội dung cũ trong file và **dán đoạn cấu hình chuẩn bên dưới vào** *(chế độ `Type=simple` giúp loại bỏ hoàn toàn lỗi protocol)*:

```ini
[Unit]
Description=PM2 process manager
After=network.target

[Service]
Type=simple
User=mind
WorkingDirectory=/home/mind
Environment=PATH=/home/mind/.nvm/versions/node/v22.22.3/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
Environment=PM2_HOME=/home/mind/.pm2

ExecStart=/home/mind/.nvm/versions/node/v22.22.3/lib/node_modules/pm2/bin/pm2 sysmon
ExecReload=/home/mind/.nvm/versions/node/v22.22.3/lib/node_modules/pm2/bin/pm2 reload all
ExecStop=/home/mind/.nvm/versions/node/v22.22.3/lib/node_modules/pm2/bin/pm2 kill

Restart=on-failure

[Install]
WantedBy=multi-user.target

```

*(Lưu file: Nhấn `Ctrl + O` ➔ `Enter` ➔ Thoát bằng `Ctrl + X`)*

---

## Bước 4: Kích hoạt và chạy Service

Nạp lại cấu hình `systemd` và bật service lên:

```bash
# Reload cấu hình systemd
sudo systemctl daemon-reload

# Bật tính năng tự khởi động cùng hệ thống
sudo systemctl enable pm2-mind

# Khởi chạy service ngay bây giờ
sudo systemctl start pm2-mind

```

---

## Bước 5: Kiểm tra kết quả

Chạy lệnh kiểm tra trạng thái:

```bash
systemctl status pm2-mind.service

```

Lúc này, dòng trạng thái sẽ đổi thành **`Active: active (running)`** màu xanh lá cây. Bạn có thể kiểm tra danh sách bằng `pm2 list` hoặc khởi động lại máy để nghiệm thu!
