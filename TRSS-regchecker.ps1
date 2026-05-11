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
    Write-Host ("{0,-30}: {1}" -f $Ad, $goster)
}

function Kayit-Anahtari-VarMi {
    param([string]$Yol)
    return [bool](Test-Path $Yol)
}

function Kayit-Degerlerini-Al {
    param([string]$Yol)

    if (-not (Test-Path $Yol)) {
        return $null
    }

    $oge = Get-ItemProperty -Path $Yol
    $ozellikler = $oge.PSObject.Properties | Where-Object {
        $_.Name -notmatch '^PS(Path|ParentPath|ChildName|Drive|Provider)$'
    }

    return $ozellikler
}

function Kayit-Degerini-Bicimlendir {
    param([object]$Deger)

    if ($null -eq $Deger) { return '<null>' }

    if ($Deger -is [byte[]]) {
        return ('byte[{0}] {1}' -f $Deger.Length, (($Deger | Select-Object -First 24 | ForEach-Object { $_.ToString('X2') }) -join ' '))
    }

    if ($Deger -is [string[]]) {
        return ($Deger -join '; ')
    }

    return [string]$Deger
}

function MRUListEx-Donustur {
    param([byte[]]$ByteDizisi)

    $sira = @()
    if (-not $ByteDizisi -or $ByteDizisi.Length -lt 4) { return $sira }

    for ($i = 0; $i -le $ByteDizisi.Length - 4; $i += 4) {
        $n = [BitConverter]::ToInt32($ByteDizisi, $i)
        if ($n -eq -1) { break }
        $sira += $n
    }

    return $sira
}

function Byte-Stringlerini-Cikar {
    param(
        [byte[]]$ByteDizisi,
        [int]$MinimumUzunluk = 4
    )

    $sonuclar = New-Object System.Collections.Generic.List[string]
    if (-not $ByteDizisi -or $ByteDizisi.Length -eq 0) { return @() }

    $unicode = [System.Text.Encoding]::Unicode.GetString($ByteDizisi)
    $uEslesmeler = [regex]::Matches($unicode, "[\u0020-\u007E\u00A0-\u024F\\\/:\._ \-\(\)\[\]]{$MinimumUzunluk,}")
    foreach ($m in $uEslesmeler) {
        $s = $m.Value.Trim()
        if ($s.Length -ge $MinimumUzunluk -and -not $sonuclar.Contains($s)) {
            $sonuclar.Add($s)
        }
    }

    $ascii = [System.Text.Encoding]::ASCII.GetString($ByteDizisi)
    $aEslesmeler = [regex]::Matches($ascii, "[ -~]{${MinimumUzunluk},}")
    foreach ($m in $aEslesmeler) {
        $s = $m.Value.Trim()
        if ($s.Length -ge $MinimumUzunluk -and -not $sonuclar.Contains($s)) {
            $sonuclar.Add($s)
        }
    }

    return $sonuclar.ToArray()
}

function Prefetch-Yapilandirmasini-Goster {
    $yol = 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters'

    Bolum-Yaz 'Prefetch Yapılandırması'
    Bilgi-Yaz 'Registry Yolu' $yol

    if (-not (Test-Path $yol)) {
        Write-Host "Anahtar bulunamadı." -ForegroundColor Yellow
        return
    }

    $oge = Get-ItemProperty -Path $yol
    $enablePrefetcher = $oge.EnablePrefetcher
    $enableSuperfetch = $oge.EnableSuperfetch
    $bootId = $oge.BootId

    Bilgi-Yaz 'EnablePrefetcher' $enablePrefetcher
    switch ($enablePrefetcher) {
        0 { Write-Host '  -> Devre dışı' -ForegroundColor Yellow }
        1 { Write-Host '  -> Uygulama başlatma prefetch açık' -ForegroundColor Green }
        2 { Write-Host '  -> Boot prefetch açık' -ForegroundColor Green }
        3 { Write-Host '  -> Boot + uygulama prefetch açık' -ForegroundColor Green }
        default { Write-Host '  -> Bilinmeyen / standart dışı değer' -ForegroundColor Red }
    }

    if ($null -ne $enableSuperfetch) {
        Bilgi-Yaz 'EnableSuperfetch' $enableSuperfetch
    }

    if ($null -ne $bootId) {
        Bilgi-Yaz 'BootId' $bootId
    }

    Write-Host ""
    Write-Host "Anahtar altındaki tüm değerler:" -ForegroundColor DarkCyan
    $ozellikler = Kayit-Degerlerini-Al -Yol $yol
    foreach ($p in $ozellikler) {
        Bilgi-Yaz $p.Name (Kayit-Degerini-Bicimlendir $p.Value)
    }
}

