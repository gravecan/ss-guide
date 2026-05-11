Clear-Host
$ErrorActionPreference = 'SilentlyContinue'

function Bolum-Yaz {
    param([string]$Baslik)
    Write-Host ""
    Write-Host ("=" * 90) -ForegroundColor DarkGray
    Write-Host $Baslik -ForegroundColor Cyan
    Write-Host ("=" * 90) -ForegroundColor DarkGray
}

function Bilgi-Yaz {
    param(
        [string]$Ad,
        [object]$Deger
    )
    $goster = if ($null -eq $Deger -or $Deger -eq '') { '<boş>' } else { $Deger }
    Write-Host ("{0,-26}: {1}" -f $Ad, $goster)
}

function Dosya-Zaman-Goster {
    param(
        [string]$Etiket,
        [string]$Yol
    )

    Write-Host ""
    Write-Host "[$Etiket]" -ForegroundColor Magenta
    Bilgi-Yaz "Yol" $Yol

    if (-not (Test-Path $Yol)) {
        Write-Host "Durum                     : Bulunamadı" -ForegroundColor Yellow
        return
    }

    $f = Get-Item $Yol
    $fark = (Get-Date) - $f.LastWriteTime

    Bilgi-Yaz "Durum" "Bulundu"
    Bilgi-Yaz "Boyut" "$($f.Length) byte"
    Bilgi-Yaz "Oluşturulma" $f.CreationTime
    Bilgi-Yaz "Son değiştirilme" $f.LastWriteTime
    Bilgi-Yaz "Son erişim" $f.LastAccessTime
    Bilgi-Yaz "Kaç gün önce" ([math]::Round($fark.TotalDays, 4))
    Bilgi-Yaz "Kaç saat önce" ([math]::Round($fark.TotalHours, 2))
    Bilgi-Yaz "Kaç dakika önce" ([math]::Round($fark.TotalMinutes, 2))

    if ($fark.TotalMinutes -le 20) {
        Write-Host "Uyarı                     : Son 20 dakika içinde değişmiş" -ForegroundColor Red
    } else {
        Write-Host "Uyarı                     : Son 20 dakika içinde değişiklik görünmüyor" -ForegroundColor Green
    }
}

function Klasor-EnSon-Degisenleri-Goster {
    param(
        [string]$Etiket,
        [string]$Klasor,
        [int]$Limit = 10
    )

    Write-Host ""
    Write-Host "[$Etiket]" -ForegroundColor Magenta
    Bilgi-Yaz "Klasör" $Klasor

    if (-not (Test-Path $Klasor)) {
        Write-Host "Durum                     : Bulunamadı" -ForegroundColor Yellow
        return
    }

    $dosyalar = Get-ChildItem -Path $Klasor -Recurse -Force -File -ErrorAction SilentlyContinue |
        Sort-Object LastWriteTime -Descending

    if (-not $dosyalar) {
        Write-Host "Durum                     : Dosya bulunamadı" -ForegroundColor Yellow
        return
    }

    Write-Host "En son değişen dosyalar:" -ForegroundColor DarkCyan
    $dosyalar | Select-Object -First $Limit | ForEach-Object {
        Write-Host ""
        Bilgi-Yaz "Ad" $_.Name
        Bilgi-Yaz "Yol" $_.FullName
        Bilgi-Yaz "Son değiştirilme" $_.LastWriteTime
        Bilgi-Yaz "Oluşturulma" $_.CreationTime
        Bilgi-Yaz "Son erişim" $_.LastAccessTime
    }
}

