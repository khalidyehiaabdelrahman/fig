@echo off
echo 🔨 Building APK with backup...

rem إنشاء مجلد النسخ الاحتياطية لو مش موجود
if not exist backups (
    mkdir backups
    echo 📁 Created backups folder.
)

rem حفظ التاريخ والوقت للاسم
set datetime=%date:~-4%-%date:~3,2%-%date:~0,2%_%time:~0,2%-%time:~3,2%
set datetime=%datetime: =0%

rem بناء الـ APK وبعدها نسخ النسخة الاحتياطية
flutter build apk --release && (
    copy "build\app\outputs\flutter-apk\app-release.apk" "backups\app-release-%datetime%.apk"
    echo ✅ APK saved as backups\app-release-%datetime%.apk
)

pause