function RunOnce-Goster {
    $yollar = @(
        'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce',
        'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce'
    )

    foreach ($yol in $yollar) {
        $baslik = if ($yol -like 'HKCU*') {
            'RunOnce (Geçerli Kullanıcı)'
        } else {
            'RunOnce (Tüm Kullanıcılar / Makine)'
        }

        Bolum-Yaz $baslik
        Bilgi-Yaz 'Registry Yolu' $yol

        if (-not (Test-Path $yol)) {
            Write-Host "Anahtar bulunamadı." -ForegroundColor Yellow
            continue
        }

        $ozellikler = Kayit-Degerlerini-Al -Yol $yol
        if (-not $ozellikler -or $ozellikler.Count -eq 0) {
            Write-Host "Bekleyen RunOnce girdisi yok." -ForegroundColor Green
            continue
        }

        foreach ($p in $ozellikler) {
            Write-Host ""
            Bilgi-Yaz 'Değer Adı' $p.Name
            Bilgi-Yaz 'Komut' $p.Value
        }
    }
}

function OpenSavePidlMRUJar-Goster {
    $yol = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\OpenSavePidlMRU\jar'

    Bolum-Yaz 'OpenSavePidlMRU\jar'
    Bilgi-Yaz 'Registry Yolu' $yol

    if (-not (Test-Path $yol)) {
        Write-Host "Anahtar bulunamadı." -ForegroundColor Yellow
        return
    }

    $oge = Get-ItemProperty -Path $yol
    $ozellikler = $oge.PSObject.Properties | Where-Object {
        $_.Name -notmatch '^PS(Path|ParentPath|ChildName|Drive|Provider)$'
    }

    $mruOzelligi = $ozellikler | Where-Object Name -eq 'MRUListEx'
    if ($mruOzelligi) {
        $sira = MRUListEx-Donustur -ByteDizisi $mruOzelligi.Value
        Bilgi-Yaz 'MRU Sırası' (($sira | ForEach-Object { $_.ToString() }) -join ' -> ')
    } else {
        Write-Host "MRUListEx bulunamadı." -ForegroundColor Yellow
        $sira = @()
    }

    $girdiOzellikleri = $ozellikler | Where-Object { $_.Name -ne 'MRUListEx' }

    if (-not $girdiOzellikleri) {
        Write-Host "jar için MRU girdisi bulunamadı." -ForegroundColor Yellow
        return
    }

    $siraliGirdiler =
        if ($sira.Count -gt 0) {
            foreach ($idx in $sira) {
                $eslesen = $girdiOzellikleri | Where-Object Name -eq ([string]$idx)
                if ($eslesen) { $eslesen }
            }
        } else {
            $girdiOzellikleri | Sort-Object Name
        }

    foreach ($p in $siraliGirdiler) {
        Write-Host ""
        Write-Host ("--- Girdi {0} ---" -f $p.Name) -ForegroundColor Magenta

        $ham = $p.Value
        if ($ham -isnot [byte[]]) {
            Bilgi-Yaz 'Tür' $p.TypeNameOfValue
            Bilgi-Yaz 'Veri' (Kayit-Degerini-Bicimlendir $ham)
            continue
        }

        Bilgi-Yaz 'Tür' 'PIDL / Binary blob'
        Bilgi-Yaz 'Ham Boyut' ("{0} byte" -f $ham.Length)
        Bilgi-Yaz 'Hex Önizleme' (($ham | Select-Object -First 32 | ForEach-Object { $_.ToString('X2') }) -join ' ')

        $stringler = Byte-Stringlerini-Cikar -ByteDizisi $ham -MinimumUzunluk 4
        if ($stringler.Count -gt 0) {
            Write-Host "Okunabilir string / path ipuçları:" -ForegroundColor DarkCyan
            $stringler | Select-Object -First 12 | ForEach-Object {
                Write-Host ("  - {0}" -f $_)
            }
        } else {
            Write-Host "Blob içinden okunabilir string çıkarılamadı." -ForegroundColor Yellow
        }
    }

    Write-Host ""
    Write-Host "Not: OpenSavePidlMRU girdileri Shell / PIDL blob formatındadır." -ForegroundColor DarkYellow
    Write-Host "Bu script tam forensic parser değildir; best-effort string çıkarımı yapar." -ForegroundColor DarkYellow
}

