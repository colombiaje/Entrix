# Ruta a tu proyecto (ajústala si cambia)
$projectPath = "C:\Mega\Meerkat\Flutter nuevas\Sheets\Entrix con Google Sheets"

# 1. Ir al proyecto
Set-Location -Path $projectPath

# 2. Asegurarse de estar en main y limpio
git checkout main

# 3. Confirmar que no hay cambios sin guardar
$gitStatus = git status --porcelain
if ($gitStatus) {
    Write-Host "⚠️ Hay cambios sin commitear. Por favor revisa antes de continuar:"
    Write-Host $gitStatus
    exit 1
}

# 4. Limpiar y compilar la aplicación
flutter clean
flutter build web

if (-Not (Test-Path "$projectPath\build\web")) {
    Write-Error "❌ La carpeta build\web no se generó. Verifica si hubo errores de compilación."
    exit 1
}

# 5. Subir cambios en main (opcional según tu flujo)
git push origin main

Write-Host "`n✅ Flutter Web compilado y subido. GitHub Actions se encargará de desplegarlo automáticamente a gh-pages."