function ModelO-MCF-Dosyalarini-Goster {
    Bolum-Yaz 'Glorious Model O Software / BY-COMBO2 Mac Kontrolü'

    $klasor = Join-Path $env:LOCALAPPDATA 'BY-COMBO2\Mac'
    Bilgi-Yaz 'Klasör' $klasor

    if (-not (Test-Path $klasor)) {
        Write-Host "Durum                     : Klasör bulunamadı" -ForegroundColor Yellow
        return
    }

    $dosyalar = Get-ChildItem -Path $klasor -Filter '*.mcf' -File -Force -ErrorAction SilentlyContinue |
        Sort-Object LastWriteTime -Descending

    if (-not $dosyalar -or $dosyalar.Count -eq 0) {
        Write-Host "Durum                     : .mcf dosyası bulunamadı" -ForegroundColor Yellow
        return
    }

    $enSon = $dosyalar | Select-Object -First 1
    $fark = (Get-Date) - $enSon.LastWriteTime

    Write-Host ""
    Write-Host "[En Son Değişen .mcf Dosyası]" -ForegroundColor Magenta
    Bilgi-Yaz 'Ad' $enSon.Name
    Bilgi-Yaz 'Yol' $enSon.FullName
    Bilgi-Yaz 'Boyut' "$($enSon.Length) byte"
    Bilgi-Yaz 'Oluşturulma' $enSon.CreationTime
    Bilgi-Yaz 'Son değiştirilme' $enSon.LastWriteTime
    Bilgi-Yaz 'Son erişim' $enSon.LastAccessTime
    Bilgi-Yaz 'Kaç gün önce' ([math]::Round($fark.TotalDays, 4))
    Bilgi-Yaz 'Kaç saat önce' ([math]::Round($fark.TotalHours, 2))
    Bilgi-Yaz 'Kaç dakika önce' ([math]::Round($fark.TotalMinutes, 2))

    if ($fark.TotalMinutes -le 20) {
        Write-Host "Uyarı                     : Son 20 dakika içinde .mcf değişikliği var" -ForegroundColor Red
    } else {
        Write-Host "Uyarı                     : Son 20 dakika içinde .mcf değişikliği görünmüyor" -ForegroundColor Green
    }

    Write-Host ""
    Write-Host "Bulunan .mcf dosyaları:" -ForegroundColor DarkCyan

    foreach ($dosya in $dosyalar) {
        $dfark = (Get-Date) - $dosya.LastWriteTime

        Write-Host ""
        Bilgi-Yaz 'Ad' $dosya.Name
        Bilgi-Yaz 'Yol' $dosya.FullName
        Bilgi-Yaz 'Boyut' "$($dosya.Length) byte"
        Bilgi-Yaz 'Oluşturulma' $dosya.CreationTime
        Bilgi-Yaz 'Son değiştirilme' $dosya.LastWriteTime
        Bilgi-Yaz 'Son erişim' $dosya.LastAccessTime
        Bilgi-Yaz 'Kaç gün önce' ([math]::Round($dfark.TotalDays, 4))
        Bilgi-Yaz 'Kaç saat önce' ([math]::Round($dfark.TotalHours, 2))
        Bilgi-Yaz 'Kaç dakika önce' ([math]::Round($dfark.TotalMinutes, 2))

        if ($dfark.TotalMinutes -le 20) {
            Write-Host "Durum                     : Son 20 dakika içinde değişmiş" -ForegroundColor Red
        } else {
            Write-Host "Durum                     : Son 20 dakika içinde değişmemiş" -ForegroundColor Green
        }
    }
}

function ModelD-DCT-Dosyalarini-Goster {
    Bolum-Yaz 'Glorious Model D Software / BY-COMBO2 DCT Kontrolü'

    $klasor = Join-Path $env:LOCALAPPDATA 'BY-COMBO2'
    Bilgi-Yaz 'Klasör' $klasor

    if (-not (Test-Path $klasor)) {
        Write-Host "Durum                     : Klasör bulunamadı" -ForegroundColor Yellow
        return
    }

    $dosyalar = Get-ChildItem -Path $klasor -Filter '*.dct' -File -Force -ErrorAction SilentlyContinue |
        Sort-Object LastWriteTime -Descending

    if (-not $dosyalar -or $dosyalar.Count -eq 0) {
        Write-Host "Durum                     : .dct dosyası bulunamadı" -ForegroundColor Yellow
        return
    }

    $enSon = $dosyalar | Select-Object -First 1
    $fark = (Get-Date) - $enSon.LastWriteTime

    Write-Host ""
    Write-Host "[En Son Değişen .dct Dosyası]" -ForegroundColor Magenta
    Bilgi-Yaz 'Ad' $enSon.Name
    Bilgi-Yaz 'Yol' $enSon.FullName
    Bilgi-Yaz 'Boyut' "$($enSon.Length) byte"
    Bilgi-Yaz 'Oluşturulma' $enSon.CreationTime
    Bilgi-Yaz 'Son değiştirilme' $enSon.LastWriteTime
    Bilgi-Yaz 'Son erişim' $enSon.LastAccessTime
    Bilgi-Yaz 'Kaç gün önce' ([math]::Round($fark.TotalDays, 4))
    Bilgi-Yaz 'Kaç saat önce' ([math]::Round($fark.TotalHours, 2))
    Bilgi-Yaz 'Kaç dakika önce' ([math]::Round($fark.TotalMinutes, 2))

    if ($fark.TotalMinutes -le 20) {
        Write-Host "Uyarı                     : Son 20 dakika içinde .dct değişikliği var" -ForegroundColor Red
    } else {
        Write-Host "Uyarı                     : Son 20 dakika içinde .dct değişikliği görünmüyor" -ForegroundColor Green
    }

    Write-Host ""
    Write-Host "Bulunan .dct dosyaları:" -ForegroundColor DarkCyan

    foreach ($dosya in $dosyalar) {
        $dfark = (Get-Date) - $dosya.LastWriteTime

        Write-Host ""
        Bilgi-Yaz 'Ad' $dosya.Name
        Bilgi-Yaz 'Yol' $dosya.FullName
        Bilgi-Yaz 'Boyut' "$($dosya.Length) byte"
        Bilgi-Yaz 'Oluşturulma' $dosya.CreationTime
        Bilgi-Yaz 'Son değiştirilme' $dosya.LastWriteTime
        Bilgi-Yaz 'Son erişim' $dosya.LastAccessTime
        Bilgi-Yaz 'Kaç gün önce' ([math]::Round($dfark.TotalDays, 4))
        Bilgi-Yaz 'Kaç saat önce' ([math]::Round($dfark.TotalHours, 2))
        Bilgi-Yaz 'Kaç dakika önce' ([math]::Round($dfark.TotalMinutes, 2))

        if ($dfark.TotalMinutes -le 20) {
            Write-Host "Durum                     : Son 20 dakika içinde değişmiş" -ForegroundColor Red
        } else {
            Write-Host "Durum                     : Son 20 dakika içinde değişmemiş" -ForegroundColor Green
        }
    }
}