function Registry4657Eventlerini-Goster {
    Bolum-Yaz 'Security Event Log - Event ID 4657'

    try {
        $eventler = Get-WinEvent -FilterHashtable @{
            LogName = 'Security'
            Id      = 4657
        } -MaxEvents 300
    }
    catch {
        Write-Host "Security log sorgulanamadı. PowerShell'i yönetici olarak çalıştırmayı dene." -ForegroundColor Red
        return
    }

    if (-not $eventler) {
        Write-Host "Sorgulanan aralıkta 4657 eventi bulunamadı." -ForegroundColor Yellow
        Write-Host "Hatırlatma: 4657 ancak Audit Registry açıksa ve ilgili key üzerinde Set Value auditing varsa görünür." -ForegroundColor DarkYellow
        return
    }

    $cozulenler = foreach ($evt in $eventler) {
        try {
            $xml = [xml]$evt.ToXml()
            $veriHaritasi = @{}
            foreach ($d in $xml.Event.EventData.Data) {
                $veriHaritasi[$d.Name] = $d.'#text'
            }

            [PSCustomObject]@{
                Zaman           = $evt.TimeCreated
                ObjectName      = $veriHaritasi['ObjectName']
                ObjectValueName = $veriHaritasi['ObjectValueName']
                OperationType   = $veriHaritasi['OperationType']
                OldValueType    = $veriHaritasi['OldValueType']
                OldValue        = $veriHaritasi['OldValue']
                NewValueType    = $veriHaritasi['NewValueType']
                NewValue        = $veriHaritasi['NewValue']
                ProcessName     = $veriHaritasi['ProcessName']
                SubjectUserName = $veriHaritasi['SubjectUserName']
            }
        } catch {}
    }

    $filtrelenenler = $cozulenler | Where-Object {
        $obj = $_.ObjectName
        if (-not $obj) { return $false }

        ($obj -like '*PrefetchParameters*') -or
        ($obj -like '*\CurrentVersion\RunOnce*') -or
        ($obj -like '*\Explorer\ComDlg32\OpenSavePidlMRU\jar*') -or
        ($obj -like '*\Policies\Microsoft\Windows\AppCompat*')
    }

    if (-not $filtrelenenler) {
        Write-Host "Hedeflenen key'ler için eşleşen 4657 eventi bulunamadı." -ForegroundColor Yellow
        Write-Host "4657, registry VALUE değişikliklerini loglar; sadece key'e bakılmış olmasını loglamaz." -ForegroundColor DarkYellow
        return
    }

    foreach ($e in $filtrelenenler | Sort-Object Zaman -Descending) {
        Write-Host ""
        Write-Host ("[{0}]" -f $e.Zaman) -ForegroundColor Green
        Bilgi-Yaz 'ObjectName' $e.ObjectName
        Bilgi-Yaz 'ValueName' $e.ObjectValueName
        Bilgi-Yaz 'İşlem' $e.OperationType
        Bilgi-Yaz 'Eski Tür' $e.OldValueType
        Bilgi-Yaz 'Eski Değer' $e.OldValue
        Bilgi-Yaz 'Yeni Tür' $e.NewValueType
        Bilgi-Yaz 'Yeni Değer' $e.NewValue
        Bilgi-Yaz 'Process' $e.ProcessName
        Bilgi-Yaz 'Kullanıcı' $e.SubjectUserName
    }
}