function Bloody7-Makro-Dosyalarini-Goster {
    Bolum-Yaz 'Bloody7 Macro Kontrolü'

    $klasor = "${env:ProgramFiles(x86)}\Bloody7\Bloody7\Data\Mouse\English\ScriptsMacros\GunLib\MMO,FPS,Office COMBO Examples"
    Bilgi-Yaz 'Klasör' $klasor

    if (-not (Test-Path $klasor)) {
        Write-Host "Durum                     : Klasör bulunamadı" -ForegroundColor Yellow
        return
    }

    $dosyalar = Get-ChildItem -Path $klasor -File -Force -ErrorAction SilentlyContinue |
        Sort-Object LastWriteTime -Descending

    if (-not $dosyalar -or $dosyalar.Count -eq 0) {
        Write-Host "Durum                     : Dosya bulunamadı" -ForegroundColor Yellow
        return
    }

    $enSon = $dosyalar | Select-Object -First 1
    $fark = (Get-Date) - $enSon.LastWriteTime

    Write-Host ""
    Write-Host "[En Son Değişen Bloody Dosyası]" -ForegroundColor Magenta
    Bilgi-Yaz 'Ad' $enSon.Name
    Bilgi-Yaz 'Yol' $enSon.FullName
    Bilgi-Yaz 'Boyut' "$($enSon.Length) byte"
    Bilgi-Yaz 'Oluşturulma' $enSon.CreationTime
    Bilgi-Yaz 'Son değiştirilme' $enSon.LastWriteTime
    Bilgi-Yaz 'Son erişim' $enSon.LastAccessTime
    Bilgi-Yaz 'Kaç gün önce' ([math]::Round($fark.TotalDays, 4))
    Bilgi-Yaz 'Kaç saat önce' ([math]::Round($fark.TotalHours, 2))
    Bilgi-Yaz 'Kaç dakika önce' ([math]::Round($fark.TotalMinutes, 2))

    if ($fark.TotalMinutes -le 20) {
        Write-Host "Uyarı                     : Son 20 dakika içinde Bloody makro klasöründe değişiklik var" -ForegroundColor Red
    } else {
        Write-Host "Uyarı                     : Son 20 dakika içinde değişiklik görünmüyor" -ForegroundColor Green
    }

    Write-Host ""
    Write-Host "Bulunan dosyalar:" -ForegroundColor DarkCyan

    foreach ($dosya in $dosyalar) {
        $dfark = (Get-Date) - $dosya.LastWriteTime

        Write-Host ""
        Bilgi-Yaz 'Ad' $dosya.Name
        Bilgi-Yaz 'Yol' $dosya.FullName
        Bilgi-Yaz 'Uzantı' $dosya.Extension
        Bilgi-Yaz 'Boyut' "$($dosya.Length) byte"
        Bilgi-Yaz 'Oluşturulma' $dosya.CreationTime
        Bilgi-Yaz 'Son değiştirilme' $dosya.LastWriteTime
        Bilgi-Yaz 'Son erişim' $dosya.LastAccessTime
        Bilgi-Yaz 'Kaç gün önce' ([math]::Round($dfark.TotalDays, 4))
        Bilgi-Yaz 'Kaç saat önce' ([math]::Round($dfark.TotalHours, 2))
        Bilgi-Yaz 'Kaç dakika önce' ([math]::Round($dfark.TotalMinutes, 2))

        if ($dfark.TotalMinutes -le 20) {
            Write-Host "Durum                     : Son 20 dakika içinde değişmiş" -ForegroundColor Red
        } else {
            Write-Host "Durum                     : Son 20 dakika içinde değişmemiş" -ForegroundColor Green
        }
    }

    Write-Host ""
    Write-Host "Öne çıkan uzantılar:" -ForegroundColor DarkCyan
    $ilgili = $dosyalar | Where-Object { $_.Extension -match '^\.(amc2|mgn2|bwp|bmc|bwd|cfg|ini)$' }

    if ($ilgili) {
        foreach ($d in $ilgili) {
            Write-Host ("- {0} ({1}) | {2}" -f $d.Name, $d.Extension, $d.LastWriteTime)
        }
    } else {
        Write-Host "İlgili uzantıda dosya bulunamadı." -ForegroundColor Yellow
    }
}

function Corsair-CUE-Config-Goster {
    Bolum-Yaz 'Corsair CUE Config Kontrolü'

    $klasor = Join-Path $env:APPDATA 'Corsair\CUE'
    $dosya  = Join-Path $klasor 'config.cuecfg'

    Bilgi-Yaz 'Klasör' $klasor
    Bilgi-Yaz 'Dosya'  $dosya

    if (-not (Test-Path $dosya)) {
        Write-Host "Durum                     : config.cuecfg bulunamadı" -ForegroundColor Yellow
        return
    }

    $f = Get-Item $dosya
    $fark = (Get-Date) - $f.LastWriteTime

    Write-Host ""
    Write-Host "[config.cuecfg]" -ForegroundColor Magenta
    Bilgi-Yaz 'Ad' $f.Name
    Bilgi-Yaz 'Yol' $f.FullName
    Bilgi-Yaz 'Boyut' "$($f.Length) byte"
    Bilgi-Yaz 'Oluşturulma' $f.CreationTime
    Bilgi-Yaz 'Son değiştirilme' $f.LastWriteTime
    Bilgi-Yaz 'Son erişim' $f.LastAccessTime
    Bilgi-Yaz 'Kaç gün önce' ([math]::Round($fark.TotalDays, 4))
    Bilgi-Yaz 'Kaç saat önce' ([math]::Round($fark.TotalHours, 2))
    Bilgi-Yaz 'Kaç dakika önce' ([math]::Round($fark.TotalMinutes, 2))

    if ($fark.TotalMinutes -le 20) {
        Write-Host "Uyarı                     : Son 20 dakika içinde config.cuecfg değişmiş" -ForegroundColor Red
    } else {
        Write-Host "Uyarı                     : Son 20 dakika içinde değişiklik görünmüyor" -ForegroundColor Green
    }

    Write-Host ""
    Write-Host "Aynı klasördeki diğer öğeler:" -ForegroundColor DarkCyan

    $ogeler = Get-ChildItem -Path $klasor -Force -ErrorAction SilentlyContinue |
        Sort-Object LastWriteTime -Descending

    foreach ($oge in $ogeler) {
        Write-Host ""
        Bilgi-Yaz 'Ad' $oge.Name
        Bilgi-Yaz 'Tür' ($(if ($oge.PSIsContainer) { 'Klasör' } else { 'Dosya' }))
        Bilgi-Yaz 'Yol' $oge.FullName
        Bilgi-Yaz 'Son değiştirilme' $oge.LastWriteTime
        Bilgi-Yaz 'Oluşturulma' $oge.CreationTime
        Bilgi-Yaz 'Son erişim' $oge.LastAccessTime
    }
}