function EventLog-Temizleme-Izlerini-Goster {
    Bolum-Yaz 'Event Log Temizleme İzleri (Event ID 104)'

    $aranacakLoglar = @(
        'System',
        'Application',
        'Security'
    )

    $sonuclar = @()

    foreach ($logAdi in $aranacakLoglar) {
        try {
            $eventler = Get-WinEvent -FilterHashtable @{
                LogName = $logAdi
                Id      = 104
            } -MaxEvents 100

            foreach ($evt in $eventler) {
                try {
                    $xml = [xml]$evt.ToXml()
                    $veriHaritasi = @{}

                    foreach ($d in $xml.Event.EventData.Data) {
                        $veriHaritasi[$d.Name] = $d.'#text'
                    }

                    $sonuclar += [PSCustomObject]@{
                        Zaman      = $evt.TimeCreated
                        Log        = $logAdi
                        Saglayici  = $evt.ProviderName
                        Kullanici  = $veriHaritasi['SubjectUserName']
                        Kanal      = $veriHaritasi['Channel']
                        Bilgisayar = $evt.MachineName
                    }
                } catch {
                    $sonuclar += [PSCustomObject]@{
                        Zaman      = $evt.TimeCreated
                        Log        = $logAdi
                        Saglayici  = $evt.ProviderName
                        Kullanici  = '<çözülemedi>'
                        Kanal      = '<çözülemedi>'
                        Bilgisayar = $evt.MachineName
                    }
                }
            }
        }
        catch {
            Write-Host "$logAdi logu sorgulanamadı." -ForegroundColor Yellow
        }
    }

    if (-not $sonuclar -or $sonuclar.Count -eq 0) {
        Write-Host "Event ID 104 bulunamadı." -ForegroundColor Green
        Write-Host "Bu, logların hiç temizlenmediği anlamına gelebilir; ama eski kayıtların üstüne yazılmış olması da mümkündür." -ForegroundColor DarkYellow
        return
    }

    foreach ($s in $sonuclar | Sort-Object Zaman -Descending) {
        Write-Host ""
        Write-Host ("[{0}]" -f $s.Zaman) -ForegroundColor Red
        Bilgi-Yaz 'Log' $s.Log
        Bilgi-Yaz 'Provider' $s.Saglayici
        Bilgi-Yaz 'Kanal' $s.Kanal
        Bilgi-Yaz 'Kullanıcı' $s.Kullanici
        Bilgi-Yaz 'Bilgisayar' $s.Bilgisayar
    }

    Write-Host ""
    Write-Host "Not: 104 görmek, ilgili event log kanalının temizlendiğine işaret edebilir." -ForegroundColor DarkYellow
}

function AppCompat-Policy-Goster {
    Bolum-Yaz 'AppCompat Policy Kontrolü (DisablePCA)'

    $yollar = @(
        'HKCU:\SOFTWARE\Policies\Microsoft\Windows\AppCompat',
        'HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat'
    )

    foreach ($yol in $yollar) {
        Write-Host ""
        Bilgi-Yaz 'Registry Yolu' $yol

        if (-not (Test-Path $yol)) {
            Write-Host "Anahtar bulunamadı." -ForegroundColor Yellow
            continue
        }

        $oge = Get-ItemProperty -Path $yol
        $disablePCA = $oge.DisablePCA

        if ($null -eq $disablePCA) {
            Write-Host "DisablePCA değeri bulunamadı." -ForegroundColor Green
        } else {
            Bilgi-Yaz 'DisablePCA' $disablePCA

            switch ($disablePCA) {
                0 {
                    Write-Host "  -> PCA devre dışı değil." -ForegroundColor Green
                }
                1 {
                    Write-Host "  -> PCA policy ile kapatılmış görünüyor." -ForegroundColor Red
                    Write-Host "  -> Bu durum ek kontrol gerektirebilir." -ForegroundColor DarkYellow
                }
                default {
                    Write-Host "  -> Standart dışı değer." -ForegroundColor Yellow
                }
            }
        }

        Write-Host "Anahtar altındaki tüm değerler:" -ForegroundColor DarkCyan
        $ozellikler = Kayit-Degerlerini-Al -Yol $yol
        if ($ozellikler) {
            foreach ($p in $ozellikler) {
                Bilgi-Yaz $p.Name (Kayit-Degerini-Bicimlendir $p.Value)
            }
        }
    }
}

# =========================
# merhaba :)
# =========================

Bolum-Yaz 'Registry / Event Hızlı Analiz'
Write-Host "Bu script sadece konsola çıktı verir." -ForegroundColor DarkCyan

Prefetch-Yapilandirmasini-Goster
RunOnce-Goster
OpenSavePidlMRUJar-Goster
Registry4657Eventlerini-Goster
EventLog-Temizleme-Izlerini-Goster
AppCompat-Policy-Goster

Write-Host ""
Write-Host "Tamamlandı." -ForegroundColor Cyan