function Logitech-OldSoftware-Goster {
    Bolum-Yaz 'Logitech Gaming Software (Old) Kontrolü'

    $klasor = Join-Path $env:LOCALAPPDATA 'Logitech\Logitech Gaming Software'
    $dosya = Join-Path $klasor 'settings.json'

    Bilgi-Yaz 'Klasör' $klasor
    Bilgi-Yaz 'Dosya' $dosya

    if (-not (Test-Path $dosya)) {
        Write-Host "Durum                     : settings.json bulunamadı" -ForegroundColor Yellow
        return
    }

    $f = Get-Item $dosya
    $fark = (Get-Date) - $f.LastWriteTime

    Write-Host ""
    Write-Host "[settings.json]" -ForegroundColor Magenta
    Bilgi-Yaz 'Ad' $f.Name
    Bilgi-Yaz 'Yol' $f.FullName
    Bilgi-Yaz 'Boyut' "$($f.Length) byte"
    Bilgi-Yaz 'Oluşturulma' $f.CreationTime
    Bilgi-Yaz 'Son değiştirilme' $f.LastWriteTime
    Bilgi-Yaz 'Son erişim' $f.LastAccessTime
    Bilgi-Yaz 'Kaç gün önce' ([math]::Round($fark.TotalDays, 4))
    Bilgi-Yaz 'Kaç saat önce' ([math]::Round($fark.TotalHours, 2))
    Bilgi-Yaz 'Kaç dakika önce' ([math]::Round($fark.TotalMinutes, 2))

    if ($fark.TotalMinutes -le 20) {
        Write-Host "Uyarı                     : Son 20 dakika içinde settings.json değişmiş" -ForegroundColor Red
    } else {
        Write-Host "Uyarı                     : Son 20 dakika içinde değişiklik görünmüyor" -ForegroundColor Green
    }
}

function SQLite-Araci-Bul {
    $sqlite3 = Get-Command sqlite3 -ErrorAction SilentlyContinue
    if ($sqlite3) {
        return @{
            Tip = 'sqlite3'
            Yol = $sqlite3.Source
        }
    }

    $py = Get-Command py -ErrorAction SilentlyContinue
    if ($py) {
        return @{
            Tip = 'py'
            Yol = $py.Source
        }
    }

    $python = Get-Command python -ErrorAction SilentlyContinue
    if ($python) {
        return @{
            Tip = 'python'
            Yol = $python.Source
        }
    }

    return $null
}

function Gecici-Kopya-Olustur {
    param([string]$Kaynak)

    if (-not (Test-Path $Kaynak)) { return $null }

    $hedef = Join-Path $env:TEMP ("trss_" + [guid]::NewGuid().ToString() + "_" + [IO.Path]::GetFileName($Kaynak))
    Copy-Item -Path $Kaynak -Destination $hedef -Force
    return $hedef
}

function Chromium-Zaman-Donustur {
    param([double]$Deger)

    if (-not $Deger -or $Deger -le 0) { return $null }

    try {
        $base = [datetime]::SpecifyKind([datetime]'1601-01-01 00:00:00', [System.DateTimeKind]::Utc)
        return $base.AddMilliseconds($Deger / 1000)
    } catch {
        return $null
    }
}

function Firefox-Zaman-Donustur {
    param([double]$Deger)

    if (-not $Deger -or $Deger -le 0) { return $null }

    try {
        $base = [datetime]::SpecifyKind([datetime]'1970-01-01 00:00:00', [System.DateTimeKind]::Utc)
        return $base.AddMilliseconds($Deger / 1000)
    } catch {
        return $null
    }
}

function SQLite-Sorgu-Calistir {
    param(
        [string]$VeritabaniYolu,
        [string]$Sorgu
    )

    $arac = SQLite-Araci-Bul
    if (-not $arac) {
        return @{
            Basarili = $false
            Hata = 'sqlite3 / py / python bulunamadı'
            Satirlar = @()
        }
    }

    switch ($arac.Tip) {
        'sqlite3' {
            $sonuc = & $arac.Yol -readonly -separator "`t" $VeritabaniYolu $Sorgu 2>$null
            return @{
                Basarili = $true
                Hata = $null
                Satirlar = @($sonuc)
            }
        }

        'py' {
            $kod = @"
import sqlite3, sys
db = sys.argv[1]
query = sys.argv[2]
con = sqlite3.connect(db)
cur = con.cursor()
rows = cur.execute(query).fetchall()
for r in rows:
    print("\t".join("" if x is None else str(x) for x in r))
con.close()
"@
            $sonuc = & $arac.Yol -3 -c $kod $VeritabaniYolu $Sorgu 2>$null
            return @{
                Basarili = $true
                Hata = $null
                Satirlar = @($sonuc)
            }
        }

        'python' {
            $kod = @"
import sqlite3, sys
db = sys.argv[1]
query = sys.argv[2]
con = sqlite3.connect(db)
cur = con.cursor()
rows = cur.execute(query).fetchall()
for r in rows:
    print("\t".join("" if x is None else str(x) for x in r))
con.close()
"@
            $sonuc = & $arac.Yol -c $kod $VeritabaniYolu $Sorgu 2>$null
            return @{
                Basarili = $true
                Hata = $null
                Satirlar = @($sonuc)
            }
        }
    }

    return @{
        Basarili = $false
        Hata = 'Bilinmeyen SQLite yöntemi'
        Satirlar = @()
    }
}

function Chromium-Browser-KontrolEt {
    param(
        [string]$BrowserAdi,
        [string[]]$HistoryYollari,
        [array]$Hedefler
    )

    Bolum-Yaz "$BrowserAdi History Kontrolü"

    $bulunduMu = $false

    foreach ($historyYolu in $HistoryYollari | Select-Object -Unique) {
        if (-not (Test-Path $historyYolu)) { continue }

        $bulunduMu = $true
        Bilgi-Yaz 'History DB' $historyYolu

        $gecici = Gecici-Kopya-Olustur -Kaynak $historyYolu
        if (-not $gecici) {
            Write-Host "History kopyalanamadı." -ForegroundColor Yellow
            continue
        }

        foreach ($hedef in $Hedefler) {
            $isim = $hedef.Isim
            $kosullar = @()

            foreach ($alan in $hedef.Alanlar) {
                $alanTemiz = $alan.Replace("'", "''")
                $kosullar += "url LIKE '%$alanTemiz%'"
            }

            $where = $kosullar -join ' OR '

            $sorgu = @"
SELECT urls.url, visits.visit_time
FROM urls
JOIN visits ON urls.id = visits.url
WHERE ($where)
ORDER BY visits.visit_time DESC
LIMIT 1;
"@

            $sonuc = SQLite-Sorgu-Calistir -VeritabaniYolu $gecici -Sorgu $sorgu

            Write-Host ""
            Write-Host "[$isim]" -ForegroundColor Magenta

            if (-not $sonuc.Basarili) {
                Write-Host "Exact ziyaret zamanı okunamadı: $($sonuc.Hata)" -ForegroundColor Yellow
                continue
            }

            $satir = $sonuc.Satirlar | Where-Object { $_ -and $_.Trim() -ne '' } | Select-Object -First 1

            if (-not $satir) {
                Write-Host "Durum                     : Eşleşme bulunamadı" -ForegroundColor Green
                continue
            }

            $parcalar = $satir -split "`t", 2
            if ($parcalar.Count -lt 2) {
                Write-Host "Durum                     : Sonuç parse edilemedi" -ForegroundColor Yellow
                continue
            }

            $url = $parcalar[0]
            $rawZaman = [double]$parcalar[1]
            $zaman = Chromium-Zaman-Donustur -Deger $rawZaman

            Bilgi-Yaz 'Son URL' $url
            Bilgi-Yaz 'UTC Zaman' $zaman

            if ($zaman) {
                $yerel = $zaman.ToLocalTime()
                $fark = (Get-Date) - $yerel
                Bilgi-Yaz 'Yerel Zaman' $yerel
                Bilgi-Yaz 'Kaç gün önce' ([math]::Round($fark.TotalDays, 4))
                Bilgi-Yaz 'Kaç saat önce' ([math]::Round($fark.TotalHours, 2))
                Bilgi-Yaz 'Kaç dakika önce' ([math]::Round($fark.TotalMinutes, 2))

                if ($fark.TotalMinutes -le 20) {
                    Write-Host "Uyarı                     : Son 20 dakika içinde ziyaret edilmiş" -ForegroundColor Red
                } else {
                    Write-Host "Uyarı                     : Son 20 dakika içinde ziyaret görünmüyor" -ForegroundColor Green
                }
            }
        }

        Remove-Item $gecici -Force -ErrorAction SilentlyContinue
    }

    if (-not $bulunduMu) {
        Write-Host "History veritabanı bulunamadı." -ForegroundColor Yellow
    }
}

function Firefox-KontrolEt {
    param([array]$Hedefler)

    Bolum-Yaz 'Mozilla Firefox History Kontrolü'

    $profilKoku = Join-Path $env:APPDATA 'Mozilla\Firefox\Profiles'
    if (-not (Test-Path $profilKoku)) {
        Write-Host "Firefox profil klasörü bulunamadı." -ForegroundColor Yellow
        return
    }

    $dbler = Get-ChildItem -Path $profilKoku -Recurse -Filter 'places.sqlite' -File -ErrorAction SilentlyContinue
    if (-not $dbler) {
        Write-Host "places.sqlite bulunamadı." -ForegroundColor Yellow
        return
    }

    foreach ($db in $dbler) {
        Bilgi-Yaz 'places.sqlite' $db.FullName

        $gecici = Gecici-Kopya-Olustur -Kaynak $db.FullName
        if (-not $gecici) {
            Write-Host "History kopyalanamadı." -ForegroundColor Yellow
            continue
        }

        foreach ($hedef in $Hedefler) {
            $isim = $hedef.Isim
            $kosullar = @()

            foreach ($alan in $hedef.Alanlar) {
                $alanTemiz = $alan.Replace("'", "''")
                $kosullar += "moz_places.url LIKE '%$alanTemiz%'"
            }

            $where = $kosullar -join ' OR '

            $sorgu = @"
SELECT moz_places.url, moz_historyvisits.visit_date
FROM moz_places
JOIN moz_historyvisits ON moz_places.id = moz_historyvisits.place_id
WHERE ($where)
ORDER BY moz_historyvisits.visit_date DESC
LIMIT 1;
"@

            $sonuc = SQLite-Sorgu-Calistir -VeritabaniYolu $gecici -Sorgu $sorgu

            Write-Host ""
            Write-Host "[$isim]" -ForegroundColor Magenta

            if (-not $sonuc.Basarili) {
                Write-Host "Exact ziyaret zamanı okunamadı: $($sonuc.Hata)" -ForegroundColor Yellow
                continue
            }

            $satir = $sonuc.Satirlar | Where-Object { $_ -and $_.Trim() -ne '' } | Select-Object -First 1
            if (-not $satir) {
                Write-Host "Durum                     : Eşleşme bulunamadı" -ForegroundColor Green
                continue
            }

            $parcalar = $satir -split "`t", 2
            if ($parcalar.Count -lt 2) {
                Write-Host "Durum                     : Sonuç parse edilemedi" -ForegroundColor Yellow
                continue
            }

            $url = $parcalar[0]
            $rawZaman = [double]$parcalar[1]
            $zaman = Firefox-Zaman-Donustur -Deger $rawZaman

            Bilgi-Yaz 'Son URL' $url
            Bilgi-Yaz 'UTC Zaman' $zaman

            if ($zaman) {
                $yerel = $zaman.ToLocalTime()
                $fark = (Get-Date) - $yerel
                Bilgi-Yaz 'Yerel Zaman' $yerel
                Bilgi-Yaz 'Kaç gün önce' ([math]::Round($fark.TotalDays, 4))
                Bilgi-Yaz 'Kaç saat önce' ([math]::Round($fark.TotalHours, 2))
                Bilgi-Yaz 'Kaç dakika önce' ([math]::Round($fark.TotalMinutes, 2))

                if ($fark.TotalMinutes -le 20) {
                    Write-Host "Uyarı                     : Son 20 dakika içinde ziyaret edilmiş" -ForegroundColor Red
                } else {
                    Write-Host "Uyarı                     : Son 20 dakika içinde ziyaret görünmüyor" -ForegroundColor Green
                }
            }
        }

        Remove-Item $gecici -Force -ErrorAction SilentlyContinue
    }
}

function Browser-WebSoftware-Ziyaretlerini-Goster {
    Bolum-Yaz 'Browser Web Software Visit Checker'

    $sqliteAraci = SQLite-Araci-Bul
    if ($sqliteAraci) {
        Bilgi-Yaz 'SQLite yöntemi' "$($sqliteAraci.Tip) -> $($sqliteAraci.Yol)"
    } else {
        Bilgi-Yaz 'SQLite yöntemi' 'Bulunamadı'
        Write-Host "Exact ziyaret zamanı için sqlite3 veya Python gerekir." -ForegroundColor Yellow
    }

    $Hedefler = @(
        @{
            Isim = 'LAMZU Web Hub'
            Alanlar = @('lamzu.net', 'lamzu.com')
        },
        @{
            Isim = 'Keychron Launcher'
            Alanlar = @('launcher.keychron.com')
        },
        @{
            Isim = 'WLmouse Web Hub'
            Alanlar = @('wlmouse.com/pages/web-hub', 'gm.wlmouse.gg', 'chn.wlmouse.com')
        },
        @{
            Isim = 'Corsair Web Hub'
            Alanlar = @('corsair.com/web-hub', 'corsair.com/sabre-web-hub')
        },
        @{
            Isim = 'Razer Browser-Based Customization'
            Alanlar = @('synapse.razer.com', 'razer.com/synapse-4')
        }
    )

    $ChromeYollari = @(
        (Join-Path $env:LOCALAPPDATA 'Google\Chrome\User Data\Default\History')
    ) + (
        Get-ChildItem -Path (Join-Path $env:LOCALAPPDATA 'Google\Chrome\User Data') -Directory -ErrorAction SilentlyContinue |
        Where-Object { $_.Name -match '^Profile \d+$' } |
        ForEach-Object { Join-Path $_.FullName 'History' }
    )

    $EdgeYollari = @(
        (Join-Path $env:LOCALAPPDATA 'Microsoft\Edge\User Data\Default\History')
    ) + (
        Get-ChildItem -Path (Join-Path $env:LOCALAPPDATA 'Microsoft\Edge\User Data') -Directory -ErrorAction SilentlyContinue |
        Where-Object { $_.Name -match '^Profile \d+$' } |
        ForEach-Object { Join-Path $_.FullName 'History' }
    )

    $BraveYollari = @(
        (Join-Path $env:LOCALAPPDATA 'BraveSoftware\Brave-Browser\User Data\Default\History')
    ) + (
        Get-ChildItem -Path (Join-Path $env:LOCALAPPDATA 'BraveSoftware\Brave-Browser\User Data') -Directory -ErrorAction SilentlyContinue |
        Where-Object { $_.Name -match '^Profile \d+$' } |
        ForEach-Object { Join-Path $_.FullName 'History' }
    )

    $OperaYollari = @(
        (Join-Path $env:APPDATA 'Opera Software\Opera Stable\History'),
        (Join-Path $env:APPDATA 'Opera Software\Opera GX Stable\History')
    )

    $VivaldiYollari = @(
        (Join-Path $env:LOCALAPPDATA 'Vivaldi\User Data\Default\History')
    ) + (
        Get-ChildItem -Path (Join-Path $env:LOCALAPPDATA 'Vivaldi\User Data') -Directory -ErrorAction SilentlyContinue |
        Where-Object { $_.Name -match '^Profile \d+$' } |
        ForEach-Object { Join-Path $_.FullName 'History' }
    )

    $YandexYollari = @(
        (Join-Path $env:LOCALAPPDATA 'Yandex\YandexBrowser\User Data\Default\History')
    ) + (
        Get-ChildItem -Path (Join-Path $env:LOCALAPPDATA 'Yandex\YandexBrowser\User Data') -Directory -ErrorAction SilentlyContinue |
        Where-Object { $_.Name -match '^Profile \d+$' } |
        ForEach-Object { Join-Path $_.FullName 'History' }
    )

    Chromium-Browser-KontrolEt -BrowserAdi 'Google Chrome' -HistoryYollari $ChromeYollari -Hedefler $Hedefler
    Chromium-Browser-KontrolEt -BrowserAdi 'Microsoft Edge' -HistoryYollari $EdgeYollari -Hedefler $Hedefler
    Chromium-Browser-KontrolEt -BrowserAdi 'Brave' -HistoryYollari $BraveYollari -Hedefler $Hedefler
    Chromium-Browser-KontrolEt -BrowserAdi 'Opera / Opera GX' -HistoryYollari $OperaYollari -Hedefler $Hedefler
    Chromium-Browser-KontrolEt -BrowserAdi 'Vivaldi' -HistoryYollari $VivaldiYollari -Hedefler $Hedefler
    Chromium-Browser-KontrolEt -BrowserAdi 'Yandex Browser' -HistoryYollari $YandexYollari -Hedefler $Hedefler
    Firefox-KontrolEt -Hedefler $Hedefler
}

Bolum-Yaz 'TRSS Mouse Macro / Profile Time Checker'

# Logitech G HUB
$logitechBase = Join-Path $env:LOCALAPPDATA 'LGHUB'
$logitechSettings = Join-Path $logitechBase 'settings.db'
Dosya-Zaman-Goster -Etiket 'Logitech G HUB - settings.db' -Yol $logitechSettings

# Logitech Old Software
Logitech-OldSoftware-Goster

# Glorious Core
$gloriousBase = Join-Path $env:APPDATA 'Glorious Core\datastore'
$gloriousProfiles = Join-Path $gloriousBase 'DeviceProfiles.json'
$gloriousMacros = Join-Path $gloriousBase 'Macros.json'
Dosya-Zaman-Goster -Etiket 'Glorious Core - DeviceProfiles.json' -Yol $gloriousProfiles
Dosya-Zaman-Goster -Etiket 'Glorious Core - Macros.json' -Yol $gloriousMacros

# ROCCAT / Swarm II
$swarm2Base = Join-Path $env:APPDATA 'TurtleBeach\SWARMII'
Klasor-EnSon-Degisenleri-Goster -Etiket 'ROCCAT / Turtle Beach - SWARMII' -Klasor $swarm2Base -Limit 10

# Glorious Model O
ModelO-MCF-Dosyalarini-Goster

# Glorious Model D
ModelD-DCT-Dosyalarini-Goster

# Bloody7
Bloody7-Makro-Dosyalarini-Goster

# Corsair
Corsair-CUE-Config-Goster

# Browser web software history check
Browser-WebSoftware-Ziyaretlerini-Goster

Write-Host ""
Write-Host "Tamamlandı." -ForegroundColor Cyan
